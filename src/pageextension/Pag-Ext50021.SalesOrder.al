pageextension 50021 "Sales Order" extends "Sales Order"
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
        }
    }
    actions

    {

        addafter("&Print")
        {
            action(Delivery_Receipt)
            {
                Image = Print;
                ApplicationArea = ALL;
                Caption = 'Print Delivery Receipt';
                trigger OnAction()
                var
                    Salesline: Record "Sales Line";
                    DR: Report "Delivery Receipt";
                begin
                    clear(Salesline);
                    Salesline.SetFilter("No.", Rec."No.");
                    // Salesline.FindSet();

                    DR.SetTableView(Salesline);
                    DR.Run();
                end;
            }
            action(Delivery_Receipt2)
            {
                Image = Print;
                ApplicationArea = ALL;
                Caption = 'Print QC - Delivery Receipt';
                trigger OnAction()
                var
                    Salesline: Record "Sales Line";
                    DR: Report "Delivery Receipt Qc";
                begin
                    clear(Salesline);
                    Salesline.SetFilter("No.", Rec."No.");
                    // Salesline.FindSet();

                    DR.SetTableView(Salesline);
                    DR.Run();
                end;
            }
            action(Printsalesorder)
            {
                Image = Print;
                ApplicationArea = ALL;
                Caption = 'Print PDS Sales Order';
                trigger OnAction()
                var
                    Salesline: Record "Sales Line";
                    SO: Report "PDS Sales Order";
                begin
                    clear(Salesline);
                    Salesline.SetFilter("No.", Rec."No.");
                    // Salesline.FindSet();

                    SO.SetTableView(Salesline);
                    SO.Run();
                end;
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
