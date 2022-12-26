#include "Controller.h"

Controller::Controller()
{
    students = new std::vector<Student *>();
    teacher = new Teacher();
}

bool Controller::AddStudent(size_t id)
{
    for(size_t i = 0; i < students->size(); ++i)
    {
        if((*students)[i]->GetID() == id)
        {
            return false;
        }
    }

    students->push_back(new Student(id + 1, this));

    return true;
}

bool Controller::RemoveStudent(size_t id)
{
    for(size_t i = 0; i < students->size(); ++i)
    {
        if((*students)[i]->GetID() == id)
        {
            delete (*students)[i];

            students->erase(students->begin() + id);

            return true;
        }
    }

    return false;
}

void Controller::Examine() const
{
    for(size_t i = 0; i < students->size(); ++i)
    {
        teacher->Examine((*students)[i]);
    }
}

void Controller::Reexamine() const
{
    for(size_t i = 0; i < appealClaims->size(); ++i)
    {
        teacher->Reexamine((*appealClaims)[i]->GetStudent(), (*appealClaims)[i]->GetClaim());
    }
}

void Controller::Appeal(Student *student, size_t claim)
{
    for(size_t i = 0; i < appealClaims->size(); ++i)
    {
        if((*appealClaims)[i]->GetStudent()->GetID() == student->GetID())
        {
            delete (*appealClaims)[i];

            (*appealClaims)[i] = new AppealClaim(student, claim);

            return;
        }
    }

    appealClaims->push_back(new AppealClaim(student, claim));
}

Controller::~Controller()
{
    for(size_t i = 0; i < students->size(); ++i)
    {
        delete (*students)[i];
    }

    delete students;
    delete teacher;
}