report 50006 "PDS Transfer Order"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Transfer Order';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\Transfer Order.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem(TransferHeader; "Transfer Header")
        {
            column(Transfer_from_Code; "Transfer-from Code")
            {
            }
            column(Transfer_from_Name; "Transfer-from Name")
            {
            }
            column(Transfer_from_Address; "Transfer-from Address")
            {
            }
            column(Transfer_from_Address_2; "Transfer-from Address 2")
            {
            }
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
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLinkReference = TransferHeader;
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
                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLinkReference = "Transfer Line";
                    DataItemLink = "Source ID" = field("Document No."),
                                    "Source Ref. No." = field("Line No."),
                                    "Location Code" = field("transfer-to Code");
                    DataItemTableView = WHERE("Source Subtype" = FILTER(<>0));

                    column(Lot_No_; "Lot No.")
                    {
                    }
                    column(Expiration_Date; "Expiration Date")
                    {
                    }
                    column(Transferqty; Quantity)
                    {
                    }
                    trigger OnAfterGetRecord()
                    var
                        itemno: Code[20];
                        itemledger: Record "Item Ledger Entry";
                        myvar: Integer;
                    begin
                        if itemledger.get("Entry No.") then begin
                            "Reservation Entry".SetFilter("Item No.", '%1', itemledger."Item No.");
                            "Reservation Entry".SetFilter("Lot No.", '%1', itemledger."Lot No.");
                            "Reservation Entry".SetFilter("Source Ref. No.", '%1', itemledger."Document Line No.");

                            if "Reservation Entry".FindSet() then begin
                                "Reservation Entry"."Expiration Date" := itemledger."Expiration Date";
                            end;
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
