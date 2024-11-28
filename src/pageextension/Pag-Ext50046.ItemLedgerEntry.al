pageextension 50046 ItemLedgerEntry extends "Item Ledger Entries"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Staff ID";Rec."Staff ID")
            {
                ApplicationArea = all;
            }
        }
    }
}
