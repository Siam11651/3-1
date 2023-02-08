package problem2.CondimentDecorators;

import problem2.Beverages.Beverage;

public class ChocolateSauce extends CondimentDecorator
{
    private Beverage beverage;

    public ChocolateSauce(Beverage beverage)
    {
        this.beverage = beverage;
    }

    @Override
    public String GetDescription()
    {
        return beverage.GetDescription() + ", Chocolate Sauce";
    }

    @Override
    public int GetCost()
    {
        return beverage.GetCost() + 60;
    }
}
