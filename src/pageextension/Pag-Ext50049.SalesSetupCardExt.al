pageextension 50049 SalesSetupCardExt extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Direct Debit Mandate Nos.")
        {
            field("Mch Customers Nos."; Rec."Mch Customers Nos.")
            {
                Caption = 'Planet Customers Nos.';
                ApplicationArea = all;
                TableRelation = "No. Series";
            }
        }
    }
}


