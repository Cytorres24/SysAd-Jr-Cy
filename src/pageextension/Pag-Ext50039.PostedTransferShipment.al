pageextension 50039 "Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Staff Name"; Rec."Staff Name")
            {
                Caption = 'Staff Name';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = false;
            }
        }
    }
}
