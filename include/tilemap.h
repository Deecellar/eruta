#ifndef TILEMAP_H
#define TILEMAP_H

typedef struct Tilemap_ Tilemap;

#include "area.h"
#include "tile.h"
#include "tilepane.h"

/* Tile maps have at most 4 panes. */
#define TILEMAP_PANES 4


Image * image_loadtexture (const char * category , int index );

Tilemap * tilemap_done (Tilemap * self );

Tilemap * tilemap_init (Tilemap * self , Tileset * set , int w , int h, Area * areq );

Tilemap * tilemap_free (Tilemap * map );

Tilemap * tilemap_new (Tileset * set , int w , int h, Area * area );

int tilemap_panes(Tilemap * self);


Tilepane * tilemap_pane (Tilemap * self , int index );

Tilepane * tilemap_pane_ (Tilemap * self , int index , Tilepane * pane );

Tilepane * tilemap_panenew (Tilemap * self , int index , int w , int h );

Tile * tilemap_get (Tilemap * self , int l , int x , int y );

int tile_thingkind (Tile * tile );

Thing * tilemap_tiletothing (Tilemap * self , int l , int x , int y , Tile * tile );

Tile * tilemap_settile (Tilemap * self , int l , int x , int y , Tile * tile );

Tile * tilemap_setindex (Tilemap * self , int l , int x , int y , int index );

Tile * tilemap_rect (Tilemap * self , int l , int x , int y , int w , int h , Tile * tile );

Tile * tilemap_fill (Tilemap * self , int l , Tile * tile );

int tilemap_getindex (Tilemap * self , int l , int x , int y );

Thing * tilemap_addtilething (Tilemap * self , int kind , int tx , int ty , int layer );

void tilemap_draw (Tilemap * map , Camera * camera );

void tilemap_update (Tilemap * map , double dt );

Thing * tilemap_addthing(Tilemap * self , int index, int kind , int x , int y , int z , int w , int h);

Lockin * tilepane_lockin (Tilepane * pane , Camera * camera );

Lockin * tilemap_layer_lockin (Tilemap * map , int layer , Camera * camera );

int tilemap_gridwide(Tilemap * self);
int tilemap_gridhigh(Tilemap * self);

Area * tilemap_area(Tilemap * self);

Thing * tilemap_thing(Tilemap * self, int index);

bool tilemap_init_blend(Tilemap * self);

void tilemap_draw_layer(Tilemap * map, Camera * camera, int layer);

void tilemap_draw_layer_shadows(Tilemap * map, Camera * camera, int layer);

/* This is here in stead of in area.h to avoid cyclical dependencies. */
ERES area_tilemap_(Area * self, Tilemap * map);


void tilemap_draw_layer_tiles(Tilemap * map, Camera * camera, int layer);
void tilemap_draw_layer_blends(Tilemap * map, Camera * camera, int layer);


Tileset * tilemap_tileset(Tilemap * me);
int tilemap_firstgid(Tilemap * me);

int tilemap_set_flags(Tilemap * self, int l, int x, int y, int flags);
int tilemap_get_flags(Tilemap * self, int l, int x, int y);




#ifdef COMMENT_

Tilepane * tilepane_savefile (Tilepane *pane , int paneid , FILE *fout );

Tilemap * tilemap_savefile (Tilemap * map , FILE * fout );

Tilemap * tilemap_save (Tilemap * map , int index );

int tilemap_track (Tracker * tracker , void * data );

#endif



#endif
