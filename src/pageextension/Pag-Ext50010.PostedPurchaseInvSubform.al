pageextension 50010 "Posted Purchase Inv. Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("quantity")
        {
            field("Sub Location"; Rec."Sub Location code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Sub Location")
        {
            field("Sub Description"; Rec."Sub Description")
            {
                ApplicationArea = all;
            }
        }
        addafter("Sub Description")
        {
            field("Sub Description 2"; Rec."Sub Description 2")
            {
                ApplicationArea = all;
                caption = 'Sub Brand';
            }
        }
    }
}

