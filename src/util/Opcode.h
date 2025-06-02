//
// Created by drago on 02.06.2025.
//

#ifndef OPCODE_H
#define OPCODE_H

enum Opcode {
    SET_VAR = 0x01,
    PRINT_VAR = 0x02,
    PRINT_STR = 0x03,
    IF_EQ    = 0x10,
    ELSE     = 0x11,
    END      = 0x12
};

#endif //OPCODE_H
