# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
# cmake_minimum_required(VERSION 3.10)

# project(whisper_flutter_native_library VERSION 0.0.1 LANGUAGES C)

# add_library(whisper_flutter_native SHARED
#   "whisper_flutter_native.c"
# )

# set_target_properties(whisper_flutter_native PROPERTIES
#   PUBLIC_HEADER whisper_flutter_native.h
#   OUTPUT_NAME "whisper_flutter_native"
# )

# target_compile_definitions(whisper_flutter_native PUBLIC DART_SHARED_LIB)


cmake_minimum_required(VERSION 3.10)

# project(whisper.cpp)
project(whisper_library VERSION 0.0.1 LANGUAGES C CXX)

# set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -pthread -std=c++11 -O3")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -pthread -O3 -std=c11")


# cc  -I.              -O3 -std=c11   -pthread -DGGML_USE_ACCELERATE   -c ggml.c -o ggml.o
# c++ -I. -I./examples -O3 -std=c++11 -pthread -c whisper.cpp -o whisper.o
# c++ -I. -I./examples -O3 -std=c++11 -pthread examples/main/main.cpp whisper.o ggml.o -o main  -framework Accelerate


set(whisper_library_shared_directory "lib")
set(whisper_library_executable_directory "bin")

set(whisper_library_prefix_shared_library "lib")


if (ANDROID)
set(whisper_library_shared_directory "${whisper_library_shared_directory}/${ANDROID_ABI}") 
 set(whisper_library_shared_extension ".so")
 set(whisper_library_executable_extension "")
 set(whisper_library_name "whisper")
elseif (WIN32)
 set(whisper_library_shared_extension ".dll")
 set(whisper_library_executable_extension ".exe") 
 set(whisper_library_name "whisper")
elseif (APPLE)
 set(whisper_library_shared_extension ".dylib")
 set(whisper_library_executable_extension "") 
 set(whisper_library_name "whisper")
elseif (LINUX)
 set(whisper_library_shared_extension ".so")
 set(whisper_library_executable_extension "") 
 set(whisper_library_name "whisper")
else()
 set(whisper_library_shared_extension ".unknown")
 set(whisper_library_executable_extension "") 
 set(whisper_library_name "whisperunknown")
endif()



set(WHISPER_LIB_DIR package/whisper.cpp)

include_directories(${WHISPER_LIB_DIR})
include_directories(${WHISPER_LIB_DIR}/examples)
include_directories(${WHISPER_LIB_DIR}/src)
include_directories(${WHISPER_LIB_DIR}/include)
include_directories(${WHISPER_LIB_DIR}/ggml/include)
include_directories(${WHISPER_LIB_DIR}/ggml/src)

# Path to external GGML, otherwise uses the copy in whisper.cpp.
option(GGML_HOME "whisper: Path to external GGML source" OFF)


set(SOURCE_FILES ${WHISPER_LIB_DIR}/src/whisper.cpp whisper_library.cpp)


if (NOT GGML_HOME) 
    set(
        SOURCE_FILES
        ${SOURCE_FILES}
        ${WHISPER_LIB_DIR}/ggml/src/ggml.c
        ${WHISPER_LIB_DIR}/ggml/src/ggml-aarch64.c
        ${WHISPER_LIB_DIR}/ggml/src/ggml-alloc.c
        ${WHISPER_LIB_DIR}/ggml/src/ggml-backend.c
        ${WHISPER_LIB_DIR}/ggml/src/ggml-quants.c
        )
endif()

find_library(LOG_LIB log)



function(build_library)
    add_library(whisper_library_shared SHARED ${SOURCE_FILES})
    set_target_properties(whisper_library_shared PROPERTIES 
      LIBRARY_OUTPUT_DIRECTORY ${whisper_library_shared_directory}
      PREFIX ${whisper_library_prefix_shared_library}
      OUTPUT_NAME ${whisper_library_name}
    )
    

if (WIN32)
set_target_properties(whisper_library_shared PROPERTIES
 WINDOWS_EXPORT_ALL_SYMBOLS ON
)
endif (WIN32)


    if (${whisper_library_name} STREQUAL "whisper_v8fp16_va")
        target_compile_options(whisper_library_shared PRIVATE -march=armv8.2-a+fp16)
        set(GGML_COMPILE_OPTIONS -march=armv8.2-a+fp16)
    elseif (${whisper_library_name} STREQUAL "whisper_vfpv4")
        target_compile_options(whisper_library_shared PRIVATE -mfpu=neon-vfpv4)
        set(GGML_COMPILE_OPTIONS -mfpu=neon-vfpv4)
    endif ()

    if (NOT ${CMAKE_BUILD_TYPE} STREQUAL "Debug")
        target_compile_options(whisper_library_shared PRIVATE -O3)
        # target_compile_options(${whisper_library_name} PRIVATE -fvisibility=hidden -fvisibility-inlines-hidden)
        target_compile_options(whisper_library_shared PRIVATE -ffunction-sections -fdata-sections)

        target_link_options(whisper_library_shared PRIVATE -Wl,--gc-sections)
        target_link_options(whisper_library_shared PRIVATE -Wl,--exclude-libs,ALL)
        target_link_options(whisper_library_shared PRIVATE -flto)
    endif ()

    if (GGML_HOME)
        include(FetchContent)
        FetchContent_Declare(ggml SOURCE_DIR ${GGML_HOME})
        FetchContent_MakeAvailable(ggml)

        target_compile_options(ggml PRIVATE ${GGML_COMPILE_OPTIONS})
        target_link_libraries(whisper_library_shared ggml)
        if (ANDROID)
        target_link_libraries(whisper_library_shared ${LOG_LIB} android ggml)
        endif()
    else()
        if (ANDROID)
          target_link_libraries(whisper_library_shared ${LOG_LIB} android)
        endif()

    endif()
    target_link_libraries(whisper_library_shared PRIVATE ${CMAKE_THREAD_LIBS_INIT})
if (LINUX) 
    add_custom_command(
        TARGET whisper_library_shared POST_BUILD 
        COMMAND ${CMAKE_STRIP} --strip-debug --strip-unneeded "${whisper_library_shared_directory}/${prefix_shared_library}${whisper_library_prefix_shared_library}${whisper_library_name}${whisper_library_shared_extension}"
      )

      endif()

    target_compile_definitions(whisper_library_shared PUBLIC DART_SHARED_LIB)

endfunction()
 
function(build_executable)   


endfunction()


build_library()
build_executable()
