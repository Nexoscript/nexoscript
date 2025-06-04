cmake_minimum_required(VERSION 3.31)
project(nexoscript)

set(CMAKE_CXX_STANDARD 26)

add_executable(nexoscript src/main.cpp
        src/nexoproject/NexoProjectCfgReader.cpp
        src/nexoproject/NexoProjectCfgReader.h
        src/util/StringUtils.cpp
        src/util/StringUtils.h
        src/nexoengine/NexoEngine.cpp
        src/nexoengine/NexoEngine.h
        src/nexocompiler/NexoCompiler.cpp
        src/nexocompiler/NexoCompiler.h
        src/nexoproject/NexoProject.cpp
        src/nexoproject/NexoProject.h
        src/util/PrintUtils.cpp
        src/util/PrintUtils.h
        src/util/Opcode.h)
