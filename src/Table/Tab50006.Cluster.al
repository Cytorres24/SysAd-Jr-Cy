table 50006 Cluster
{
    Caption = 'Cluster';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(3; "Store No."; Code[20])
        {
            Caption = 'Store No.';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
