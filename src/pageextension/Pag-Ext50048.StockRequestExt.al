pageextension 50048 StockRequestExt extends "LSC Stock Request"
{
    layout
    {
        addafter("Reference No.")
        {
            field("Staff ID"; Rec."Staff ID")
            {
                ApplicationArea = all;
                 trigger OnValidate()
                begin
                    rec."Staff Name" := getstaffname(rec."Staff ID");
                end;
            }
            field("Staff Name"; Rec."Staff Name")
            {
                ApplicationArea = all;
                Editable = false;
                
            }
        }
    }
     local procedure getstaffname(ID: Code[20]): Text[100]
    var
        STAFF: Record "LSC Staff";
        WNAME: TEXT[100];
    begin

        IF STAFF.Get(ID) then
            // exit(STAFF."First Name");
            // exit(StrSubstNo('%1 %2', STAFF."First Name", STAFF."Last Name"));
            exit(STAFF."First Name" + ' ' + STAFF."Last Name");

    end;
}
