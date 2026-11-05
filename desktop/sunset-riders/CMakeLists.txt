cmake_minimum_required(VERSION 3.22)
project(snes_app_host C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)

set(APP  ${CMAKE_CURRENT_SOURCE_DIR}/../../games/sunset-riders/app)
set(CORE ${APP}/src/main/cpp/genesis-plus-gx-src)
set(COMM ${CORE}/libretro/libretro-common)
set(ZLIB ${CORE}/libretro/deps/zlib-1.2.11)

file(GLOB CORE_SRCS
  ${CORE}/core/*.c
  ${CORE}/core/z80/*.c
  ${CORE}/core/m68k/*.c
  ${CORE}/core/ntsc/*.c
  ${CORE}/core/sound/*.c
  ${CORE}/core/input_hw/*.c
  ${CORE}/core/cd_hw/*.c
  ${CORE}/core/cart_hw/*.c
  ${CORE}/core/cart_hw/svp/*.c
)

set(SRCS
  ${APP}/src/main/cpp/snes_jni.c
  ${CMAKE_CURRENT_SOURCE_DIR}/hostjni.c
  ${CORE_SRCS}
  ${CORE}/libretro/libretro.c

  ${COMM}/streams/file_stream.c
  ${COMM}/streams/file_stream_transforms.c
  ${COMM}/compat/fopen_utf8.c
  ${COMM}/compat/compat_snprintf.c
  ${COMM}/compat/compat_strl.c
  ${COMM}/compat/compat_strcasestr.c
  ${COMM}/compat/compat_posix_string.c
  ${COMM}/encodings/encoding_utf.c
  ${COMM}/file/file_path.c
  ${COMM}/file/retro_dirent.c
  ${COMM}/lists/string_list.c
  ${COMM}/lists/dir_list.c
  ${COMM}/memmap/memalign.c
  ${COMM}/string/stdstring.c
  ${COMM}/vfs/vfs_implementation.c

  ${ZLIB}/crc32.c
)

add_library(snesapp_host SHARED ${SRCS})
set_target_properties(snesapp_host PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
if(MINGW)
  target_link_options(snesapp_host PRIVATE -static-libgcc -Wl,--export-all-symbols)
endif()

target_include_directories(snesapp_host PRIVATE
  ${CORE}/core
  ${CORE}/core/z80
  ${CORE}/core/m68k
  ${CORE}/core/ntsc
  ${CORE}/core/sound
  ${CORE}/core/sound/minimp3
  ${CORE}/core/input_hw
  ${CORE}/core/cd_hw
  ${CORE}/core/cart_hw
  ${CORE}/core/cart_hw/svp
  ${CORE}/libretro
  ${COMM}/include
  ${ZLIB}
  ${CMAKE_CURRENT_SOURCE_DIR}
)

target_compile_definitions(snesapp_host PRIVATE
  __LIBRETRO__
  USE_PER_SOUND_CHANNELS_CONFIG
  USE_16BPP_RENDERING
  FRONTEND_SUPPORTS_RGB565
  LSB_FIRST
  USE_LIBRETRO_VFS
  M68K_OVERCLOCK_SHIFT=20
  Z80_OVERCLOCK_SHIFT=20
  HAVE_YM3438_CORE
  HAVE_OPLL_CORE
  MAXROMSIZE=33554432
  "INLINE=static inline"
)

target_compile_options(snesapp_host PRIVATE -O2 -DPATH_MAX=1024 -Wno-return-type -Wno-implicit-function-declaration -Wno-int-conversion -w)
target_link_libraries(snesapp_host m)
