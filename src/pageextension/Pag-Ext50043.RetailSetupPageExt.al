pageextension 50043 RetailSetupPageExt extends "LSC Retail Setup"
{
    layout
    {
        addafter("Store No. Nos.")
        {
            field("Doctor's Number Series"; rec."Doctor's Number Series")
            {
                ApplicationArea = all;
                TableRelation = "No. Series";
            }

            
                field("Enable Auto Tender Deduction";Rec."Enable Auto Tender Deduction")
                {
                ApplicationArea = ALL;
                }

           
        }
    }
}