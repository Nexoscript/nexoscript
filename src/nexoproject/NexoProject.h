//
// Created by drago on 01.06.2025.
//

#ifndef NEXOPROJECT_H
#define NEXOPROJECT_H

#include <map>
#include <string>

class NexoProject {
    private:
        std::string name;
        std::string version;
        std::string author;
        std::string src;
        std::string main_method;
        std::map<std::string, std::string> libs;
    public:
        NexoProject(
            const std::string &name, const std::string &version, const std::string &author,
            const std::string &src, const std::string &main_method
            );
        NexoProject();
        std::string getName();
        std::string getVersion();
        std::string getAuthor();
        std::string getSrc();
        std::string getMainMethod();
        std::map<std::string, std::string> getLibs();
        void setName(const std::string &name);
        void setVersion(const std::string &version);
        void setAuthor(const std::string &author);
        void setSrc(const std::string &src);
        void setMainMethod(const std::string &main_method);
        void addLib(const std::string& libName, const std::string &libPath);
        void removeLib(const std::string& libName);
};



#endif //NEXOPROJECT_H
