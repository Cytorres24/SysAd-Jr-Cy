table 50001 "Doctors List"
{
    Caption = 'Doctors List';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
           
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "License No."; Code[20])
        {
            Caption = 'License No.';
        }
        field(4; "Store No."; Code[20])
        {
            Caption = 'Store No.';
        }
        field(5; "Medical Type"; Option)
        {
            Caption = 'Medical Type';
            OptionMembers = ,Medical,Dental;
        }

        field(6; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        LRetailSetup: Record "LSC Retail Setup";
        CDUNoSeriesMGT: Codeunit NoSeriesManagement;
    BEGIN
        LRetailSetup.GET();
        IF "No." <> xRec."No." THEN
            "No." := CDUNoSeriesMGT.GetNextNo(LRetailSetup."Doctor's Number Series", TODAY, true);

        IF "No. Series" = '' then
            "No. Series" := 'R-DOC';
    END;
}
