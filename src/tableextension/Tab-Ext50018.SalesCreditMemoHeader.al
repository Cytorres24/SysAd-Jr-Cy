tableextension 50018 SalesCreditMemoHeader extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50000; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
            field(50001; "Staff ID"; Code[20])
        {
            Caption = 'Staff ID';
            DataClassification = CustomerContent;
        }
    }
}
