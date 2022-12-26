#include "AppealClaim.h"

AppealClaim::AppealClaim(Student *student, size_t claim)
{
    this->student = student;
    this->claim = claim;
}

Student *AppealClaim::GetStudent() const
{
    return student;
}

size_t AppealClaim::GetClaim() const
{
    return claim;
}

AppealClaim::~AppealClaim()
{
    
}