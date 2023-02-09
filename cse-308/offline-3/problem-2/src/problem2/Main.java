package problem2;

import java.util.Scanner;
import java.util.Vector;

import problem2.Beverages.*;
import problem2.CondimentDecorators.*;

public class Main
{
    public static void main(String[] args)
    {
        Scanner scanner = new Scanner(System.in);
        Vector<Beverage> beverages = new Vector<>();

        while(true)
        {
            System.out.println("Select coffee:");
            System.out.println("[1] Americano");
            System.out.println("[2] Espresso");
            System.out.println("[3] Capuccino");
            System.out.println("[4] Mocha");
            System.out.println("[0] Leave");

            int option = scanner.nextInt();

            if(option == 1)
            {
                Beverage beverage = new Americano();
                beverage = new CoffeeBean(beverage);

                beverages.add(beverage);
            }
            else if(option == 2)
            {
                Beverage beverage = new Espresso();
                beverage = new CoffeeBean(beverage);
                beverage = new DairyCream(beverage);

                beverages.add(beverage);
            }
            else if(option == 3)
            {
                Beverage beverage = new Capuccino();
                beverage = new CoffeeBean(beverage);
                beverage = new Milk(beverage);
                beverage = new CinnamonPowder(beverage);

                beverages.add(beverage);
            }
            else if(option == 4)
            {
                Beverage beverage = new Mocha();
                beverage = new CoffeeBean(beverage);
                beverage = new Milk(beverage);
                beverage = new ChocolateSauce(beverage);

                beverages.add(beverage);
            }
            else if(option == 0)
            {
                int totalCost = 0;

                for(int i = 0; i < beverages.size(); ++i)
                {
                    System.out.println("Coffee " + (i + 1) + ": ");
                    System.out.println("\tCost: " + beverages.get(i).GetCost());
                    System.out.println("\tItems: " + beverages.get(i).GetDescription());

                    totalCost += beverages.get(i).GetCost();
                }

                System.out.println("Total Cost: " + totalCost);

                break;
            }
            else
            {
                System.out.println("Invalid option, try again");
            }
        }

        scanner.close();
    }
}