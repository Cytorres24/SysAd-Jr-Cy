pageextension 50013 "Posted Purch. Return Shipment" extends "Posted Return Shipment"
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
