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
assert { screen } 
assert { !game.fullscreen  }
  
#   
#   RBH_SINGLETON_METHOD(Image, loadraw, rbgari_image_loadraw, 1);
#   RBH_SINGLETON_METHOD(Image, new    , rbgari_image_newdepth, 4);
#     
#   RBH_CLASS_NUM_CONST(Image, SOLID, GariImageSolid);
#   RBH_CLASS_NUM_CONST(Image, COLORKEY, GariImageColorkey);
#   RBH_CLASS_NUM_CONST(Image, ALPHA, GariImageAlpha);
# 
#   // RBH_METHOD(Game, loadimage  , rbgari_game_loadimage, 1);
#   
#   RBH_GETTER(Image, w         , gari_image_w);
#   RBH_GETTER(Image, h         , gari_image_h);
#   RBH_GETTER(Image, depth     , gari_image_depth);
#   RBH_METHOD(Image, clip?     , rbgari_image_getclip    , 0);
#   RBH_METHOD(Image, clip!     , rbgari_image_setclip    , 4);
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