package problem2.CondimentDecorators;

import problem2.Beverages.Beverage;

public class DairyCream extends CondimentDecorator
{
    private Beverage beverage;

    public DairyCream(Beverage beverage)
    {
        this.beverage = beverage;
    }

    @Override
    public String GetDescription()
    {
        return beverage.GetDescription() + ", Dairy Cream";
    }

    @Override
    public int GetCost()
    {
        return beverage.GetCost() + 40;
    }
}
