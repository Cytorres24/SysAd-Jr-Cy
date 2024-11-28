pageextension 50016 "Purchase Credit Memo Subform" extends "Purch. Cr. Memo Subform"
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
                Editable = false;
            }
        }
        addafter("Sub Description")
        {
            field("Sub Description 2"; Rec."Sub Description 2")
            {
                ApplicationArea = all;
                caption = 'Sub Brand';
                Editable = false;
            }
        }
    }
}
