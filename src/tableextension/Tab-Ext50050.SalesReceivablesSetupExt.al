tableextension 50050 "Sales & Receivables Setup Ext." extends "Sales & Receivables Setup"
{
    fields
    {
        field(50004; "Mch Customers Nos."; Text[50])
        {
            Caption = 'Mch Customers Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

    }
}
