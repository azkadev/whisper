# # The Flutter tooling requires that developers have CMake 3.10 or later
# # installed. You should not increase this version, as doing so will cause
# # the plugin to fail to compile for some customers of the plugin.
# cmake_minimum_required(VERSION 3.10)

# project(whisper_library VERSION 0.0.1 LANGUAGES C CXX)

# message("Started Compile Whisper")

# set(CMAKE_CXX_STANDARD 20)
# set(CMAKE_CXX_STANDARD_REQUIRED ON)
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a -fPIC") 

# add_library(ggml whisper.cpp/ggml.c)
# add_library(whisper_lib whisper.cpp/whisper.cpp)
# add_library(whisper SHARED main.cpp)
 
# # set_target_properties(whisper PROPERTIES
# #   PUBLIC_HEADER whisper.cpp/whisper.h 
# #   OUTPUT_NAME "whisper"
# # )

# target_compile_definitions(whisper PUBLIC DART_SHARED_LIB)
# target_link_libraries(whisper PRIVATE ggml ${CMAKE_THREAD_LIBS_INIT})
 
# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(whisper_library VERSION 0.0.1 LANGUAGES C CXX)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")

add_library(whisper SHARED main.cpp)
add_library(whisper_lib whisper.cpp/whisper.cpp)
add_library(ggml whisper.cpp/ggml.c)

set_target_properties(whisper PROPERTIES
  PUBLIC_HEADER whisper.cpp/whisper.h 
  OUTPUT_NAME "whisper"
)

if (WIN32)
set_target_properties(whisper PROPERTIES
  WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)

target_compile_definitions(whisper PUBLIC DART_SHARED_LIB)
target_link_libraries(whisper PRIVATE whisper_lib ggml ${CMAKE_THREAD_LIBS_INIT})
