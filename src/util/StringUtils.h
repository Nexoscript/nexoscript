//
// Created by drago on 01.06.2025.
//

#ifndef STRINGUTILS_H
#define STRINGUTILS_H

#include <string>
#include <vector>
#include <sstream>
#include <map>

class StringUtils {
public:
    static std::vector<std::string> split(const std::string& input, char delim);
    static std::string trim(const std::string& input);
};



#endif //STRINGUTILS_H
