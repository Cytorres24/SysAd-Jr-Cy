pageextension 50017 "Posted Purch. Cr. Memo" extends "Posted Purchase Credit Memo"
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