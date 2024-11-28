pageextension 50023 "Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Responsibility Center")
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
