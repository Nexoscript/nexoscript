//
// Created by drago on 01.06.2025.
//

#include "NexoProjectCfgReader.h"
#include <iostream>
#include <fstream>
#include "../json/json.hpp"
using json = nlohmann::json;

NexoProject NexoProjectCfgReader::parseNexoProjectFile(const std::string& filename) {
    this->nexoProject = NexoProject();
    std::ifstream file(filename);
    if (!file.is_open()) {
        std::cerr << "File Opening Error.\n";
        return NexoProject();
    }
    json config;
    file >> config;

    auto project = config.at("project");
    this->nexoProject.setName(project.at("name"));
    this->nexoProject.setVersion(project.at("version"));
    this->nexoProject.setAuthor(project.at("author"));

    auto main = project.at("main");
    this->nexoProject.setSrc(main.at("src"));
    this->nexoProject.setMainMethod(main.at("method"));

    for (auto& [key, value] : project.at("libraries").items()) {
        this->nexoProject.addLib(key, value);
    }

    return this->nexoProject;
}
