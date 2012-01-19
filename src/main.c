#include "eruta.h"
#include "game.h"
#include "image.h"
#include "tile.h"
#include "tilepane.h"
#include "sound.h"

#define SCREEN_W 640
#define SCREEN_H 480
ALLEGRO_FONT* font;
ALLEGRO_TRANSFORM identity;
ALLEGRO_BITMAP* buffer;
ALLEGRO_BITMAP* texture;
ALLEGRO_COLOR   solid_white;

#define abort_example perror
#define ERUTA_TEST_SHEET "data/image/tile/tiles_village_1000.png"
/** For some reason, onlt wav music plays?
It seems there is a bug in init_dynlib() in the ogg driver nbut only
if Allegro is compiled in the default RelWithDbg mode.
***/
#define ERUTA_TEST_MUSIC "data/music/musictest.ogg"


int main(void) {
    Image    * sheet;
    Tileset  * tileset;
    Tile     * tile;
    Game     * game;
    Music    * music;
    Camera   * camera;
    Tilepane * tilepane = NULL;
    int        frames;
    double     fpstime, fps; 
    game = game_alloc();
    Point      mp = { -100, -100}, mv = {0, 0};
    if(!game_init(game, FALSE)) {
      perror(game_errmsg(game));
      return 1;      
    }
    camera = camera_new(-100, -100, SCREEN_W, SCREEN_H);
    if(!camera) 
    music = music_load(ERUTA_TEST_MUSIC);
    if(!music) perror(ERUTA_TEST_MUSIC);
    
    sheet = image_load(ERUTA_TEST_SHEET);
    if(!sheet) {
      perror(ERUTA_TEST_SHEET);
      return 1;
    }
    tileset = tileset_new(sheet);
    tile    = tileset_tile(tileset);
    tile_addframe(tile, 2);
    
    tilepane= tilepane_new(tileset, 100, 100);
    // tilepane_set(tilepane, 0, 0, tile);
    // tilepane_set(tilepane, 1, 1, tile);
    tilepane_fill(tilepane, tile);
    
    
    // tile_addframe(tile, 3);
    //tile_addanime(tile, TILE_ANIME_NEXT);
    //tile_addanime(tile, TILE_ANIME_REWIND);
    fpstime = al_get_time();
    fps     = 0;
    frames  = 0;
    while (game_busy(game)) {    
      ALLEGRO_EVENT event;
      double now = al_get_time();
      if (now > (fpstime + 1.0)) {
        fps    = ((double)frames) / (now - fpstime);
        fpstime= now;
        frames = 0;
      } else {
        frames++;
      }  
      
      while(game_poll(game, &event)) {
        switch (event.type) {
          case ALLEGRO_EVENT_DISPLAY_CLOSE:
            game_done(game);
            break;
            
          case ALLEGRO_EVENT_KEY_DOWN:
            switch(event.keyboard.keycode) {
              case ALLEGRO_KEY_UP:
                mv.y = -1;
              break;
              case ALLEGRO_KEY_DOWN:
                mv.y = +1;
              break;
              case ALLEGRO_KEY_LEFT:
                mv.x = -1;
              break;
              case ALLEGRO_KEY_RIGHT:
                mv.x = +1;
              break;
              default:
                game_done(game);
              break;
            }
            break;
         
        case ALLEGRO_EVENT_KEY_UP: 
          switch(event.keyboard.keycode) {
              case ALLEGRO_KEY_UP:
                mv.y = 0;
              break;
              case ALLEGRO_KEY_DOWN:
                mv.y = 0;
              break;
              case ALLEGRO_KEY_LEFT:
                mv.x = 0;
              break;
              case ALLEGRO_KEY_RIGHT:
                mv.x = 0;
              break;
              default:
              break;
          }
          break;
          
        default:
            break;
        }  
      }
      al_clear_to_color(game_color(game, ERUTA_BLACK));
      al_draw_line(0, 0, SCREEN_W, SCREEN_H, game_color(game, ERUTA_WHITE), 7);
      
      /*tilepane_draw(tilepane, camera);
      tilepane_draw(tilepane, camera);
      tilepane_draw(tilepane, camera);
      tilepane_draw(tilepane, camera);
      */
      camera_speed_(camera, mv);
      camera_update(camera);
      
      tile_draw(tile, 200, 300);
      tile_update(tile);
      game_frames_update(game);
      al_draw_textf(game_font(game), game_color(game, ERUTA_WHITE),
                        10, 10, 0, "FPS: %lf, %d", game_fps(game), game_frames(game));
   
      al_flip_display();
   }
   tilepane_free(tilepane);
   tileset_free(tileset);
   camera_free(camera);
   game_done(game);
   game_free(game);
   return 0;
}
