tableextension 50062 "LSC Store PDI" extends "LSC Store"
{
    fields
    {
        field(50010; "Customer Account TenderType"; Code[10])
        {
            Caption = 'Cust. Acc. Tender Type';
            DataClassification = CustomerContent;
            TableRelation = "LSC Tender Type Setup".Code;
        }
    }
}
