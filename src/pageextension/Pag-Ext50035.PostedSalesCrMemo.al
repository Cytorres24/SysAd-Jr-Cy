pageextension 50035 "Posted Sales Cr. Memo" extends "Posted Sales Credit Memo"
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
