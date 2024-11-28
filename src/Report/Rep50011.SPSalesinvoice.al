report 50011 SPSalesinvoice
{
    ApplicationArea = All;
    Caption = 'SPSalesinvoice';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\PDS SP Sales Invoice.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            RequestFilterFields = "No.", "Bill-to Customer No.";

            column(Amount_Including_VAT; "Amount Including VAT") { }
            column(Amount; Amount) { }
            column(No_; "No.") { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Sell_to_Address_2; "Sell-to Address 2") { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
            column(Document_Date; "Document Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Prices_Including_VAT; "Prices Including VAT") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Shipment_Date; "Shipment Date") { }
            column(Staff_Name; "Staff Name") { }
            column(Comment;Comment){}
            column(VAT_Registration_No_;"VAT Registration No."){}
            column(Sell_to_City;"Sell-to City"){}
            column(Posting_Date;"Posting Date"){}
            column(Invoice_Discount_Amount;"Invoice Discount Amount"){}

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = SalesHeader;
                DataItemLink = "Document No." = field("No.");
                column(ItemNo; "No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Quantity; Quantity) { }
                column(Unit_Price; "Unit Price") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Line_Amount; "Line Amount") { }
                column(Line_No_; "Line No.") { }
                Column(Line_Discount__; "Line Discount %") { }
                Column(Line_Discount_Amount; "Line Discount Amount") { }
                column(RAL_WHT_Amount__LCY_;"RAL_WHT Amount (LCY)"){}
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
