cmake_minimum_required(VERSION 3.22)
project(snescore C)

set(CMAKE_C_STANDARD 11)
set(CORE ${CMAKE_CURRENT_SOURCE_DIR}/snes9x2010-src)
set(COMM ${CORE}/libretro/libretro-common)

# Source list mirrors upstream libretro/snes9x2010 Makefile.common: the core
# itself plus the libretro-common helpers it calls into. We are both the
# core and the frontend here, so the frontend-side helpers are compiled in
# as well (upstream leaves them to RetroArch when linking statically).
set(SRCS
  ${CMAKE_CURRENT_SOURCE_DIR}/snes_jni.c

  ${CORE}/src/apu.c
  ${CORE}/src/bsflash.c
  ${CORE}/src/bsx.c
  ${CORE}/src/c4emu.c
  ${CORE}/src/cheats.c
  ${CORE}/src/controls.c
  ${CORE}/src/cpu.c
  ${CORE}/src/cpuexec.c
  ${CORE}/src/dsp.c
  ${CORE}/src/fxemu.c
  ${CORE}/src/globals.c
  ${CORE}/src/hdpack.c
  ${CORE}/src/hwregisters.c
  ${CORE}/src/memmap.c
  ${CORE}/src/msu1.c
  ${CORE}/src/msu1_pack.c
  ${CORE}/src/obc1.c
  ${CORE}/src/ppu.c
  ${CORE}/src/sa1.c
  ${CORE}/src/sdd1.c
  ${CORE}/src/seta.c
  ${CORE}/src/snapshot.c
  ${CORE}/src/spc7110.c
  ${CORE}/src/srtc.c
  ${CORE}/src/tile.c

  ${CORE}/filter/snes_ntsc.c
  ${CORE}/libretro/libretro.c

  ${COMM}/compat/compat_posix_string.c
  ${COMM}/compat/compat_snprintf.c
  ${COMM}/compat/compat_strcasestr.c
  ${COMM}/compat/compat_strl.c
  ${COMM}/compat/fopen_utf8.c
  ${COMM}/encodings/encoding_crc32.c
  ${COMM}/encodings/encoding_deflate.c
  ${COMM}/encodings/encoding_utf.c
  ${COMM}/features/features_cpu.c
  ${COMM}/file/file_path.c
  ${COMM}/file/file_path_io.c
  ${COMM}/file/retro_dirent.c
  ${COMM}/file/rpng_file.c
  ${COMM}/formats/dds/rdds.c
  ${COMM}/formats/image_transfer.c
  ${COMM}/formats/png/rpng.c
  ${COMM}/formats/png/rpng_apng.c
  ${COMM}/formats/png/rpng_encode.c
  ${COMM}/formats/vp8/rvp8.c
  ${COMM}/formats/webp/rwebp.c
  ${COMM}/memmap/memalign.c
  ${COMM}/streams/file_stream.c
  ${COMM}/streams/file_stream_transforms.c
  ${COMM}/streams/interface_stream.c
  ${COMM}/streams/memory_stream.c
  ${COMM}/streams/rzip_stream.c
  ${COMM}/streams/trans_stream.c
  ${COMM}/streams/trans_stream_deflate.c
  ${COMM}/streams/trans_stream_pipe.c
  ${COMM}/string/rstrtod.c
  ${COMM}/string/stdstring.c
  ${COMM}/time/rtime.c
  ${COMM}/vfs/vfs_hybrid.c
  ${COMM}/vfs/vfs_implementation.c
)

add_library(snescore SHARED ${SRCS})

target_include_directories(snescore PRIVATE
  ${CORE} ${CORE}/src ${CORE}/libretro ${COMM}/include)

target_compile_definitions(snescore PRIVATE __LIBRETRO__ DINLINE=inline)
target_compile_options(snescore PRIVATE -O3 -funroll-loops -DPATH_MAX=1024 -Wall -Wno-unused)
target_link_libraries(snescore m log)
