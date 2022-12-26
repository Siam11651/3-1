#pragma once

#include <cstdlib>
#include "ClassDeclarations.h"
#include "Controller.h"

class Teacher
{
public:
    Teacher();
    void Examine(Student *student) const;
    bool Reexamine(Student *student, size_t claim) const;
    ~Teacher();
};