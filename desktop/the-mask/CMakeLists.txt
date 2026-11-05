cmake_minimum_required(VERSION 3.22)
project(snes_app_host C)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)

set(APP  ${CMAKE_CURRENT_SOURCE_DIR}/../../games/the-mask/app)
set(CORE ${APP}/src/main/cpp/snes9x2010-src)
set(COMM ${CORE}/libretro/libretro-common)

set(SRCS
  ${APP}/src/main/cpp/snes_jni.c
  ${CMAKE_CURRENT_SOURCE_DIR}/hostjni.c

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

add_library(snesapp_host SHARED ${SRCS})
set_target_properties(snesapp_host PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
if(MINGW)
  target_link_options(snesapp_host PRIVATE -static-libgcc -Wl,--export-all-symbols)
endif()

target_include_directories(snesapp_host PRIVATE
  ${CORE} ${CORE}/src ${CORE}/libretro ${COMM}/include ${CMAKE_CURRENT_SOURCE_DIR})

target_compile_definitions(snesapp_host PRIVATE __LIBRETRO__ DINLINE=inline)
target_compile_options(snesapp_host PRIVATE -O3 -funroll-loops -DPATH_MAX=1024 -w)
target_link_libraries(snesapp_host m)
