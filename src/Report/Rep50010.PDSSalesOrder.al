report 50010 "PDS Sales Order"
{
    ApplicationArea = All;
    Caption = 'PDS Sales Order';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\PDS Sales Order.rdl';
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
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
            column(Document_Date; "Document Date") { }
            column(Payment_Terms_Code; "Payment Terms Code") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Prices_Including_VAT; "Prices Including VAT") { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Shipment_Date; "Shipment Date") { }
            column(Staff_Name; "Staff Name") { }
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
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLinkReference = "sales line";
                    DataItemLink = "Source ID" = field("Document No."),
                                   "Location Code" = field("Location Code"),
                                   "Source Ref. No." = field("Line No."),
                                   "Item No." = field("No.");
                    column(Lot_No_; "Lot No.") { }
                    column(Expiration_Date; "Expiration Date") { }
                    COLUMN(SalesQty; Quantity) { }
                }
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
