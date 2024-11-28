pageextension 50028 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
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
