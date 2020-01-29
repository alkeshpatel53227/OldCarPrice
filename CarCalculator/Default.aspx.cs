using CarCalculator.CarPricer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarCalculator
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static decimal GetCarValue(decimal purchaseValue, int months, int miles, int owners, int collisions)
        {
            Car car = new Car
            {
                AgeInMonths = months,
                NumberOfCollisions = collisions,
                NumberOfMiles = miles,
                NumberOfPreviousOwners = owners,
                PurchaseValue = purchaseValue
            };
            PriceDeterminator priceDeterminator = new PriceDeterminator();
            var carPrice = priceDeterminator.DetermineCarPrice(car);
            return carPrice;
        }
    }

   
}