cmake_minimum_required(VERSION 2.6)
if(CMAKE_VERSION VERSION_GREATER "2.8.0")
  cmake_policy(SET CMP0012 OLD)
endif()  
# set(CMAKE_BUILT_TYPE Debug)
# below is for profiling.
#set(CMAKE_C_FLAGS "-Wall -g -pg -O")
set(CMAKE_C_FLAGS "-Wall -g -O")

# Find SDL
set(SDL_BUILDING_LIBRARY 1)
find_package(SDL REQUIRED)
find_package(SDL_image REQUIRED)
find_package(SDL_mixer REQUIRED)
find_package(SDL_ttf REQUIRED)
find_package(PNG REQUIRED)
find_package(JPEG REQUIRED)

# FindSDL
# FindSDL_image
# FindSDL_mixer
# FindSDL_net
# FindSDL_sound
# FindSDL_ttf
# Set include and lib dirs. 
include_directories(${SDL_INCLUDE_DIR} ${SDLTTF_INCLUDE_DIR} ${SDLIMAGE_INCLUDE_DIR} ${SDLMIXER_INCLUDE_DIR} ${PNG_INCLUDE_DIR} ${JPEG_INCLUDE_DIR})

set(GY_LIBS ${LIBS} ${SDL_LIBRARY} ${SDLTTF_LIBRARY} 
${SDLIMAGE_LIBRARY} ${SDLMIXER_LIBRARY} ${PNG_LIBRARY} ${JPEG_LIBRARY})

# configure_file("config.in.h" "config.h")
file(GLOB GY_CFILES "*.c")
add_library(gy_static STATIC ${GY_CFILES})
add_library(gy SHARED ${GY_CFILES})
target_link_libraries(gy ${GY_LIBS})
set(GY_TEST_LIBS ${GY_LIBS} gy)


