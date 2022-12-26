#include "Student.h"

Student::Student(Controller *controller)
{
    this->controller = controller;

    SetID(0);
    SetMarks(101);
}

Student::Student(size_t id, Controller *controller)
{
    this->controller = controller;

    SetID(id);
    SetMarks(101);
}

void Student::SetID(size_t id)
{
    this->id = id;
}

void Student::SetMarks(size_t marks)
{
    this->marks = marks;
}

size_t Student::GetID() const
{
    return id;
}

size_t Student::GetMarks() const
{
    return marks;
}

void Student::Appeal(size_t claim)
{
    controller->Appeal(this, claim);
}

Student::~Student()
{

}