pageextension 50047 POSTerminalExt extends "LSC POS Terminal Card"
{
    layout
    {
        addbefore(Profiles)
        {
             field("Type Of Trans Infocode"; Rec."Type Of Trans Infocode")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }

        addlast(General)
        {
            field("Ackn. Receipt No. Series"; Rec."Ackn. Receipt No. Series")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }

        addafter("Store No.")
        {
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = all;
            }
            field(PharmacistDuty; Rec.PharmacistDuty)
            {
                ApplicationArea = all;
            }
            field(LockedDate;Rec.LockedDate)
            {

            }
            field(EnableLockedDate;Rec.EnableLockedDate)
            {
                
            }
        }
    }
}
