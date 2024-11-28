tableextension 50064 "LSC Transaction Header PDI" extends "LSC Transaction Header"
{
    fields
    {
        field(50020; "Dispense Date2"; Date)
        {
            Caption = 'Dispense Date2';
            DataClassification = CustomerContent;
        }
        field(50021; "Ackn. Receipt No."; Code[20])
        {
            Caption = 'Ackn. Receipt No.';
            DataClassification = CustomerContent;
        }
    }
}
