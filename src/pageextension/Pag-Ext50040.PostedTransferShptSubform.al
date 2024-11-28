pageextension 50040 "Posted Transfer Shpt Subform" extends "Posted Transfer Shpt. Subform"
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
