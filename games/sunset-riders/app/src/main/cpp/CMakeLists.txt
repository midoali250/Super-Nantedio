cmake_minimum_required(VERSION 3.22)
project(snescore C)

set(CMAKE_C_STANDARD 11)
set(CORE ${CMAKE_CURRENT_SOURCE_DIR}/genesis-plus-gx-src)
set(COMM ${CORE}/libretro/libretro-common)
set(ZLIB ${CORE}/libretro/deps/zlib-1.2.11)

file(GLOB CORE_SRCS
  ${CORE}/core/*.c
  ${CORE}/core/z80/*.c
  ${CORE}/core/m68k/*.c
  ${CORE}/core/ntsc/*.c
  ${CORE}/core/sound/*.c
  ${CORE}/core/sound/tremor/*.c
  ${CORE}/core/input_hw/*.c
  ${CORE}/core/cd_hw/*.c
  ${CORE}/core/cart_hw/*.c
  ${CORE}/core/cart_hw/svp/*.c
)

set(SRCS
  ${CMAKE_CURRENT_SOURCE_DIR}/snes_jni.c
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

  ${ZLIB}/adler32.c
  ${ZLIB}/crc32.c
  ${ZLIB}/inffast.c
  ${ZLIB}/inflate.c
  ${ZLIB}/inftrees.c
  ${ZLIB}/zutil.c
)

add_library(snescore SHARED ${SRCS})

target_include_directories(snescore PRIVATE
  ${CORE}/core
  ${CORE}/core/z80
  ${CORE}/core/m68k
  ${CORE}/core/ntsc
  ${CORE}/core/sound
  ${CORE}/core/sound/minimp3
  ${CORE}/core/sound/tremor
  ${CORE}/core/input_hw
  ${CORE}/core/cd_hw
  ${CORE}/core/cart_hw
  ${CORE}/core/cart_hw/svp
  ${CORE}/libretro
  ${COMM}/include
  ${ZLIB}
)

target_compile_definitions(snescore PRIVATE
  __LIBRETRO__
  USE_LIBTREMOR
  USE_PER_SOUND_CHANNELS_CONFIG
  USE_16BPP_RENDERING
  FRONTEND_SUPPORTS_RGB565
  LSB_FIRST
  BYTE_ORDER=LITTLE_ENDIAN
  HAVE_ZLIB
  USE_LIBRETRO_VFS
  M68K_OVERCLOCK_SHIFT=20
  Z80_OVERCLOCK_SHIFT=20
  HAVE_YM3438_CORE
  HAVE_OPLL_CORE
  MAXROMSIZE=33554432
  "INLINE=static inline"
)

target_compile_options(snescore PRIVATE -O2 -DPATH_MAX=1024 -w)
target_link_libraries(snescore m log)
