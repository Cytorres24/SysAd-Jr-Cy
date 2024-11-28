report 50007 "PDS Transfer Shipment"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Transfer Shipment';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\Transfer Shipment.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(TransferShipmentHeader; "Transfer Shipment Header")
        {
            column(Transfer_to_Name; "Transfer-to Name")
            {
            }
            column(Transfer_to_Code; "Transfer-to Code")
            {
            }
            column(Transfer_to_Address; "Transfer-to Address")
            {
            }
            column(Transfer_to_Address_2; "Transfer-to Address 2")
            {
            }
            column(Staff_Name; "Staff Name")
            {
            }
            column(No_; "No.")
            {
            }
            column(Shipment_Method_Code; "Shipment Method Code")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(In_Transit_Code; "In-Transit Code")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Transfer_Order_No_; "Transfer Order No.")
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLinkReference = TransferShipmentHeader;
                DataItemLink = "Document No." = field("No.");
                column(Item_No_; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Unit_of_Measure; "Unit of Measure")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLinkReference = "Transfer Shipment Line";
                    DataItemLink = "Document No." = field("Document No."),
                                   "Document Line No." = field("Line No."),
                                   "Item No." = field("item no.");
                                   DataItemTableView = where(Open = filter(true));
                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Expiration_Date; "Expiration Date")
                    {
                    }
                    column(transferqty; Quantity)
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
