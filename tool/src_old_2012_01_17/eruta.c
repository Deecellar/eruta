/**
* C only versus Ruby + C: 
*   Only                                      Mixed
**************************************************************************
* Slower to write                     * Faster to write
* More work cloning ruby stdlib       * More reuse of Ruby stdlib.
* Have to rewrite 7k SLOC ruby in C   * Can keep and enhance most Ruby work
* Must port some functionality myself * Can reuse some ruby functionality.
* Faster execution                    * Slower execution
* Easier to distribute                * More difficult to distribute
* Can use C libs immediately          * Maintain bindings to C libs
* Simplicity                          * Expressive power 
*
* Both:
* * Will probably write own scripting language anyway, based on Raku.
* * Need C anyway for libraries and bindings.
*
* Speed of writing depends, I guess. 
* 
* Useful ruby already written : +- 7k SLOC
* Ruby bindings to Gy: +- 1k SLOC + +- 500 SLOC Ruby support code.
* Rchipmunk ruby bindings: +- 1k SLOC +  300 SLOC Ruby support. 
*
* I checked so many languages, but as for now, only Ruby is and C are to my 
* liking. I dislike C++, Lua, etc. I'd love to write my own compiler but that's 
* yet another time sink. Go lang was also a time sinkhole. :p
* Last C try: 640 SLOC C in +- 1 to 2 days 
* Ruby parser: 1,043 SLOC ruby in +- 6 to 7 days.
* 
* C: I can also reuse and wrap/adapt existing libraries, like I did with 
* SDL/gari.
* toweriazekilameterionic     }{}{}{}{}{}{}{}{}{ [][][][][][][]
* 
*/

#include "gy.h"
#include "program.h"

int main(int argc, char* argv[]) {
  
  return 0;
}


