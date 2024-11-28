pageextension 50003 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Status)
        {
            field(Staff_ID; Rec."Staff ID")
            {
                Caption = 'Requestor Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable = false;

                trigger OnValidate()
                begin
                    rec."Staff Name" := getstaffname(rec."Staff ID");
                end;

            }
            field(Staff_Name; Rec."Staff Name")
            {
                Caption = 'Requestor Staff Name';
                ApplicationArea = all;
                Editable = false;
            }

            field("Processor Staff ID"; Rec."Processor Staff ID")
            {
                Caption = 'Processor Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;
                Editable =  REC."Staff ID" = '';
                

                trigger OnValidate()
                begin
                    rec."processor name" := getstaffname(rec."Processor Staff ID");
                end;

            }
            field("Processor Name"; Rec."Processor Name")
            {
                Caption = 'Processor Staff Name';
                ApplicationArea = all;
                Editable = false;
            }
            field("Receiver Staff ID"; Rec."Receiver Staff ID")
            {
                Caption = 'Receiver Staff ID';
                ApplicationArea = all;
                ShowMandatory = true;
                // Editable = Rec.Status = Rec.Status::Released;
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
            // field("Accounting Staff ID"; Rec."Accounting Staff ID")
            // {
            //     Caption = 'Accounting Staff ID';
            //     ApplicationArea = all;
            //     ShowMandatory = true;
            //     trigger OnValidate()
            //     begin
            //         rec."Receiver Name" := getstaffname(rec."Receiver Staff ID");
            //     end;
            // }
            // field("Accounting Name"; Rec."Accounting Name")
            // {
            //     Caption = 'Accounting Name';
            //     ApplicationArea = all;
            //     Editable = false;
            // }

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