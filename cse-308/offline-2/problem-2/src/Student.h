#pragma once

#include <cstddef>
#include "ClassDeclarations.h"
#include "Controller.h"

class Student
{
private:
    size_t id, marks;
    Controller *controller;

public:
    Student(Controller *controller);
    Student(size_t id, Controller *controller);
    void SetID(size_t id);
    void SetMarks(size_t marks);
    size_t GetMarks() const;
    size_t GetID() const;
    void Appeal(size_t claim);
    ~Student();
};