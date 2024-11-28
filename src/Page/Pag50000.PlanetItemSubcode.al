// namespace SubcodeApp.SubcodeApp;
// using Microsoft.Purchases.Document;
// using Microsoft.Sales.Document;
// using Microsoft.Inventory.Transfer;

page 50000 "Planet Item Subcode"
{
    ApplicationArea = All;
    Caption = 'Planet Item Subcode';
    PageType = List;
    SourceTable = "Planet Subcode";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ToolTip = 'Specifies the value of the Item Code field.', Comment = '%';
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Sub Description"; Rec."Sub Description")
                {
                    ToolTip = 'Specifies the value of the Sub Description field.', Comment = '%';
                }
                field("Sub Description 2"; Rec."Sub Description 2")
                {
                    ToolTip = 'Specifies the value of the Sub Description field.', Comment = '%';
                    Caption = 'Sub Brand';
                }
                field(UnitofMeasure; Rec.UnitofMeasure)
                {
                    ToolTip = 'Specifies the value of the Item Code field.', Comment = '%';
                    Caption = 'Unit of Measure';
                    Editable = false;
                }
                field(Salestype;Rec.Salestype)
                {
                    Caption = 'Sales Type';     
                }
                // field(Enabled;Rec.Enabled)
                // {
                    
                // }
                
            }
        }
    }



    local procedure UpdateRecordDescription(ItemCode: code[20]; LocationCode: code[20]; NewDescription: text[30]; NewBrand: text[30])
    var
        salesline: Record "Sales Line";
        transferline: Record "Transfer Line";
        purchline: record "Purchase Line";
    begin
        //Sales Line
        salesline.SetRange("No.", ItemCode);
        salesline.SetRange("Sub Location code", LocationCode);
        if salesline.FindSet() then
            repeat
                salesline."Sub Description" := NewDescription;
                salesline."Sub Description 2" := NewBrand;
                salesline.modify;
            until salesline.Next() = 0;

        //Transferline
        TransferLine.Setrange("Item No.", ItemCode);
        TransferLine.Setrange(transferline."Sub Location code", LocationCode);
        If TransferLine.Findset() then
            repeat
                TransferLine."Sub Description" := NewDescription;
                transferline."Sub Description 2" := NewBrand;
                TransferLine.Modify();
            until TransferLine.Next() = 0;

        //Purchase Line
        PurchLine.Setrange("No.", ItemCode);
        PurchLine.Setrange(purchline."Sub Location code", LocationCode);
        If PurchLine.Findset() then
            repeat
                PurchLine."Sub Description" := NewDescription;
                purchline."Description 2" := NewBrand;
                PurchLine.Modify();
            until PurchLine.Next() = 0;
    end;
}

