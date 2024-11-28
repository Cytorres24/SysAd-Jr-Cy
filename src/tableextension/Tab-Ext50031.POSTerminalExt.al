tableextension 50031 POSTerminalExt extends "LSC POS Terminal"
{
    fields
    {
        field(50000; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(50002; PharmacistDuty; code[50])
        {
            Caption = 'Pharmacist on duty';
        }
        field(50003; LockedDate; Date)
        {
            caption = 'Locked Dispense Date';
            DataClassification = CustomerContent;
        }
        field(50004; EnableLockedDate; Boolean)
        {
            caption = 'Enable Locked Dispense Date';
            DataClassification = CustomerContent;
        }
        field(50010; "Ackn. Receipt No. Series"; Code[20])
        {
            Caption = 'Ackn. Receipt No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series".Code;
        }
        field(50011; "Type Of Trans Infocode"; Code[20])
        {
            Caption = 'Type Of Trans Infocode';
            DataClassification = CustomerContent;
            TableRelation = "LSC Infocode".Code;
        }


    }
}
