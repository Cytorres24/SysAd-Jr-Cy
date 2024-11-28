pageextension 50001 "Purchase Quote" extends "Purchase Quote"
{
    layout
    {
        
        addafter(Status)
        {
            field(Staff_ID; Rec."Staff ID")
            {
                Caption = 'Requestor ID';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = rec.Status <> Rec.Status::Released;
                

                trigger OnValidate()
                begin
                    rec."Staff Name" := getstaffname(rec."Staff ID");
                end;

            }
            field(Staff_Name; Rec."Staff Name")
            {
                Caption = 'Requestor Name';
                ApplicationArea = all;
                Editable = false;
            }

            field("Processor Staff ID"; Rec."Processor Staff ID")
            {
                Caption = 'Processor Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.status = Rec.Status::Released;

                trigger OnValidate()
                begin
                    rec."Processor Name" := getstaffname(rec."Processor Staff ID");
                end;

            }
            field("Processor Name"; Rec."Processor Name")
            {
                Caption = 'Processor Name';
                ApplicationArea = all;
                Editable = false;
            }
        
        }
        
    }

    actions
    {

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


