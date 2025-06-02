//
// Created by drago on 01.06.2025.
//

#ifndef NEXOCOMPILER_H
#define NEXOCOMPILER_H

#include <fstream>
#include <string>
#include <stack>
#include "../util/Opcode.h"

class NexoCompiler {
    private:
        std::ifstream source_file;
        std::ofstream output_file;
        std::string line;
        std::stack<std::string> blocks;
    public:
        NexoCompiler(std::string source_name, std::string output_name);
        void writeString(const std::string& str);
        bool compile();

};



#endif //NEXOCOMPILER_H
