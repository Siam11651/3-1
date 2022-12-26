#include "Teacher.h"

Teacher::Teacher()
{

}

void Teacher::Examine(Student *student) const
{
    student->SetMarks(std::rand() % 101); // anything from 0-100 inclusive
}

bool Teacher::Reexamine(Student *student, size_t claim) const
{
    size_t value = std::rand() % 100;

    if(value < 75) // 75% chance of accepting appeal
    {
        student->SetMarks(claim);

        return true;
    }

    return false;
}

Teacher::~Teacher()
{

}