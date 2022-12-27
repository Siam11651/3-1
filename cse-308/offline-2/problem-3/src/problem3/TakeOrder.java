package problem3;

import java.util.Scanner;

class TakeOrder extends State
{
    public TakeOrder(VendingMachine vendingMachine)
    {
        super(vendingMachine);
    }

    @Override
    public void Next()
    {
        Scanner scanner = new Scanner(System.in);
        int money = scanner.nextInt();

        if(money > vendingMachine.GetPrice())
        {
            vendingMachine.SetState(new MoreMoney(vendingMachine, money - vendingMachine.GetPrice()));
        }
        else if(money == vendingMachine.GetPrice())
        {
            vendingMachine.SetState(new Transaction(vendingMachine));
        }
        else
        {
            vendingMachine.SetState(new LessMoney(vendingMachine, vendingMachine.GetPrice() - money));
        }

        scanner.close();
    }
}
