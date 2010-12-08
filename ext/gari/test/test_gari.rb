require 'test_helper.rb'
require 'gari'


assert { Gari           } 
assert { Gari::Game     }
assert { Gari::Sound    }
assert { Gari::Music    }
assert { Gari::Color    }
assert { Gari::Dye      }
assert { Gari::Event    }
assert { Gari::Flow     }
assert { Gari::Font     }
assert { Gari::Image    }
assert { Gari::Joystick }
assert { Gari::Screen   }
assert { Gari::Layer    }
assert { Gari::Sheet    }
  
game = Gari::Game.new
assert { game } 
assert { game.frames == 0 }
game.startfps
game.nextframe 
assert { game.frames == 1 }
assert { game.fps > 0.0  }
game.resetframes
assert { game.frames == 0 }
  
screen = game.openscreen(640, 480, false)
assert { screen                     } 
assert { !game.fullscreen           }
assert { !screen.fullscreen         }
assert { screen.depth > 0           } 

ri      = Gari::Image.loadraw('test/test_tile.png')
assert  { ri                        } 
assert  { ri.w == 40                }
assert  { ri.h == 40                }
assert  { ri.depth == 24            }
assert  { Gari::Image::SOLID        } 
assert  { Gari::Image::COLORKEY     }
assert  { Gari::Image::ALPHA        } 
oi      = ri.optimize(Gari::Image::SOLID, 0)
assert  { oi                        } 
assert  { oi.w == ri.w              }
assert  { oi.h == ri.w              }
assert  { oi.depth == screen.depth  }

ni      = Gari::Image.new(ri.w, ri.h, screen.depth, Gari::Image::ALPHA)
assert  { ni                        } 
assert  { ni.w == ri.w              }
assert  { ni.h == ri.w              }
assert  { ni.depth == screen.depth  }
gi      = Gari::Image.loadraw('test/test_bg.png')
assert { gi } 
go      = gi.optimize(Gari::Image::ALPHA, 0)
assert { go }
si      = Gari::Image.loadraw('test/test_sprite_1.png')
so      = si.optimize(Gari::Image::ALPHA, 0)


assert  { ni.clip? == [ 0, 0, ri.w, ri.h ]          }
assert  { ni.clip!(5, 5, ri.w - 5, ri.h - 5 )       }
assert  { ni.clip? == [ 5, 5, ri.w - 5, ri.h - 5 ]  }
assert  { ni.clip!(0, 0, ri.w, ri.h)                }
assert  { ni.clip? == [ 0, 0, ri.w, ri.h ]          }

# Colors must be optimized before use, otherwise they won't fit the 16 bits
# image if the screen depth is 16 bits.
c0      = Gari::Color.new(1  ,  1,  1, 255).optimize(ni)
c1      = Gari::Color.new(20 , 40, 255, 255).optimize(ni)
c2      = Gari::Color.new(255, 50, 20, 255).optimize(ni)
c3      = Gari::Color.new(20 , 255, 60, 255).optimize(ni)
c4      = Gari::Color.new(20 , 40, 255, 255).optimize(ni)
cgray   = Gari::Color.new(80 , 80, 80, 255).optimize(ni)
cfull   = Gari::Color.new(128, 255, 0, 255)
chalf   = Gari::Color.new(255, 255, 0, 127)
ctrans  = Gari::Color.new(255, 128, 0,   0)

p chalf
p ctrans

d0      = c0.dye(ni)
d1      = c1.dye(ni)
d2      = c2.dye(ni)
d3      = c3.dye(ni)
d4      = c4.dye(ni)

assert  { ni.dyecolor(d0) == c0 }
assert  { ni.dyecolor(d1) == c1 }
assert  { ni.dyecolor(d2) == c2 }
assert  { ni.dyecolor(d3) == c3 }

assert  { c1       }
assert  { c2       } 
assert  { c1 == c1 }
assert  { c2 == c2 } 
assert  { c3 == c3 }
assert  { c4 == c1 }
assert  { c1 == c4 }
assert  { (c4 <=> c1) == 0 }
assert  { (c2 <=> c1) == 1 }

# Test Drawing, checking with dot?
screen.slab(0, 0, screen.w, screen.h, cgray)
 
ni.slab(0, 0, ni.w, ni.h, c2)
assert  { ni.dot?(0, 0, c2)  }
ni.box(0, 0, ni.w, ni.h, c1)
assert  { ni.dot?(0, 0, c1)  }
ni.hoop(0, 0, ni.w, c3)
assert  { ni.dot?(ni.w_half, 0, c3)  }
ni.disk(0, 0, ni.w, c1)
assert  { ni.dot?(ni.w_half, ni.h_half, c1) }

screen.slab(100, 0, 20, 20, ctrans)
screen.slab(120, 0, 20, 20, chalf)

screen.blit(150, 0, si)
screen.blit(200, 0, so)


screen.blit(10, 10, ni)
# screen.blitscale(100, 100, 40, 80, go, 0, 0, go.w, go.h)

old = screen.getdot(300 + si.w, 100 + si.h)
screen.blitscale(300, 100, si.w , si.h, si,  0 , 0, si.w, si.h)
# check if scaling without actually scaling preserves the size
assert { screen.dot?(300 + si.w, 100 + si.h, old) }

old = screen.getdot(300 + so.w, 200 + so.h)
screen.blitscale(300, 200, so.w , so.h, so,  0 , 0, so.w, so.h)
# check if scaling without actually scaling preserves the size
assert { screen.dot?(300 + so.w, 200 + so.h, old) }

screen.blitscale(300, 280, 40, 20, go,  0       , 20, 20, 20)
screen.blitscale(300, 300, 20, 20, go,  0       , 20, 20, 20)

screen.blitscale(120, 100, 60, 20, go, 20       , 0, 60, 20)
screen.blitpart(100, 100, go,  0       , 0, 20, 20)
screen.blitpart(180, 100, go, go.w - 20, 0, 20, 20)

dstmidh = 40
srcmidh = go.h - (2 * 20)

screen.blitscale(100, 120, 20, dstmidh, go, 0        , 20, 20, srcmidh)
screen.blitscale(120, 120, 60, dstmidh, go, 20       , 20, 60, srcmidh)
screen.blitscale(180, 120, 20, dstmidh, go, go.w - 20, 20, 20, srcmidh)


screen.blitscale(120, 160, 60, 20, go, 20       , go.h - 20, 60, 20)
screen.blitpart(100, 160, go,  0       , go.h - 20, 20, 20)
screen.blitpart(180, 160, go, go.w - 20, go.h - 20, 20, 20)


screen.blitscale9(go, 200, 300, 100, 200)

game.update
busy = true
start = Time.now
while busy 
  ev = Gari::Event.poll
  # Close when clicking the close button, or after no events for 5 seconds
  if ev && ev.kind == Gari::Event::QUIT
    busy = false
  elsif ev 
    start = Time.now
  end  
  busy = false if (Time.now - start) > 5
  game.update
end  
# sleep 10



#   
#   RBH_METHOD(Image, optimize  , rbgari_image_optimize   , 2);
#   RBH_METHOD(Image, slab      , rbgari_image_slab       , 5);
#   RBH_METHOD(Image, box       , rbgari_image_box        , 5);
#   RBH_METHOD(Image, line      , rbgari_image_line       , 5);
#   RBH_METHOD(Image, disk      , rbgari_image_disk       , 4);
#   RBH_METHOD(Image, hoop      , rbgari_image_hoop       , 4);
#   RBH_METHOD(Image, flood     , rbgari_image_flood      , 3);
#   RBH_METHOD(Image, blendslab , rbgari_image_blendslab  , 5);  
#   RBH_METHOD(Image, blendbox  , rbgari_image_blendbox   , 5);
#   RBH_METHOD(Image, blendline , rbgari_image_blendline  , 5);
#   RBH_METHOD(Image, blenddisk , rbgari_image_blenddisk  , 4);
#   RBH_METHOD(Image, blendhoop , rbgari_image_blendhoop  , 4);
#   RBH_METHOD(Image, blendflood, rbgari_image_blendflood , 3);
# 
#   RBH_METHOD(Image, dot       , rbgari_image_dot        , 3);
#   RBH_METHOD(Image, getdot    , rbgari_image_getdot     , 2);
#   RBH_METHOD(Image, blit      , rbgari_image_blit       , 3);
#   RBH_METHOD(Image, blitpart  , rbgari_image_blitpart   , 7);
#   RBH_METHOD(Image, blitscale , rbgari_image_scaleblit  , 9);
#   // RBH_METHOD(Image,   , rbgari_image_ , );
#   
#   
#   RBH_METHOD(Color, dye       , rbgari_color_dye, 1);
#   
#   
#   RBH_SINGLETON_METHOD(Color, new , rbgari_color_new, 4);
#   RBH_SINGLETON_METHOD(Color, rgba, rbgari_color_new, 4);
#   RBH_SINGLETON_METHOD(Color, rgb , rbgari_color_newrgb, 3);
#   RBH_GETTER(Color, r, gari_color_r);
#   RBH_GETTER(Color, g, gari_color_g);
#   RBH_GETTER(Color, b, gari_color_b);
#   RBH_GETTER(Color, a, gari_color_a);
#   
#   RBH_CLASS_NUM_CONST(Event, NONE         , GARI_EVENT_NONE);
#   RBH_CLASS_NUM_CONST(Event, ACTIVE       , GARI_EVENT_ACTIVE);
#   RBH_CLASS_NUM_CONST(Event, KEYDOWN      , GARI_EVENT_KEYDOWN);
#   RBH_CLASS_NUM_CONST(Event, KEYUP        , GARI_EVENT_KEYUP);
#   RBH_CLASS_NUM_CONST(Event, MOUSEPRESS   , GARI_EVENT_MOUSEPRESS);
#   RBH_CLASS_NUM_CONST(Event, MOUSERELEASE , GARI_EVENT_MOUSERELEASE);
#   RBH_CLASS_NUM_CONST(Event, MOUSEMOVE    , GARI_EVENT_MOUSEMOVE);
#   RBH_CLASS_NUM_CONST(Event, MOUSESCROLL  , GARI_EVENT_MOUSESCROLL);
#   RBH_CLASS_NUM_CONST(Event, JOYMOVE      , GARI_EVENT_JOYMOVE);
#   RBH_CLASS_NUM_CONST(Event, JOYPRESS     , GARI_EVENT_JOYPRESS);
#   RBH_CLASS_NUM_CONST(Event, JOYRELEASE   , GARI_EVENT_JOYRELEASE);
#   RBH_CLASS_NUM_CONST(Event, RESIZE       , GARI_EVENT_RESIZE);
#   RBH_CLASS_NUM_CONST(Event, EXPOSE       , GARI_EVENT_EXPOSE);
#   RBH_CLASS_NUM_CONST(Event, QUIT         , GARI_EVENT_QUIT);
#   RBH_CLASS_NUM_CONST(Event, USER         , GARI_EVENT_USER);
#   RBH_CLASS_NUM_CONST(Event, SYSTEM       , GARI_EVENT_SYSTEM);
#   
#   RBH_SINGLETON_METHOD(Event, poll        , rbgari_event_poll, 0);
#   RBH_METHOD(Event, kind    , rbgari_event_kind     , 0);
#   RBH_METHOD(Event, gain    , rbgari_event_gain     , 0);
#   RBH_METHOD(Event, key     , rbgari_event_key      , 0);
#   RBH_METHOD(Event, mod     , rbgari_event_mod      , 0);
#   RBH_METHOD(Event, unicode , rbgari_event_unicode  , 0);
#   RBH_METHOD(Event, x       , rbgari_event_x        , 0);
#   RBH_METHOD(Event, y       , rbgari_event_y        , 0);
#   RBH_METHOD(Event, xrel    , rbgari_event_xrel     , 0);
#   RBH_METHOD(Event, yrel    , rbgari_event_yrel     , 0);
#   RBH_METHOD(Event, w       , rbgari_event_w        , 0);
#   RBH_METHOD(Event, h       , rbgari_event_h        , 0);
#   RBH_METHOD(Event, button  , rbgari_event_button   , 0);
#   RBH_METHOD(Event, value   , rbgari_event_value    , 0);
#   RBH_METHOD(Event, which   , rbgari_event_which    , 0);
#   RBH_METHOD(Event, axis    , rbgari_event_axis     , 0);
#   
#   RBH_CLASS_NUM_CONST(Font, ALPHA_SOLID, GARI_ALPHA_SOLID);
#   RBH_CLASS_NUM_CONST(Font, ALPHA_CLEAR, GARI_ALPHA_CLEAR);
#   
#   RBH_SINGLETON_METHOD(Font , new   , rbgari_font_new   , 2);
#   RBH_SINGLETON_METHOD(Font , error , rbgari_font_error , 0);
#   RBH_SINGLETON_METHOD(Font , mode  , rbgari_font_mode  , 0);
#   RBH_SINGLETON_METHOD(Font , mode= , rbgari_font_mode_ , 1);
#   RBH_SINGLETON_METHOD(Image, text  , rbgari_font_draw  , 6);
#   
#   RBH_CLASS_NUM_CONST(Font  , BLENDED , GariFontBlended); 
#   RBH_CLASS_NUM_CONST(Font  , SHADED  , GariFontSolid);
#   RBH_CLASS_NUM_CONST(Font  , SOLID   , GariFontShaded);
#   
#   RBH_METHOD(Game           , openaudio , rbgari_game_openaudio , 1);
#   RBH_SINGLETON_METHOD(Sound, new       , rbgari_sound_new      , 1);
#   RBH_METHOD(Sound          , play      , rbgari_sound_play     , 0);
#   RBH_SINGLETON_METHOD(Music, new       , rbgari_music_new      , 1);
#   RBH_METHOD(Music          , fade_in   , rbgari_music_fadein   , 0);
#   RBH_METHOD(Music          , fade_out  , rbgari_music_fadeout  , 0);
#   
#   RBH_SINGLETON_METHOD(Joystick , amount    , rbgari_joy_amount         , 0);
#   RBH_SINGLETON_METHOD(Joystick , name      , rbgari_joy_nameindex      , 1);
#   RBH_SINGLETON_METHOD(Joystick , new       , rbgari_joy_new            , 1);
#   RBH_METHOD(Joystick           , name      , rbgari_joy_name           , 0);
#   RBH_METHOD(Joystick           , axes      , rbgari_joy_axes           , 0);
#   RBH_METHOD(Joystick           , buttons   , rbgari_joy_buttons        , 0);
#   RBH_METHOD(Joystick           , balls     , rbgari_joy_balls          , 0);
#   RBH_METHOD(Joystick           , index     , rbgari_joy_index          , 0);
#   
#   RBH_METHOD(Game               , joysticks , rbgari_game_numjoysticks  , 0);
#   RBH_METHOD(Game               , joystick  , rbgari_game_joystick      , 1);
#     
#   RBH_SINGLETON_METHOD(Style    , new       , rbgari_style_new          , 4);
#   RBH_METHOD(Style              , font      , rbgari_style_font         , 0);
#   
#   RBH_SINGLETON_METHOD(Sheet    , new         , rbgari_sheet_new        , 1);
#   RBH_METHOD(Sheet              , image=      , rbgari_sheet_image_     , 1);
#   RBH_METHOD(Sheet              , image       , rbgari_sheet_image      , 0);
#   RBH_METHOD(Image              , blitsheet   , rbgari_image_blitsheet  , 3);
#   
#   RBH_SINGLETON_METHOD(Layer    , new         , rbgari_layer_new        , 4);  
#   RBH_GETTER(Layer, w           , gari_layer_wide);
#   RBH_GETTER(Layer, h           , gari_layer_high);
#   RBH_GETTER(Layer, tilewide    , gari_layer_tilewide);
#   RBH_GETTER(Layer, tilehigh    , gari_layer_tilehigh);
#   RBH_GETTER(Layer, gridwide    , gari_layer_gridwide);
#   RBH_GETTER(Layer, gridhigh    , gari_layer_gridhigh);  
#   RBH_METHOD(Layer              , outside?    , rbgari_layer_outside    , 2);
#   RBH_METHOD(Layer              , set         , rbgari_layer_set        , 3);
#   RBH_METHOD(Layer              , get         , rbgari_layer_get        , 2);
#   RBH_METHOD(Layer              , draw        , rbgari_layer_draw       , 3);