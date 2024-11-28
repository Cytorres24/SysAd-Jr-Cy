tableextension 50030 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50000; "Staff ID"; Code[20])
        {
            Caption = 'Staff ID';
            DataClassification = CustomerContent;
        }
    }
}
