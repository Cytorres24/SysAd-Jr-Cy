report 50004 "Purchase Return Shipment"
{
      ApplicationArea = Basic, Suite;
    Caption = 'Purchase Return Shipment';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\Purchase Return Shipment.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(ReturnShipmentHeader; "Return Shipment Header")
        {
            column(Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            {
            }
            column(Document_No; "No.")
            {
            }
            column(Buy_from_Address; "Buy-from Address")
            {
            }
            column(Buy_from_Address_2; "Buy-from Address 2")
            {
            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            // column(Order_No_; "Order No.")
            // {
            // }
            column(Staff_Name; "Staff Name")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            column(Ship_to_Address; "Ship-to Address")
            {
            }
            column(Ship_to_Address_2; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            {
            }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            {
            }
            column(Pay_to_Name; "Pay-to Name")
            {
            }
            column(Pay_to_Address; "Pay-to Address")
            {
            }
            column(Pay_to_Address_2; "Pay-to Address 2")
            {
            }
            column(Pay_to_City; "Pay-to City")
            {
            }
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                DataItemLinkReference = "ReturnShipmentHeader";
                DataItemLink = "Document No." = field("No.");
                column(No_; "No.")
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
                    DataItemLinkReference = "Return Shipment Line";
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
