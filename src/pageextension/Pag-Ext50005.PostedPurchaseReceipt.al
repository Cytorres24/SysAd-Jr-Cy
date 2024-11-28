pageextension 50005 "Posted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Receiver Name"; Rec."Receiver Name")
            {
                Caption = 'Receiver Name';
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
    }
}
