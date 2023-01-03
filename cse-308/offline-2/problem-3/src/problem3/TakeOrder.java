package problem3;

import java.util.Scanner;

class TakeOrder extends State
{
    private Scanner scanner;

    public TakeOrder(VendingMachine vendingMachine)
    {
        super(vendingMachine);

        scanner = new Scanner(System.in);
    }

    @Override
    public void Simulate()
    {
        System.out.println("Taking money: ");

        int money = scanner.nextInt();

        if(vendingMachine.GetCount() > 0)
        {
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
        }
        else
        {
            vendingMachine.SetState(new NoOrder(vendingMachine));
        }
    }
}
