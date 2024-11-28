pageextension 50025 "Sales Invoice" extends "Sales Invoice"
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
            field(Comment; Rec.Comment)
            {
                ApplicationArea = ALL;
            }

        }
    }
    actions
    {
        addbefore(Release)
        {
            action(SalesInvoice)
            {
                Image = Print;
                ApplicationArea = ALL;
                Caption = 'Print Special-Project Sales Invoice';
                trigger OnAction()
                var
                    Salesheader: Record "Sales Header";
                    DR: Report SPSalesinvoice;
                    salesline: Record "Sales Line";
                begin
                    clear(salesline);
                   Salesheader.SetFilter("No.",salesline."Document No.");
                    // Salesheader.SetFilter("No.",salesline."Document No.");
                    // Salesline.FindSet();

                    DR.SetTableView(salesline);
                    DR.Run();
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
