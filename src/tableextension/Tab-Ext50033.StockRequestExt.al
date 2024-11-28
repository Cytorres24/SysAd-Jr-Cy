tableextension 50033 "Stock Request Ext" extends "LSC InStore Stock Req. Header"
{
    fields
    {
        field(50000; "Staff ID"; Code[20])
        {
            Caption = 'Staff ID';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StaffValidation: Codeunit "PDS General Utility";
            begin
                StaffValidation.ValidationStaff("Staff ID");
            end;
        }
        field(50001; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
    }
}
