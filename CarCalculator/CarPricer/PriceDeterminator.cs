using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CarCalculator.CarPricer
{
    public class PriceDeterminator
    {
        public decimal DetermineCarPrice(Car car)
        {
            if (car == null) return 0;
            decimal result = car.PurchaseValue;

            //Given the number of months of how old the car is, reduce its value one-half
            // (0.5) percent.After 10 years, it's value cannot be reduced further by age. This is not 
            //cumulative.
            if (car.AgeInMonths > 0)
            {
                result = GetPriceByAge(car.AgeInMonths, result);
            }

            //For every 1,000 miles on the car, reduce its value by one-fifth of a
            //percent(0.2).Do not consider remaining miles. After 150,000 miles, it's 
            //value cannot be reduced further by miles.

            if (car.NumberOfMiles > 999)
            {
                result = GetPriceByMiles(car.NumberOfMiles, result);
            }

            //PREVIOUS OWNER:    If the car has had more than 2 previous owners, reduce its value
            //by twenty - five(25) percent.
            if (car.NumberOfPreviousOwners > 2)
            {
                result = GetPriceByPreviousOwners(car.NumberOfPreviousOwners, result);
            }

            //COLLISION:For every reported collision the car has been in, remove two(2)
            //percent of it's value up to five (5) collisions.
            if (car.NumberOfCollisions > 0)
            {
                result = GetPriceByCollision(car.NumberOfCollisions, result);
            }

            //If the car has had no previous
            //owners, add ten(10) percent of the FINAL car value at the end.
            if (car.NumberOfPreviousOwners == 0)
            {
                result = AddPercentToValue(Convert.ToDecimal(10.00), result);
            }

            return result;
        }

        /*
         * Function: GetPriceByAge - reduce 0.5 percent for every month upto 10 years(120 months)
         * Parameters: months, currentValues
         * returns decimal value
         */
        public decimal GetPriceByAge(int months, decimal currentValue)
        {
            if (currentValue == 0) return currentValue;
            var halfPercent = (currentValue / 100) * Convert.ToDecimal(0.5);//half percent
            if (months > 120)
            {
                //for car older than 10 years
                //price can't be reduce after 10 years so fix 120 months
                for (var i = 0; i < 120; i++)
                    currentValue -= halfPercent;
            }
            else
            {
                //for car less than 10 years old
                for (var i = 0; i < months; i++)
                    currentValue -= halfPercent;
            }
            return currentValue;
        }

        /*
         * Function: GetPriceByMiles - reduce 0.2 percent for every 1000 upto 15000 miles
         * Parameters: miles, currentValues
         * returns decimal value
         */
        public decimal GetPriceByMiles(int miles, decimal currentValue)
        {
            if (currentValue == 0) return currentValue;
            var oneFifthPercent = (currentValue / 100) * Convert.ToDecimal(0.2);//one fifth percent
            if (miles > 150000) miles = 150000;//if more than 150000 miles, make it to 150000
            int roundedMiles = miles - miles % 1000;//remove remaining miles and round to 1000
            var numberOfMilesDivision = roundedMiles / 1000;//number of times percent needed to take off
            for (var i = 0; i < numberOfMilesDivision; i++)
                currentValue -= oneFifthPercent;
            return currentValue;
        }

        /*
         * Function: GetPriceByPreviousOwners - reduce 25 percent value if car had more than 2 previous owners
         * Parameters: miles, currentValues
         * returns decimal value
         */
        public decimal GetPriceByPreviousOwners(int owners, decimal currentValue)
        {
            if (currentValue == 0) return currentValue;
            var twentyFivePercent = (currentValue / 100) * Convert.ToDecimal(25.00);//25 percent
            currentValue -= twentyFivePercent;
            return currentValue;
        }

        /*
         * Function: GetPriceByPreviousOwners - reduce 2 percent value for every collision upto 5 collisions
         * Parameters: miles, currentValues
         * returns decimal value
         */
        public decimal GetPriceByCollision(int collisions, decimal currentValue)
        {
            if (currentValue == 0) return currentValue;
            var twoPercent = (currentValue / 100) * Convert.ToDecimal(2.0);//2 percent
            if (collisions > 5) collisions = 5;//if collisions are more than 5, make it to 5 as after 5 collisions, price don't drop
            for (var i = 0; i < collisions; i++)
                currentValue -= twoPercent;
            return currentValue;
        }
        public decimal AddPercentToValue(decimal percent, decimal currentValue)
        {
            if (percent == 0 || currentValue == 0) return currentValue;
            currentValue += (currentValue / 100) * percent;//add percent to final value if no previous owner
            return currentValue;
        }
    }

}
