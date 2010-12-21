#
#
# Lexer for the JRaku minimal parser/interpreter/compiler
#
#

require 'strscan'

module Raku
   # A Fail is used for anything that fails.
   module Fail
     def fail!(msg = "")
       @fail_message = msg
       @fail_failed  = true
       return self
     end

     def fail?()
       @fail_failed  ||= false
       return @fail_failed
     end

     def fail_message()
       return @fail_message
     end
   end

   # A token is the result of a single step of the lexer
   class Token
     include Fail
     attr_reader :kind
     attr_reader :value

     def initialize(kind, value = "", line = 0, col = 0)
       @kind   = kind.to_sym
       @value  = value
       @line   = line
       @col    = col
       if kind == :fail then
        self.fail!(value)
       end
     end
   end

   class Lexer
      
      attr_reader :line
      attr_reader :col
      
      # Initialize the lexer with empty text
      def initialize(text = "")
        text ||= ""
        # start with an empty scan string/
        @text   = text
        @scan   = StringScanner.new(@text)
        @line   = 0
        @col    = 0
      end

      # Append text to the text to be lexed by the lexer.
      def <<(text)
        @scan << text
      end

      # Generates a token. shortcut to Token.new
      def token(kind, value = "")
        return Token.new(kind, value, @line, @col)
      end
      
      # Generates a token. shortcut to Token.new, but only if text is not nil
      # returns nil if text or kind is nil
      def try_token(kind, value = nil)
        return nil if (!kind || !value) 
        return Token.new(kind, value, @line, @col)
      end


      # scans self, automatically advancing line and col
      def scan(pattern)
        res = @scan.scan(pattern)
        return res unless res
        # advance col and line if we were able to parse some tokens off.
        aid = res.split(/\r\n|\n|\r/)
        @line += aid.size
        @col  += aid.last.size
        return res
      end

      # gets the next character from self, as a string.
      # Automatically advances line and col
      def getch()
        ch = @scan.getch
        return ch unless ch
        # advance col and line if we were able to parse some tokens off.
        @line += 1 if ch == "\n" || ch == "\r"
        @col  += ch.size
        return ch
      end
      
      # puts back the next character from self, as a string.
      # Automatically advances line and col
      def ungetch(ch)
        @scan.unscan 
        # reset col and line if we were able to parse some tokens off.
        @line -= 1 if ch == "\n" || ch == "\r"
        @col  -= ch.size
        return ch
      end
      
      
      # Checks if the next character or string is the one requested or not
      # uses peek to look forward
      def checkch(str)
        # getch
        return nil
      end
       

      # Tries to lex an escaped newline, or a newline.
      def lex_nl
        res = scan(/\\[ \t]*(\r\n|\r|\n)+/)
        return token(:esc_nl, res) if res
        res = scan(/(\r\n|\r|\n)+/)
        return try_token(:nl, res)
      end


      # Tries to lex whitespace. returns a token on success, nil on failiure.
      def lex_ws
        res = scan(/[ \t]+/)        
        return try_token(:ws, res)
      end

      # Tries to lex keywords, brackets, special operators and separators
      def lex_key
        search = {
          '('   => :lbrace,
          ')'   => :lbrace,
          '['   => :lbracket,
          ']'   => :rbracket,
          '{'   => :lcurly,
          '}'   => :rcurly,
          ':'   => :colon,
          ';'   => :semicolon,
          ','   => :comma,
          '.'   => :period,
        }
        for k, v in search do
          res = scan(Regexp.new("\#{k}"))
          return token(v, k) if res
        end
        return nil
      end

      # Tries to lex comments
      def lex_comment
        # Single line comment
        res = scan(%r{\#[^\r\n]+(\r\n|\r|\n)})
        return try_token(:comment, res) 
      end
      
      # Tries to lex symbols (start with a letter, and can contain letters, numbers and underscores)
      def lex_symbol
        # Symbols
        res = scan(%r{\w[\w\d_]+})
        return try_token(:symbol, res)
      end

      # Tries to lex operators (consist of one or more of &|@^!*%+-=/<>$
      def lex_operator
        # Operators
        res = scan(%r{[&|@^!*%+-=/<>$]+})
        return try_token(:operator, res)
      end
      
      # Tries to lex integer numbers
      def lex_int()
        res = scan(%r{\d[\w\d_]+})
        return try_token(:integer, res)
      end

      # Tries to lex floating point numbers
      def lex_float()
        res = scan(%r{\d[\d_]+(\.)?[\d_]+([eE]\d[\d_]+(\.)?[\d_]+)?})
        return try_token(:float, res)
      end

      #
      # tries to lex strings
      def lex_string()
        res = scan(%r{"([^"\\]|\\.)*"})
        return try_token(:string, res) 
      end

      LEX_ORDER = [ 
        :lex_comment,
        :lex_key,
        :lex_operator,
        :lex_symbol,
        :lex_float,
        :lex_int,
        :lex_string,
        :lex_nl, 
        :lex_ws,
      ]


      # Gets one token. Returns fail? on failure.
      def lex()        
        return token(:eof) if @scan.eos?
        # Try to lex the various possiblel exemes in the list. 
        for action in LEX_ORDER do 
          tok = self.send(action)
          return tok if tok 
          # If we find something, return it.
        end
        # If we got here, it all failed. 
        return Token.new(:fail, "Lex error text at #{@line}: #{@col}: #{@scan.peek(10)}.")
      end

   end
end



