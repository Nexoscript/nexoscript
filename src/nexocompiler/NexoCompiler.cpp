//
// Created by drago on 01.06.2025.
//

#include "NexoCompiler.h"
#include "../util/StringUtils.h"
#include "../util/PrintUtils.h"

NexoCompiler::NexoCompiler(std::string source_name, std::string output_name) {
    this->source_file = std::ifstream(source_name);
    this->output_file = std::ofstream(output_name, std::ios::binary);
}

void NexoCompiler::writeString(const std::string &str) {
    this->output_file.put((char)str.size());
    this->output_file.write(str.c_str(), str.size());
}

bool NexoCompiler::compile() {
    while (std::getline(this->source_file, line)) {
        line = StringUtils::trim(line);
        if (line.empty()) continue;

        // var name: string = "Tom"
        if (line.rfind("var ", 0) == 0) {
            size_t colon = line.find(":");
            size_t eq = line.find("=");

            std::string name = StringUtils::trim(line.substr(4, colon - 4));
            std::string type = StringUtils::trim(line.substr(colon + 1, eq - colon - 1));
            std::string value = StringUtils::trim(line.substr(eq + 1));

            // Entferne Anführungszeichen
            if (value.front() == '"' && value.back() == '"') {
                value = value.substr(1, value.length() - 2);
            }

            this->output_file.put(SET_VAR);
            writeString(type);
            writeString(name);
            writeString(value);
        }

        // println name
        else if (line.rfind("println ", 0) == 0) {
            std::string arg = StringUtils::trim(line.substr(8));
            if (arg.front() == '"' && arg.back() == '"') {
                arg = arg.substr(1, arg.length() - 2);
                this->output_file.put(PRINT_STR);
                writeString(arg);
            } else {
                this->output_file.put(PRINT_VAR);
                writeString(arg);
            }
        }

        // if <var> == <val> {
        else if (line.rfind("if ", 0) == 0 && line.back() == '{') {
            size_t eq = line.find("==");
            std::string var = StringUtils::trim(line.substr(3, eq - 3));
            std::string val = StringUtils::trim(line.substr(eq + 2));
            val.pop_back(); // entferne '{'

            if (val.front() == '"' && val.back() == '"') {
                val = val.substr(1, val.length() - 2);
            }

            this->output_file.put(IF_EQ);
            writeString(var);
            writeString(val);

            blocks.push("if");
        }

        // else {
        else if (line == "} else {") {
            this->output_file.put(ELSE);
            blocks.push("else");
        }

        // Blockende }
        else if (line == "}") {
            this->output_file.put(END);
            if (!blocks.empty()) blocks.pop();
        }
    }

    PrintUtils::println("Compiled to main.nexo\n");
    return true;
}

