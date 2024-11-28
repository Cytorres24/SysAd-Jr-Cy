pageextension 50027 "Posted Sales Invoice" extends "Posted Sales Invoice"
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