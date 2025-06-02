//
// Created by drago on 01.06.2025.
//

#ifndef NEXOENGINE_H
#define NEXOENGINE_H

#include <iostream>
#include <fstream>
#include <map>
#include <stack>
#include "../util/Opcode.h"

class NexoEngine {
    private:
        std::ifstream source_file;
        std::map<std::string, std::string> variables;
        bool exec = true;
        std::stack<bool> exec_stack;
    public:
        explicit NexoEngine(const std::string& source_name);
        std::string readString();
        bool compile();
};



#endif //NEXOENGINE_H
