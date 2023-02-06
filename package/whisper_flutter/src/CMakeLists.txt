# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(whisper_flutter_library VERSION 0.0.1 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")

add_library(whisper_flutter SHARED main.cpp)
add_library(whisper whisper.cpp/whisper.cpp)
add_library(ggml whisper.cpp/ggml.c)

set_target_properties(whisper_flutter PROPERTIES
  PUBLIC_HEADER whisper.cpp/whisper.h 
  OUTPUT_NAME "whisper"
)

if (WIN32)
set_target_properties(whisper_flutter PROPERTIES
  WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)

target_compile_definitions(whisper_flutter PUBLIC DART_SHARED_LIB)
target_link_libraries(whisper_flutter PRIVATE whisper ggml ${CMAKE_THREAD_LIBS_INIT})
