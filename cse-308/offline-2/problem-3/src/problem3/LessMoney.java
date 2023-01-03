package problem3;

import java.util.Scanner;

class LessMoney extends State
{
    private int money;
    private Scanner scanner;

    public LessMoney(VendingMachine vendingMachine, int money)
    {
        super(vendingMachine);

        this.money = money;
        scanner = new Scanner(System.in);
    }

    @Override
    public void Simulate()
    {
        System.out.println("Money less by: " + money);
        System.out.println("Add more money: ");

        int paid = scanner.nextInt();

        if(paid > money)
        {
            vendingMachine.SetState(new MoreMoney(vendingMachine, paid - money));
        }
        else if(paid == money)
        {
            vendingMachine.SetState(new Transaction(vendingMachine));
        }
        else
        {
            vendingMachine.SetState(new LessMoney(vendingMachine, money - paid));
        }
    }
}
