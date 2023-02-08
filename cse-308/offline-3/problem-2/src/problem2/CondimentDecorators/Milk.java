package problem2.CondimentDecorators;

import problem2.Beverages.Beverage;

public class Milk extends CondimentDecorator
{
    private Beverage beverage;

    public Milk(Beverage beverage)
    {
        this.beverage = beverage;
    }

    @Override
    public String GetDescription()
    {
        return beverage.GetDescription() + ", Milk";
    }

    @Override
    public int GetCost()
    {
        return beverage.GetCost() + 30;
    }
}
