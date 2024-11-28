// namespace SubcodeApp.SubcodeApp;

// using Microsoft.Sales.Document;
// using Microsoft.Inventory.Ledger;
// using Microsoft.Inventory.Tracking;

report 50001 "Delivery Receipt Qc"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Delivery Receipt';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\DeliveryReceiptQC.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";

            // Define columns for Sales Line data item
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(Sell_to_Address; "Sell-to Address")
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            dataitem("sales line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No." = field("No.");
                column(DocumentNo; "Document No.")
                {
                }
                column(No; "No.")
                {
                }
                column(Sub_Description; "Sub Description")
                {
                }
                column(Sub_Description_2; "Sub Description 2")
                {
                }
                column(UnitofMeasureCode; "Unit of Measure Code")
                {
                }
                column(UnitPrice; "Unit Price")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Amount; Amount)
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                }
                column(Qc_Item_Code; "Qc Item Code")
                {
                }
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLinkReference = "sales line";
                    DataItemLink = "Source ID" = field("Document No."),
                                   "Location Code" = field("Location Code"),
                                   "Source Ref. No." = field("Line No."),
                                   "Item No." = field("No.");
                    column(Lot_No_; "Lot No.")
                    {
                    }
                    COLUMN(Expiration_Date; "Expiration Date")
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        itemno: Code[20];
                        itemledger: Record "Item Ledger Entry";
                        myvar: Integer;
                    begin
                        itemno := "Item No.";
                        "Reservation Entry".SetFilter("Item No.", '%1', itemledger."Item No.");
                        "Reservation Entry".SetFilter("Lot No.", '%1', itemledger."Lot No.");
                       if itemledger.FindSet() THEN begin
                            "Reservation Entry"."Expiration Date" := itemledger."Expiration Date";
                        end;
                    end;
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
