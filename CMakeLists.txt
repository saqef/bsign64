cmake_minimum_required(VERSION 3.12)

project(bsign
  VERSION 0.4.5 
  DESCRIPTION "sign and verify elf files"
  LANGUAGES CXX
)

file(GLOB_RECURSE SOURCES RELATIVE ${CMAKE_SOURCE_DIR} "src/*.h" "src/*.cpp")
add_executable(bsign ${SOURCES})