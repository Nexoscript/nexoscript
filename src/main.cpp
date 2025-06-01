#include "util/PrintUtils.h"
#include "nexoproject/NexoProject.h"
#include "nexoproject/NexoProjectCfgReader.h"

int main() {
    PrintUtils::println("########## Starting NexoScript! ##########");

    std::string path = "D:/Programing/clion-projects/nexoscript-v3/tests/testproject/test.nexoproject";
    NexoProjectCfgReader reader = NexoProjectCfgReader();
    NexoProject projectConfig = reader.parseNexoProjectFile(path);

    PrintUtils::println("Name: " + projectConfig.getName());
    PrintUtils::println("Version: " + projectConfig.getVersion());
    PrintUtils::println("Author: " + projectConfig.getAuthor());
    PrintUtils::println("Src: " + projectConfig.getSrc());
    PrintUtils::println("Main Method: " + projectConfig.getMainMethod());

    for (auto lib : projectConfig.getLibs()) {
        PrintUtils::println("Library: " + lib.first + " = " + lib.second);
    }

    PrintUtils::println("########## Exited NexoScript! ##########");
    return 0;
}
