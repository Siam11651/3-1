cmake_minimum_required(VERSION 3.0.0)
project(online-1 VERSION 0.1.0)

file(GLOB SRC "src/*.cpp")

add_executable(online-1 ${SRC})