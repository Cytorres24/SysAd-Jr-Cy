report 50003 SalesShipment
{
    ApplicationArea = Basic, Suite;
    Caption = 'Sales Shipment';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\Salesshipment.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Contact; "Sell-to Contact")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(Sell_to_Address_2; "Sell-to Address 2")
            {
            }
            column(Sell_to_City; "Sell-to City")
            {
            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(No_; "No.")
            {
            }
            column(Staff_Name; "Staff Name")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLinkReference = SalesShipmentHeader;
                DataItemLink = "Document No." = field("No.");
                column(ItemNo_; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {

                    DataItemLinkReference = "Sales Shipment Line";
                    DataItemLink = "Document No." = field("Document No."),
                                   "Location Code" = field("Location Code"),
                                   "Document Line No." = field("Line No."),
                                   "Item No." = field("No.");

                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Expiration_Date; "Expiration Date")
                    {
                    }
                    column(Purchqty; Quantity)
                    {
                    }
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
