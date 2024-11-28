table 50002 BufferTable
{
    Caption = 'BufferTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Brand; Text[100])
        {
            Caption = 'Brand';
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(5; "Unit of measure"; Code[20])
        {
            Caption = 'Unit of measure';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Description)
        {
            Clustered = true;
        }
    }
}
