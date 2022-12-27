package problem3;

import java.util.Scanner;

class LessMoney extends State
{
    private int money;

    public LessMoney(VendingMachine vendingMachine, int money)
    {
        super(vendingMachine);

        this.money = money;
    }

    @Override
    public void Next()
    {
        System.out.println("Money less by: " + money);

        Scanner scanner = new Scanner(System.in);
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

        scanner.close();
    }
}
