cmake_minimum_required(VERSION 3.0.0)
project(problem-2 VERSION 0.1.0)

file(GLOB SRC "src/*.cpp")

add_executable(offline-1 ${SRC})