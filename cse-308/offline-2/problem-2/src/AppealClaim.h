#pragma once

#include <cstddef>
#include "ClassDeclarations.h"
#include "Student.h"

class AppealClaim
{
private:
    Student *student;
    size_t claim;

public:
    AppealClaim(Student *student, size_t claim);
    Student *GetStudent() const;
    size_t GetClaim() const;
    ~AppealClaim();
};