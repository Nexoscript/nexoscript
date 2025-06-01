//
// Created by drago on 01.06.2025.
//

#include "NexoProject.h"

NexoProject::NexoProject(const std::string &name, const std::string &version, const std::string &author,
    const std::string &src, const std::string &main_method) {
    this->name = name;
    this->version = version;
    this->author = author;
    this->src = src;
    this->main_method = main_method;
}

NexoProject::NexoProject() {
    this->name = "";
    this->version = "";
    this->author = "";
    this->src = "";
    this->main_method = "";
}

std::string NexoProject::getName() {
    return this->name;
}

std::string NexoProject::getVersion() {
    return this->version;
}

std::string NexoProject::getAuthor() {
    return this->author;
}

std::string NexoProject::getSrc() {
    return this->src;
}

std::string NexoProject::getMainMethod() {
    return this->main_method;
}

std::map<std::string, std::string> NexoProject::getLibs() {
    return this->libs;
}


void NexoProject::setName(const std::string &name) {
    this->name = name;
}

void NexoProject::setVersion(const std::string &version) {
    this->version = version;
}

void NexoProject::setAuthor(const std::string &author) {
    this->author = author;
}

void NexoProject::setSrc(const std::string &src) {
    this->src = src;
}

void NexoProject::setMainMethod(const std::string &main_method) {
    this->main_method = main_method;
}

void NexoProject::addLib(const std::string& libName, const std::string &libPath) {
    this->libs[libName] = libPath;
}

void NexoProject::removeLib(const std::string& libName) {
    for (auto it = this->libs.begin(); it != this->libs.end(); ++it) {
        if (it->second == libName) {
            this->libs.erase(it);
        }
    }
}



