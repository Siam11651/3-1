package problem3;

public class Main
{
    public static void main(String[] args)
    {
        VendingMachine vendingMachine = new VendingMachine(100, 5);

        while(!(vendingMachine.GetState() instanceof NoOrder))
        {
            vendingMachine.InsertMoney();
            vendingMachine.ReturnMoney();
            vendingMachine.Dispense();
        }

        System.out.println("Out of products");
    }
}
