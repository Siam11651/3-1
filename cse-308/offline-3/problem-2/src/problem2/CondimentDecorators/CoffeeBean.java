package problem2.CondimentDecorators;

import problem2.Beverages.Beverage;

public class CoffeeBean extends CondimentDecorator
{
    private Beverage beverage;

    public CoffeeBean(Beverage beverage)
    {
        this.beverage = beverage;
    }

    @Override
    public String GetDescription()
    {
        return beverage.GetDescription() + ", Coffee Bean";
    }

    @Override
    public int GetCost()
    {
        return beverage.GetCost() + 30;
    }
}
