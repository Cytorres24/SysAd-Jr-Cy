pageextension 50031 "Posted Sales Return Receipt" extends "Posted Return Receipt"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Staff Name";Rec."Staff Name")
            {
                Caption = 'Staff Name';
                ApplicationArea = all;
                ShowMandatory = true;
                editable = false;
            }
        }
    }
}