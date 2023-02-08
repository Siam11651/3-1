package problem2.Beverages;

public abstract class Beverage
{
    protected String description;

    public Beverage()
    {
        description = "untitled";
    }

    public String GetDescription()
    {
        return description;
    }

    public abstract int GetCost();
}