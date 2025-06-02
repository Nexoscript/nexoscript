//
// Created by drago on 01.06.2025.
//

#include "NexoEngine.h"

#include <cstdint>

NexoEngine::NexoEngine(const std::string& source_name) {
    this->source_file = std::ifstream(source_name, std::ios::binary);
}

std::string NexoEngine::readString() {
    char len;
    this->source_file.get(len);
    std::string str(len, ' ');
    this->source_file.read(&str[0], len);
    return str;
}

bool NexoEngine::compile() {
    std::cout << "Compiling..." << std::endl;
    while (this->source_file.peek() != EOF) {
        std::cout << "reading opcode" << std::endl;
        uint8_t opcode = this->source_file.get();
        std::cout << "opcode: " << opcode << std::endl;

        if (opcode == SET_VAR) {
            std::cout << "opcode Set Var triggered!" << std::endl;
            std::string type = readString();
            std::string name = readString();
            std::string val = readString();
            if (exec) variables[name] = val;
        }

        if (opcode == PRINT_VAR) {
            std::cout << "opcode Print Var triggered!" << std::endl;
            std::string name = readString();
            if (exec) std::cout << variables[name] << std::endl;
        }

        if (opcode == PRINT_STR) {
            std::cout << "opcode Print STR triggered!" << std::endl;
            std::string val = readString();
            if (exec) std::cout << val << std::endl;
        }

        if (opcode == IF_EQ) {
            std::cout << "opcode IF EQ triggered!" << std::endl;
            std::string var = readString();
            std::string val = readString();
            bool result = (variables[var] == val);
            this->exec_stack.push(exec);
            exec = exec && result;
        }

        if (opcode == ELSE) {
            std::cout << "opcode Else triggered!" << std::endl;
            bool prev = this->exec_stack.top();
            exec = prev && !exec;
        }

        if (opcode == END) {
            if (!this->exec_stack.empty()) {
                std::cout << "opcode End triggered!" << std::endl;
                exec = this->exec_stack.top();
                this->exec_stack.pop();
            }
        }
        std::cout << "exec" << std::endl;
    }
    return true;
}