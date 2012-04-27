#ifndef FIFI_PROTO_H
#define FIFI_PROTO_H
/*
This file was autogenerated from src/fifi.c
by bin/genproto
Please do not hand edit.
*/

/** Helper for al_path_cstr. */
const char * fifi_path_cstr(Path * path);

/** Helper for al_filename_exists with a path. */
int fifi_path_exists(Path * path);

/** Initializes the file finding dir  */
ALLEGRO_PATH * fifi_init(void);

/** Returns a pointer to the data path. Must be cloned before use.*/
ALLEGRO_PATH * fifi_data_path(void);  

/** Returns a pointer to the data path converted to a c string. */
const char * fifi_data_path_cstr(void);

/**
* Returns an ALLEGRO_PATH path concatenated with the 
* const char * strings in args, of which the last one should be NULL.
* modifies * path
*/
ALLEGRO_PATH * path_append_va(ALLEGRO_PATH * path, va_list args);

/**
* Returns an ALLEGRO_PATH path concatednated with the 
* const char * strings, of which the last one should be NULL.
*/
ALLEGRO_PATH * path_append(ALLEGRO_PATH * path, ...);

/**
* helper like strncpy, but null terminates. Takes space and size
* amount is actual characters to copy , space is space available.
* Does nothing if space is less than 1.
*/
char *help_strncpy(char * dest, const char * src, size_t amount, size_t space);

/**
* Helper function to split up character strings with a separator.
*/
char * help_strsplit(const char * in, int ch, char * store, size_t space);

/**
* Returns an ALLEGRO_PATH path concatenated with the path in vpath.
* The const char * vpath is split on '/' characters, and the path
* is constructed like that. .. or . is not supported.
* if the last part contains a . it will be added as a file part.
**/
ALLEGRO_PATH * path_append_vpath(ALLEGRO_PATH * path, const char * vpath);

/** Returns a path to data which has the given virtual path.
*  You need to free the result with al_destroy_path.
*/
ALLEGRO_PATH * fifi_data_vpath(const char * vpath);

/**
* Returns a path to data. Last of the arguments should be NULL.
* You need to free the result with al_destroy_path.
* returns NULL if no such file exists.
*/
ALLEGRO_PATH * fifi_data_pathva(const char * filename, va_list args);

/**
* Returns a path to data. Last of the arguments should be NULL.
* You need to free the result with al_destroy_path.
* returns NULL if no such file exists.
*/
ALLEGRO_PATH * fifi_data_pathargs(const char * filename, ...);

/**
* simple test function
*/
void fifi_data_vpath_print(const char * vpath);

/**
* Loads file  that is in the data directory using the given loader.
* returns NULL if the file doesn't exist or wasn't loaded correctly.
*/
void * fifi_loadsimple_vpath(FifiSimpleLoader * load, const char * vpath);

/**
* Loads file  that is in the data directory using the given loader.
* returns NULL if the file doesn't exist or wasn't loaded correctly.
*/
void * fifi_loadsimple_va(FifiSimpleLoader * load, const char * filename, 
                          va_list args);

/**
* Loads file  that is in the data directory using the given loader.
* the filename is specified first, then the directories under which 
* it should be, one by one, ended with NULL
* returns NULL if the file doesn't exist or wasn't loaded correctly.
*/
void * fifi_loadsimple(FifiSimpleLoader * load, const char * filename, ...);

/**
* Loads a font from the data directory, with the given filename, size and 
* flags. No directory name is needed, the fonts must be in te data/font dir.
*/
ALLEGRO_FONT * fifi_loadfont(const char * filename, int size, int flags);

/**
* Loads a bitmap with the given filename under the NULL-terminated list 
* of subdirectory names
*/
ALLEGRO_BITMAP * fifi_loadbitmap_va(const char * filename, va_list args);

/**
* Loads a bitmap with the given filename under the NULL-terminated list 
* of subdirectory names
*/
ALLEGRO_BITMAP * fifi_loadbitmap(const char * filename, ...);

/**
* Loads a bitmap with the given vpath
*/
ALLEGRO_BITMAP * fifi_loadbitmap_vpath(const char * vpath);  

/** Loads an audio stream from the data directory. Since audi streams are usually music, no there's no nedto inicatet hedi, but all music must go under 
data/music */
ALLEGRO_AUDIO_STREAM * fifi_loadaudiostream(const char *filename,
                        size_t buffer_count, unsigned int samples); 

/**
* returns an ALLEGRO_PATH that points to the tileset image for the given
* file name. Must be destroyed after use. 
*/
ALLEGRO_PATH * fifi_tileset_filename(const char * name);  

/** The follwoing loadable objects exist: 
* 1) maps
* 2) map scripts
* 3) tilesets
* 4) sound effects
* 4) music
* 5) tiles
* 6) gui elements
* 7) backgrounds
*/









#endif // FIFI_PROTO_H

