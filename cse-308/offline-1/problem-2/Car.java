public abstract class Car
{
    protected String brand;
    protected Color color;
    protected Engine engine;
    protected WheelType wheelType;

    public String GetBrand()
    {
        return brand;
    }

    public Color GetColor()
    {
        return color;
    }

    public Engine GetEngine()
    {
        return engine;
    }

    public WheelType GetWheelType()
    {
        return wheelType;
    }
}
