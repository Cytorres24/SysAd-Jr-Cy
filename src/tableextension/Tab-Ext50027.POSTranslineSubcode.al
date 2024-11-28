tableextension 50027 "POS Transline Subcode" extends "LSC POS Trans. Line"
{
    fields
    {
        field(50023; "Sub Description"; Text[100])
        {
            Caption = 'Sub Description';
            DataClassification = CustomerContent;
        }

        field(50024; "Sub Description 2"; Text[100])
        {
            Caption = 'Sub Description 2';
            DataClassification = CustomerContent;
        }
        field(50025; "Dispense Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(50021; "Ackn. Receipt No."; Code[20])
        {
            Caption = 'Ackn. Receipt No.';
            DataClassification = CustomerContent;
        }
        // field(50026; DispenseDate; Date)
        // {

        // }
    }
    //MJ
    trigger OnInsert()
    var
        SubcodeRec: Record "Planet Subcode";
    begin
        // Find the matching Subcode based on Number
        if SubcodeRec.FindFirst() then begin
            repeat
                if SubcodeRec."Item Code" = "Number" then begin
                    "Sub Description" := SubcodeRec."Sub Description";
                    "Sub Description 2" := SubcodeRec."Sub Description 2";
                    "Unit of Measure" := SubcodeRec.UnitofMeasure;
                    exit;
                end;
            until SubcodeRec.Next() = 0; // Loop through all records
        end;
    end;

    trigger OnModify()
    var
        SubcodeRec: Record "Planet Subcode";
    begin
        // Update the Sub Description if the Number changes
        if SubcodeRec.FindFirst() then begin
            repeat
                if SubcodeRec."Item Code" = "Number" then begin // Use the correct field to match
                    "Sub Description" := SubcodeRec."Sub Description";
                    "Sub Description 2" := SubcodeRec."Sub Description 2";
                    "Unit of Measure" := SubcodeRec.UnitofMeasure;
                    exit;
                end;
            until SubcodeRec.Next() = 0; // Loop through all records
        end else begin
            "Sub Description" := ''; // Clear if no match
            "Sub Description 2" := '';
            "Unit of Measure" := '';
        end;
    end;

}
