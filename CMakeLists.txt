cmake_minimum_required(VERSION 3.17)

project(trt_inf LANGUAGES CUDA CXX)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

list(APPEND PLUGINS "nvinfer")
list(APPEND PLUGINS "nvonnxparser")
list(APPEND PLUGINS "nvparsers")
list(APPEND PLUGINS "nvinfer_plugin")

foreach(libName ${PLUGINS})
    find_library(${libName}_lib NAMES ${libName} "/usr" PATH_SUFFIXES lib)
    list(APPEND TRT_PLUGIN_LIBS "${${libName}_lib}")
endforeach()
message(STATUS "TRT_PLUGIN_LIBS: ${PLUGIN_LIBS}")

add_executable(trt_inf
    src/main.cpp
    src/trt_yolo.cpp)

target_include_directories(trt_inf
    PRIVATE inc)
    
target_link_libraries(trt_inf
    PUBLIC ${TRT_PLUGIN_LIBS})

