page 50031 "Select Gen. Ledg. Entries PDI"
{
    Caption = 'Select Gen. Ledg. Entries';
    DataCaptionExpression = GetCaption();
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = m;
    SourceTable = "G/L Entry";
    SourceTableView = sorting("G/L Account No.", "Posting Date")
                      order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the document type that the entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the entry''s Document No.';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the account that the entry has been posted to.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the type of transaction.';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate ledger account according to the general posting setup.';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate ledger account according to the general posting setup.';
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                    ToolTip = 'Specifies the Amount of the entry.';
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    Editable = false;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                }
                field("VAT Reporting Date"; Rec."VAT Reporting Date")
                {
                    Editable = false;
                    ToolTip = 'Specifies the VAT date on the VAT entry. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ToolTip = 'Specifies the entry''s external document number, such as a vendor''s invoice number.';
                }
            }
        }
    }

    local procedure GetCaption(): Text
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.SetLoadFields("No.", Name);
        if GLAcc."No." <> Rec."G/L Account No." then
            if not GLAcc.Get(Rec."G/L Account No.") then
                if Rec.GetFilter("G/L Account No.") <> '' then
                    if GLAcc.Get(Rec.GetRangeMin("G/L Account No.")) then;
        exit(StrSubstNo('%1 %2', GLAcc."No.", GLAcc.Name))
    end;

    procedure GetSelectionFilter(var GlEntry: Record "G/L Entry")
    begin
        CurrPage.SetSelectionFilter(GLEntry);
    end;
}
