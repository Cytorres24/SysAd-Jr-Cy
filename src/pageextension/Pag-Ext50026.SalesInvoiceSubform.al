pageextension 50026 "Sales Invoice Subform" extends "Sales Invoice Subform"
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
                    rec."Sub Description" := GetsubRecord(Rec."No.", Rec."Sub Location code");
                    REC."Sub Description 2" := Getsubrecordbrand(Rec."No.", rec."Sub Location code");
                    // end;
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
    actions
    {
        addbefore("F&unctions")
        {
            action("GetGLEntries")
            {
                ApplicationArea = All;
                Caption = 'Get G/L Entries';
                Ellipsis = true;
                Image = GeneralLedger;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    GLEntry: Record "G/L Entry";
                    SelectGlEntries: Page "Select Gen. Ledg. Entries PDI";
                begin
                    GLEntry.Reset();
                    GLEntry.SetRange("Gen. Posting Type", GLEntry."Gen. Posting Type"::Sale);
                    Clear(SelectGlEntries);
                    SelectGlEntries.LookupMode(true);
                    SelectGlEntries.SetTableView(GLEntry);
                    if SelectGlEntries.RunModal() = Action::LookupOK then begin
                        SelectGlEntries.GetSelectionFilter(GLEntry);
                        if Confirm('Are you sure you want to insert the selected line(s)?', true) then
                            if GLEntry.FindSet() then
                                repeat
                                    SalesLine.Init();
                                    SalesLine.Validate("Document Type", Rec."Document Type");
                                    SalesLine.Validate("Document No.", Rec."Document No.");
                                    SetNewLineNo(SalesLine);
                                    SalesLine.Validate(Type, SalesLine.Type::"G/L Account");
                                    SalesLine.Validate("No.", GLEntry."G/L Account No.");
                                    SalesLine.Validate(Quantity, 1);
                                    SalesLine.Validate("Unit Price", (GLEntry.Amount * -1));
                                    SalesLine.Insert();
                                until GLEntry.Next() = 0;
                    end;
                end;
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

    local procedure SetNewLineNo(var NewSalesLine: Record "Sales Line")
    var
        FindSalesLine: Record "Sales Line";
    begin
        FindSalesLine.SetRange("Document Type", NewSalesLine."Document Type");
        FindSalesLine.SetRange("Document No.", NewSalesLine."Document No.");
        if FindSalesLine.FindLast() then
            NewSalesLine."Line No." := FindSalesLine."Line No." + 10000
        else
            NewSalesLine."Line No." := 10000;
    end;

}
