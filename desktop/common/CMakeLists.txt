cmake_minimum_required(VERSION 3.22)
project(nes_app_host C)
set(CMAKE_C_STANDARD 11)

set(APP    ${CMAKE_CURRENT_SOURCE_DIR}/../../games/super-mario-world/app)
set(CORE   ${APP}/src/main/cpp/fceumm-src)
set(COMMON ${CORE}/drivers/libretro/libretro-common)

file(GLOB BOARD_SRC ${CORE}/boards/*.c)
file(GLOB INPUT_SRC ${CORE}/input/*.c)

set(SRCS
  ${APP}/src/main/cpp/nes_jni.c
  ${CMAKE_CURRENT_SOURCE_DIR}/hostjni.c
  ${BOARD_SRC} ${INPUT_SRC}
  ${CORE}/drivers/libretro/libretro.c
  ${CORE}/drivers/libretro/libretro_dipswitch.c
  ${CORE}/cart.c ${CORE}/cheat.c ${CORE}/crc32.c ${CORE}/fceu-endian.c ${CORE}/fceu-memory.c
  ${CORE}/fceu.c ${CORE}/fds.c ${CORE}/fds_apu.c ${CORE}/file.c ${CORE}/filter.c ${CORE}/general.c
  ${CORE}/ines.c ${CORE}/input.c ${CORE}/md5.c ${CORE}/nsf.c ${CORE}/palette.c ${CORE}/ppu.c ${CORE}/sound.c
  ${CORE}/state.c ${CORE}/unif.c ${CORE}/video.c ${CORE}/vsuni.c ${CORE}/x6502.c
  ${COMMON}/streams/memory_stream.c
  ${COMMON}/compat/compat_posix_string.c ${COMMON}/compat/compat_snprintf.c
  ${COMMON}/compat/compat_strcasestr.c ${COMMON}/compat/compat_strl.c ${COMMON}/compat/fopen_utf8.c
  ${COMMON}/encodings/encoding_utf.c ${COMMON}/file/file_path.c ${COMMON}/file/file_path_io.c
  ${COMMON}/streams/file_stream.c ${COMMON}/streams/file_stream_transforms.c
  ${COMMON}/string/stdstring.c ${COMMON}/time/rtime.c ${COMMON}/vfs/vfs_implementation.c
)

add_library(nesapp_host SHARED ${SRCS})
set_target_properties(nesapp_host PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
if(MINGW)
  target_link_options(nesapp_host PRIVATE -static-libgcc -Wl,--export-all-symbols)
endif()
target_include_directories(nesapp_host PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR} ${CORE} ${CORE}/drivers/libretro ${COMMON}/include ${CORE}/input ${CORE}/boards)
target_compile_definitions(nesapp_host PRIVATE __LIBRETRO__ FCEU_VERSION_NUMERIC=9900 FRONTEND_SUPPORTS_RGB565)
target_compile_options(nesapp_host PRIVATE -O2 -DPATH_MAX=1024 -Wno-unused)
target_link_libraries(nesapp_host m)
