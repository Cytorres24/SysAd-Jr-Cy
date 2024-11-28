pageextension 50041 "Posted Transfer Receipt" extends "Posted Transfer Receipt"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Receiver Name"; Rec."Receiver Name")
            {
                Caption = 'Receiver Name';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = false;
            }
        }
    }
}