tableextension 50000 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Staff ID"; Code[20])
        {
            Caption = 'Staff ID';
            DataClassification = CustomerContent;
            

            trigger OnValidate()
            var
            StaffValidation: Codeunit "PDS General Utility";
            begin
                StaffValidation.ValidationStaff("Staff ID");
            end;

        }
        field(50001; "Staff Name"; Text[100])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
        field(50002; "Receiver Staff ID"; Code[20])
        {
            Caption = 'Receiver Staff ID';
            DataClassification = CustomerContent;
            
             trigger OnValidate()
            var
            StaffValidation: Codeunit "PDS General Utility";
            begin
                StaffValidation.ValidationStaff("Receiver Staff ID");
            end;
        }
        field(50003; "Receiver Name"; Text[100])
        {
            Caption = 'Receiver Name';
            DataClassification = CustomerContent;
        }
        field(50004; "Processor Staff ID"; Code[20])
        {
            Caption = 'Processor Staff ID';
            DataClassification = CustomerContent;
            
             trigger OnValidate()
            var
            StaffValidation: Codeunit "PDS General Utility";
            begin
                StaffValidation.ValidationStaff("Processor Staff ID");
            end;
            
        }
        field(50005; "Processor Name"; Text[100])
        {
            Caption = 'Processor Name';
            DataClassification = CustomerContent;
        }
        field(50006;Remarks; Text[2048])
        {

        }
    }
}