package problem3;

class LessMoney extends State
{
    private int money;

    public LessMoney(VendingMachine vendingMachine, int money)
    {
        super(vendingMachine);

        this.money = money;
    }

    @Override
    public void Simulate()
    {
        System.out.println("Money less by: " + money);
        System.out.println("Add more money: ");

        int paid = Scanner.stdin.nextInt();

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
