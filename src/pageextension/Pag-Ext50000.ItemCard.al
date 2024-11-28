// namespace SubcodeApp.SubcodeApp;

// using Microsoft.Inventory.Item;

pageextension 50000 "Item Card" extends "Item Card"
{
    layout
    {

    }
    actions
    {
        addafter(Approval)
        {
            action(PlanetSubcoding)
            {
                Image = View;
                RunObject = page "Planet Item Subcode";
                RunPageLink = "Item Code" = field("No.");
                ApplicationArea = All;

                trigger OnAction()
                var
                    PDSGENUTILS: Codeunit "PDS General Utility";
                    ItemNo: Text;
                    UOM: Text;
                begin
                    PDSGENUTILS.SubcodingFilter(ItemNo, UOM);
                end;
            }
        }


    }

}
