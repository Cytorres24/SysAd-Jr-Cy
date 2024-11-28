tableextension 50026 RetailSetupTableExt extends "LSC Retail Setup"
{
    fields
    {
        field(50000; "Doctor's Number Series"; Code[20])
        {
            Caption = 'Doctor''s Number Series';
            DataClassification = CustomerContent;
        }
         field(50001; "Enable Auto Tender Deduction"; Boolean )
    {
        caption = 'Enable Auto Tender Deduction';
        DataClassification = CustomerContent;
        
    }
    }
}
