package problem3;

public class Main
{
    public static void main(String[] args)
    {
        Scanner.stdin = new java.util.Scanner(System.in);
        VendingMachine vendingMachine = new VendingMachine(100, 5);

        vendingMachine.Simulate();

        Scanner.stdin.close();
    }
}
