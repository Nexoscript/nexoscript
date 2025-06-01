//
// Created by drago on 01.06.2025.
//

#ifndef NEXOPROJECTCFGREADER_H
#define NEXOPROJECTCFGREADER_H

#include "NexoProject.h"

class NexoProjectCfgReader {
    private:
    NexoProject nexoProject;
    public:
        NexoProject parseNexoProjectFile(const std::string& filename);
};



#endif //NEXOPROJECTCFGREADER_H
