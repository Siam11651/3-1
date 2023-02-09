package problem2.CondimentDecorators;

import problem2.Beverages.Beverage;

public class CinnamonPowder extends CondimentDecorator
{
    private Beverage beverage;

    public CinnamonPowder(Beverage beverage)
    {
        this.beverage = beverage;
    }

    @Override
    public String GetDescription()
    {
        return beverage.GetDescription() + ", Cinnamon Powder";
    }

    @Override
    public int GetCost()
    {
        return beverage.GetCost() + 50;
    }
}
