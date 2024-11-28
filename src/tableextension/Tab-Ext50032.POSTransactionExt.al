tableextension 50032 POSTransactionExt extends "LSC POS Transaction"
{
    fields
    {
        field(50000; "Dispense Date"; Date)
        {
            Caption = 'Dispense Date';
            DataClassification = CustomerContent;
        }
        field(50001; DoctorsNo; code[20])
        {
            Caption = 'Doctors No.';
            DataClassification = CustomerContent;
        }
        field(50002; PharmacistDuty; Code[20])
        {
            Caption = 'Pharmacist on duty';
            DataClassification = CustomerContent;
        }
        field(50003; MCHDOCID; Code[20])
        {
            CAPTION = 'MCH Doc No.';      
        }
        field(50004; MCHDOCNAME; Text[100])
        {
            Caption = 'MCH Doctor Name';
        }
        field(50005; MCHDOCLICENSE; Code[20])
        {
            caption = 'MCH Doctor License No.';
        }
        field(50006; MedicalType; text[30])
        {
            Caption = 'Medical Type';
        }
         field(50010; "Patient No."; Code[20])
        {
            Caption = 'Patient No.';
            DataClassification = CustomerContent;
        }
        field(50011; "Patient Name"; Text[50])
        {
            Caption = 'Patient Name';
            DataClassification = CustomerContent;
        }
        field(50012; "Patient Department"; Text[250])
        {
            Caption = 'Patient Department';
            DataClassification = CustomerContent;
        }
        field(50013; "Batch Posting"; Boolean)
        {
            Caption = 'Batch Posting';
            DataClassification = CustomerContent;
        }
        field(50021; "Ackn. Receipt No."; Code[20])
        {
            Caption = 'Ackn. Receipt No.';
            DataClassification = CustomerContent;
        }

        
    }
    // trigger OnInsert():
    // begin
    //     if "Dispense Date" = 0D then
    //     EXIT("Trans. Date");
    // end;
}
