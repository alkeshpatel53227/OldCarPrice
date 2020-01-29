<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CarCalculator._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h3><b><u>Old Car Price Calculator - Instructions</u></b></h3>
        <p class="lead">
            You are tasked with writing an algorithm that determines the value of a used car, 
 given several factors.<br />
            <br />

            <b>AGE: </b>Given the number of months of how old the car is, reduce its value one-half 
            (0.5) percent.
            After 10 years, it's value cannot be reduced further by age. This is not 
            cumulative.
           <br />
            <br />
            <b>MILES:</b>    For every 1,000 miles on the car, reduce its value by one-fifth of a
              percent (0.2). Do not consider remaining miles. After 150,000 miles, it's 
              value cannot be reduced further by miles.
            <br />
            <br />
            <b>PREVIOUS OWNER:</b>    If the car has had more than 2 previous owners, reduce its value 
                       by twenty-five (25) percent. If the car has had no previous  
                       owners, add ten (10) percent of the FINAL car value at the end.
               <br />
            <br />
            <b>COLLISION: </b>For every reported collision the car has been in, remove two (2) 
                      percent of it's value up to five (5) collisions.
             <br />
            <br />

            Each factor should be off of the result of the previous value in the order of
       <b>
           <ol>
               <li>AGE</li>
               <li>MILES</li>
               <li>PREVIOUS OWNER</li>
               <li>COLLISION</li>

           </ol>
       </b>
            <br />
            <br />
            E.g., Start with the current value of the car, then adjust for age, take that  
     result then adjust for miles, then collision, and finally previous owner. 
     Note that if previous owner, had a positive effect, then it should be applied 
     AFTER step 4. If a negative effect, then BEFORE step 4.
            <br />
            <br />
            <i>AssertCarValue(decimal expectValue, decimal purchaseValue, 
        int ageInMonths, int numberOfMiles, int numberOfPreviousOwners, int 
        numberOfCollisions)</i>
            <br />
            <br />
            <b>Some Sample Test Data</b><br />
            AssertCarValue(25313.40m, 35000m, 3 * 12, 50000,  1, 1);<br />
            AssertCarValue(19688.20m, 35000m, 3 * 12, 150000, 1, 1);<br />
            AssertCarValue(19688.20m, 35000m, 3 * 12, 250000, 1, 1);<br />
            AssertCarValue(20090.00m, 35000m, 3 * 12, 250000, 1, 0);<br />
            AssertCarValue(21657.02m, 35000m, 3 * 12, 250000, 0, 1);<br />

        </p>
        <p></p>
        <h4><b>Calculate here</b></h4>
         <div class="row">
        <div class="col-md-12">

            <p>

                <form id="frmCar" action="">
                    Purchase Value:<br>
                    <input type="number" name="purchaseValue" id="purchaseValue" min="0" max="9999999" oninput="validity.valid||(value='');">
                    <br>
                    Months:<br>
                    <input type="number" name="months" id="months"  min="0" max="999" oninput="validity.valid||(value='');" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">
                    <br>
                    Miles:<br>
                    <input type="number" name="miles" id="miles"  min="0" max="999999" oninput="validity.valid||(value='');" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">
                    <br>
                    Number of Previous Owners:<br>
                    <input type="number" name="owners" id="owners"  min="0" max="99" oninput="validity.valid||(value='');" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">
                    <br>
                    Number of Collisions:<br>
                    <input type="number" name="collisions" id="collisions" max="99"  min="0" oninput="validity.valid||(value='');" onkeypress="return (event.charCode == 8 || event.charCode == 0 || event.charCode == 13) ? null : event.charCode >= 48 && event.charCode <= 57">
                    <br>
                    <br>
                    <input type="button" value="Submit" id="btnCar" onclick="submitCar()" class="btn btn-primary btn-lg">
                    <a href="https://github.com/alkeshpatel53227/OldCarPrice" class="btn btn-success btn-lg">
                        View Code on GitHub <i class="fa fa-github" aria-hidden="true"></i></a>
                </form>

            </p>
            <div id="responseDiv" style="font-size:18px;color:blue"></div>
        </div>
    </div>
    </div>

   

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="footerContent" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
        $(document).ready(function () {
              
            $("#btnCar").click(function () {
                if ($('#purchaseValue').val() == "" ||  $('#purchaseValue').val() < 0) return;
                if ($('#months').val() == "" || $('#months').val() < 0) return;
                if ($('#miles').val() == "" ||  $('#miles').val() < 0) return;
                if ($('#owners').val() == "" ||  $('#owners').val() < 0) return;
                if ($('#collisions').val() == "" ||  $('#collisions').val() < 0) return;
                var carValue = {
                    purchaseValue: $('#purchaseValue').val(),
                    months: $('#months').val(),
                    miles: $('#miles').val(),
                    owners: $('#owners').val(),
                    collisions: $('#collisions').val()
                };
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/GetCarValue",
                    data: JSON.stringify(carValue),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        var result = "<b>Your car value is " + data.d + ".</b>"
                        $("#responseDiv").html(result);
                       
                    }
                });


            });
        });
    </script>
    </asp:Content>
