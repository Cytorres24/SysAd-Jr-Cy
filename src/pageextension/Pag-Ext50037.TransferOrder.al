pageextension 50037 "Transfer Order" extends "Transfer Order"
{
    layout
    {
        addafter(Status)
        {
            field(Staff_ID; Rec."Staff ID")
            {
                Caption = 'Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;

                trigger OnValidate()
                begin
                    rec."Staff Name" := getstaffname(rec."Staff ID");
                end;

            }
            field(Staff_Name; Rec."Staff Name")
            {
                Caption = 'Staff Name';
                ApplicationArea = all;
                Editable = false;
            }

            field("Receiver Staff ID"; Rec."Receiver Staff ID")
            {
                Caption = 'Receiver Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = Rec.Status = rec.Status::Released;
                trigger OnValidate()
                begin
                    rec."Receiver Name" := getstaffname(rec."Receiver Staff ID");
                end;
            }
            field("Receiver Name"; Rec."Receiver Name")
            {
                Caption = 'Receiver Name';
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
