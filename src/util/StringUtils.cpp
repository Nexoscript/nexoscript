//
// Created by drago on 01.06.2025.
//

#include "StringUtils.h"

std::vector<std::string> StringUtils::split(const std::string &input, char delim) {
    std::vector<std::string> result;
    std::stringstream ss(input);
    std::string item;

    while (std::getline(ss, item, delim)) {
        result.push_back(item);
    }

    return result;
}

std::string StringUtils::trim(const std::string &input) {
    std::istringstream iss(input);
    std::string word, result;

    while (iss >> word) {
        if (!result.empty()) {
            result += " ";
        }
        result += word;
    }

    return result;
}

