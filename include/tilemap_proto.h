#ifndef TILEMAP_PROTO_H
#define TILEMAP_PROTO_H
/*
This file was autogenerated from src/tilemap.c
by bin/genproto
Please do not hand edit.
*/

/** A tile map is a game map that uses tiled panes for it's 
display and physics. */
struct Tilemap_;
typedef struct Tilemap_ Tilemap;

/** Loads an image of the given category and index as a texture. */
Image * image_loadtexture(const char * category, int index);

/** Cleans up a tilemap. */
Tilemap * tilemap_done(Tilemap * self);

/** Initializes a tile map */
Tilemap* tilemap_init(Tilemap * self, Tileset * set, int w, int h);

/** Frees the tile map and initializes it. */
Tilemap * tilemap_free(Tilemap * map);

/** Allocates a new tile map and initializes it. */
Tilemap * tilemap_new(Tileset * set, int w, int h);

/** Returns a pointer to the pane at index or NULL if out of range. */
Tilepane * tilemap_pane(Tilemap * self, int index);

/** Makes a new tile pane for the pane at indexeth index of the tile map. */
Tilepane * tilemap_panenew(Tilemap * self, int index, int w, int h);

/** Returns the tile in the tile map in the given layer at the given coords. */
Tile * tilemap_get(Tilemap * self, int l, int x, int y);

/** Sets a tile in the tile map to the given tile. */
Tile * tilemap_settile(Tilemap * self, int l, int x, int y, Tile * tile);

/** Sets a tile in the tile map to the tile with the given index. */
Tile * tilemap_setindex(Tilemap * self, int l, int x, int y, int index);

/** Sets a rectangle area in the tile map to the given tile. */
Tile * tilemap_rect(Tilemap * self, int l, 
                       int x, int y, int w, int h, Tile * tile);

/** Sets a rectangle area in the tile map to the given tile. */
Tile * tilemap_fill(Tilemap * self, int l, Tile * tile);

/** Gets the index of the tile at the given location in the tilemap. */
int tilemap_getindex(Tilemap * self, int l, int x, int y);

/** Makees a physical wall in the chipmunk space of the map at the given 
tile coordinates. Returns the wall shape. */
cpShape * tilemap_makewall(Tilemap * self, int tx, int ty);

#endif // TILEMAP_PROTO_H
