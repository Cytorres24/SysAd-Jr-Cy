pageextension 50002 "Purchase Quote Subform" extends "Purchase Quote Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field("Sub Location"; Rec."Sub Location code")
            {
                ApplicationArea = all;
                trigger OnValidate()

                begin
                    // if Rec."Line No." = 10000 then begin
                    //     rec."Sub Description" := GetsubRecord(REC."Item No.", Rec."Sub Location");
                    //     REC."Sub Description 2" := Getsubrecordbrand(REC."Item No.", rec."Sub Location");
                    // END;
                    rec."Sub Description" := GetsubRecord(rec."No.", Rec."Sub Location code");
                    Rec."Sub Description 2" := Getsubrecordbrand(rec."No.", rec."Sub Location code");


                end;
            }
        }
        addafter("Sub Location")
        {
            field("Sub Description"; Rec."Sub Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Sub Description")
        {
            field("Sub Description 2"; Rec."Sub Description 2")
            {
                ApplicationArea = all;
                caption = 'Sub Brand';
                Editable = false;
            }
        }
    }

    local procedure GetsubRecord(ItemCode: Code[20]; LocationCode: Code[20]): text[30]
    var
        PDSSUBCODE: Record "Planet Subcode";
    begin
        if PDSSUBCODE.get(ItemCode, LocationCode) then begin
            exit(PDSSUBCODE."Sub Description");
        end;
    end;

    local procedure Getsubrecordbrand(ItemCode: Code[20]; LocationCode: Code[20]): text[30]
    var
        PDSSUBCODE: Record "Planet Subcode";
    begin
        if PDSSUBCODE.get(ItemCode, LocationCode) then begin
            exit(PDSSUBCODE."Sub Description 2");
        end;
    end;
    
}

