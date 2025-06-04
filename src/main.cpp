#include "nexocompiler/NexoCompiler.h"
#include "nexoengine/NexoEngine.h"
#include "util/PrintUtils.h"
#include "nexoproject/NexoProject.h"
#include "nexoproject/NexoProjectCfgReader.h"

int main() {
    PrintUtils::println("########## Starting NexoScript! ##########");

    std::string path = "../tests/testproject/test.nexoproject";
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

try {
    auto nexo_compiler = NexoCompiler(
        "../tests/testproject/src/main.nexoscript",
        "../tests/testproject/src/main.nexo"
    );
    
    if (!nexo_compiler.compile()) {
        PrintUtils::println("Fehler beim Kompilieren der Nexoscript-Datei");
        return 1;
    }

    auto nexo_engine = NexoEngine(
        "../tests/testproject/src/main.nexo"
    );
    
    if (!nexo_engine.compile()) {
        PrintUtils::println("Fehler beim Ausführen der Nexo-Datei");
        return 1;
    }

    // Überprüfen Sie den Output
    PrintUtils::println("Kompilierung und Ausführung erfolgreich abgeschlossen");
} catch (const std::exception& e) {
    PrintUtils::println("Fehler aufgetreten: " + std::string(e.what()));
    return 1;
}
    return 0;
}