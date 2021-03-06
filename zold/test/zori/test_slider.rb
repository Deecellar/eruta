require 'test_helper'
require 'test_widget_helper'

require 'gari'
require 'fimyfi'
require 'zori'

assert { Gari              }
assert { Zori::Slider      }


test_widget_interactively do
  slider  = Zori::Slider::Horizontal.new(:max => 69) do |v| 
    puts "Slider value changed #{v.value}" 
  end
  
  assert { slider } 
  
  slider
end

