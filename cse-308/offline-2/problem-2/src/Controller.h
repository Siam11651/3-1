#pragma once

#include <vector>
#include <utility>
#include "ClassDeclarations.h"
#include "Student.h"
#include "Teacher.h"
#include "AppealClaim.h"

class Controller
{
private:
    std::vector<Student *> *students;
    Teacher *teacher;
    std::vector<AppealClaim *> *appealClaims;

public:
    Controller();
    bool AddStudent(size_t id);
    bool RemoveStudent(size_t id);
    void Examine() const;
    void Reexamine() const;
    void Appeal(Student *student, size_t claim);
    ~Controller();
};