#include <iostream>
#include <string>
#include <sstream>

class Wing
{
protected:
    std::string name;
public:
    virtual std::string GetName() const = 0;
};

class Engine
{
protected:
    std::string name;
public:
    virtual std::string GetName() const = 0;
};

class BoeingEngine : public Engine
{
public:
    std::string GetName() const
    {
        return "Boeing Engine";
    }
};

class AirbusEngine : public Engine
{
public:
    std::string GetName() const
    {
        return "Airbus Engine";
    }
};

class SafranEngine : public Engine
{
public:
    std::string GetName() const
    {
        return "Safran Engine";
    }
};

class BoeingWing : public Wing
{
public:
    std::string GetName() const
    {
        return "Boeing Wing";
    }
};

class AirbusWing : public Wing
{
public:
    std::string GetName() const
    {
        return "Airbus Wing";
    }
};

class SafranWing : public Wing
{
public:
    std::string GetName() const
    {
        return "Safran Wing";
    }
};

class Airplane
{
protected:
    std::string name;
    Wing *wing;
    Engine *engine;

public:
    virtual std::string GetName() const
    {
        return name;
    }

    virtual Wing *GetWing() const
    {
        return wing;
    }

    virtual Engine *GetEngine() const
    {
        return engine;
    }

    ~Airplane()
    {
        delete wing;
        delete engine;
    }
};

class Boeing : public Airplane
{
public:
    Boeing()
    {
        name = "Boeing";
        wing = new BoeingWing();
        engine = new BoeingEngine();
    }
};

class Airbus : public Airplane
{
public:
    Airbus()
    {
        name = "Airbus";
        wing = new AirbusWing();
        engine = new AirbusEngine();
    }
};

class Safran : public Airplane
{
public:
    Safran()
    {
        name = "Safran";
        wing = new SafranWing();
        engine = new SafranEngine();
    }
};

class AirplaneBuilder
{
public:
    static Airplane *GetNewAirplanePointer(const std::string &company)
    {
        if(company == "boeing")
        {
            return new Boeing();
        }
        else if(company == "airbus")
        {
            return new Airbus();
        }
        else if(company == "safran")
        {
            return new Safran();
        }
        else
        {
            return NULL;
        }
    }
};

std::string Format(const std::string &string)
{
    std::string toReturn = string;

    for(size_t i = 0; i < toReturn.size(); ++i)
    {
        if('A' <= toReturn[i] && toReturn[i] <= 'Z')
        {
            toReturn[i] -= 'A';
            toReturn[i] += 'a';
        }
    }

    return toReturn;
}

int main()
{
    while(true)
    {
        std::string company;

        std::cin >> company;

        company = Format(company);

        Airplane *airplane = AirplaneBuilder::GetNewAirplanePointer(company);

        if(airplane != NULL)
        {
            std::cout << "Name: " << airplane->GetName() << std::endl;
            std::cout << "Wing: " << airplane->GetWing()->GetName() << std::endl;
            std::cout << "Engine: " << airplane->GetEngine()->GetName() << std::endl;
        }
        else
        {
            std::cout << "No such plane" << std::endl;
        }

        delete airplane;
    }

    return 0;
}