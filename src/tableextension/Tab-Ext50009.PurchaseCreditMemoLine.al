tableextension 50009 PurchaseCreditMemoLine extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(50000; "Sub Location Code"; Code[20])
        {
            Caption = 'Sub Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(50001; "Sub Description"; Text[100])
        {
            Caption = 'Sub Description';
            DataClassification = CustomerContent;
        }
        field(50002; "Sub Description 2"; Text[100])
        {
            Caption = 'Sub Description 2';
            DataClassification = CustomerContent;
        }
    }
}
