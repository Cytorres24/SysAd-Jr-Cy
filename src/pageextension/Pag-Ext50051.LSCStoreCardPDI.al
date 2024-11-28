pageextension 50051 "LSC Store Card PDI" extends "LSC Store Card"
{
    layout
    {
        addbefore(Address)
        {
            field("Customer Account TenderType"; Rec."Customer Account TenderType")
            {
                ApplicationArea = All;
                Style = StrongAccent;
            }
        }
    }
}
