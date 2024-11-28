page 50030 "Transaction Batch Posting PDI"
{
    ApplicationArea = All;
    Caption = 'Transaction Batch Posting';
    PageType = List;
    SourceTable = "LSC POS Transaction";
    SourceTableView = sorting("Receipt No.") order(ascending)
                        where("Transaction Type" = const(Sales), "Entry Status" = const(Suspended));
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;
    ShowFilter = true;

    layout
    {
        area(Content)
        {
            group("Posting Parameters")
            {
                field("POS Terminal"; POSTerminal)
                {
                    ApplicationArea = All;
                    TableRelation = "LSC POS Terminal";
                    trigger OnValidate()
                    begin
                        Rec.SetRange("Created on POS Terminal");
                        if POSTerminal <> '' then
                            Rec.SetRange("Created on POS Terminal", POSTerminal);
                        CurrPage.Update();
                    end;
                }
                field("Staff"; StaffID)
                {
                    ApplicationArea = All;
                    TableRelation = "LSC Staff".ID;
                    trigger OnValidate()
                    begin
                        Rec.SetRange("Staff ID");
                        if StaffID <> '' then
                            rec.SetRange("Staff ID", StaffID);
                        CurrPage.Update();
                    end;
                }
            }
            group(Transactions)
            {
                repeater(Group)
                {
                    field("Staff ID"; Rec."Staff ID")
                    { ApplicationArea = All; Editable = false; }
                    field("Sales Staff"; Rec."Sales Staff")
                    {
                        ApplicationArea = All;
                        Caption = 'Pharmacist On Duty';
                        Editable = false;
                    }
                    field("Created on POS Terminal"; Rec."Created on POS Terminal")
                    { ApplicationArea = All; Editable = false; }

                    field("Batch Posting"; Rec."Batch Posting")
                    { ApplicationArea = All; }
                    field("Dispense Date"; Rec."Dispense Date")
                    { ApplicationArea = All; Editable = false; }
                    field("Ackn. Receipt No."; Rec."Ackn. Receipt No.")
                    { ApplicationArea = All; Editable = false; }
                    field("Trans. Type"; GetTransType(Rec."Receipt No.", Rec."Created on POS Terminal"))
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Patient No."; Rec."Patient No.")
                    { ApplicationArea = All; Editable = false; }
                    field("Patient Name"; Rec."Patient Name")
                    { ApplicationArea = All; Editable = false; }
                    field("Gross Amount"; Rec."Gross Amount")
                    { ApplicationArea = All; Editable = false; }
                    field("Sale Is Return Sale"; Rec."Sale Is Return Sale")
                    {
                        ApplicationArea = All;
                        Caption = 'Return';
                        Editable = false;
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Select All")
            {
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.ModifyAll("Batch Posting", true);
                end;
            }
            action("Unselect All")
            {
                Image = Undo;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                trigger OnAction()
                begin
                    Rec.ModifyAll("Batch Posting", false);
                end;
            }
            action("Batch Post")
            {
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    BatchPost();
                end;
            }
        }
    }

    local procedure GetTransType(ReceiptNo: Code[20]; TerminalNo: Code[20]): Text[100]
    var
        POSTransInfoEntry: Record "LSC POS Trans. Infocode Entry";
        POSTerminal: Record "LSC POS Terminal";
        InfoSubcode: Record "LSC Information Subcode";
    begin
        if POSTerminal.GET(TerminalNo) then;

        POSTransInfoEntry.SetCurrentKey("Receipt No.", Infocode, "Transaction Type", "Line No.");
        POSTransInfoEntry.SetRange("Receipt No.", ReceiptNo);
        POSTransInfoEntry.SetRange("Transaction Type", POSTransInfoEntry."Transaction Type"::Header);
        POSTransInfoEntry.SetRange(Infocode, POSTerminal."Type Of Trans Infocode");
        if POSTransInfoEntry.FindFirst() then
            if InfoSubcode.Get(POSTransInfoEntry.Infocode, POSTransInfoEntry.Subcode) THEN
                exit(InfoSubcode.Description);
        exit('');
    end;

    local procedure PostTransaction(ReceiptNo: Code[20])
    var
        POSTransaction: Record "LSC POS Transaction";
        SuspTransLine: Record "LSC POS Trans. Line";
        RetailCalendar: Record "LSC Retail Calendar";
        TenderType: Record "LSC Tender Type";
        NewLine: Record "LSC POS Trans. Line";
        RetailCalendarMngt: Codeunit "LSC Retail Calendar Management";
        POSPostUtil: Codeunit "LSC POS Post Utility";
        Balance: Decimal;
        PaymentAmount: Decimal;
        RealBalance: Decimal;
        ModifyOk: Boolean;
    begin
        POSTransaction.Get(ReceiptNo);
        POSTransaction."Trans. Date" := WorkDate();
        POSTransaction."Trans Time" := Time;
        POSTransaction."Entry Status" := POSTransaction."Entry Status"::" ";
        POSTransaction."Trans. Date" := RetailCalendarMngt.GetStoreTransactionDate(POSTransaction."Store No.",
                                            RetailCalendar."Calendar Type"::"Opening Hours", POSTransaction."Trans. Date",
                                            POSTransaction."Trans Time");
        POSTransaction."POS Terminal No." := POSTerminal;
        POSTransaction."Staff ID" := StaffID;
        POSTransaction.Modify();

        SuspTransLine.Reset();
        SuspTransLine.SetRange("Receipt No.", POSTransaction."Receipt No.");
        if SuspTransLine.FindSet() then begin
            repeat
                ModifyOk := FALSE;
                if (SuspTransLine."Store No." <> POSTransaction."Store No.") then begin
                    SuspTransLine."Store No." := POSTransaction."Store No.";
                    ModifyOk := TRUE;
                end;
                if (SuspTransLine."POS Terminal No." <> POSTransaction."Created on POS Terminal") then begin
                    SuspTransLine."POS Terminal No." := POSTransaction."Created on POS Terminal";
                    ModifyOk := TRUE;
                end;
                if ModifyOk then
                    SuspTransLine.Modify();
            until SuspTransLine.Next() = 0;
        end;

        //Insert Payment
        if Store.Get(POSTransaction."Store No.") then;
        Store.TestField("Customer Account TenderType");
        TenderType.Get(POSTransaction."Store No.", Store."Customer Account TenderType");    //Function=Customer; Description=Customer Account
        POSTransaction.Get(ReceiptNo);
        POSTransaction.CalcFields("Gross Amount", "Line Discount", Payment, "Net Amount", "Total Discount", "Income/Exp. Amount", Prepayment);
        Balance := (POSTransaction."Gross Amount" + POSTransaction."Income/Exp. Amount" - POSTransaction.Payment);
        PaymentAmount := Balance;
        if POSTransaction."Sale Is Return Sale" then
            RealBalance := -Balance
        else
            RealBalance := Balance;

        if TenderType."Rounding To" <> 0 then
            IF PaymentAmount MOD TenderType."Rounding To" <> 0 then
                Error(StrSubstNo(LowestAccptDenoErr, TenderType."Rounding To"));
        if Balance < 0 then
            PaymentAmount := -PaymentAmount;
        if POSTransaction."Customer No." = '' then
            Error(StrSubstNo(CustRequiredErr, POSTransaction."Ackn. Receipt No."));

        Clear(NewLine);
        NewLine."Store No." := POSTransaction."Store No.";
        NewLine."POS Terminal No." := POSTransaction."POS Terminal No.";
        NewLine."Receipt No." := ReceiptNo;
        NewLine."Entry Type" := NewLine."Entry Type"::Payment;
        NewLine.Quantity := 1;
        NewLine.Number := TenderType.Code;
        NewLine.Amount := PaymentAmount;
        NewLine."Amount In Currency" := PaymentAmount;
        NewLine.Description := TenderType.Description;
        NewLine."Card/Customer/Coup.Item No" := POSTransaction."Customer No.";
        NewLine."Created by Staff ID" := POSTransaction."Staff ID";
        NewLine.InsertLine();
        POSPostUtil.ProcessTransaction(POSTransaction);
    end;

    local procedure BatchPost()
    var
        POSTrans: Record "LSC POS Transaction";
        TransCount: Integer;
        ctr: Integer;
        dialogProgress: Dialog;
    begin
        Clear(dialogProgress);
        ctr := 0;
        TransCount := 0;

        if POSTerminal = '' then
            Error(RequiredErr, 'POS Terminal No.');
        if StaffID = '' then
            Error(RequiredErr, 'Staff ID');

        POSTrans.SetCurrentKey("Receipt No.");
        POSTrans.SetFilter("Dispense Date", Rec.GetFilter("Dispense Date"));
        POSTrans.SetRange("Batch Posting", true);
        TransCount := POSTrans.Count;
        if TransCount = 0 THEN
            Error('No Transaction selected to post.');

        dialogProgress.OPEN('Trans. Receipt: #1#######################\' +
                       'Processing:     @2@@@@@@@@@@@@@@@@@@@@@@@');

        if POSTrans.FindSet() then
            repeat
                ctr += 1;
                dialogProgress.Update(1, POSTrans."Ackn. Receipt No.");
                PostTransaction(POSTrans."Receipt No.");
                dialogProgress.Update(2, Round(ctr / TransCount) * 10000);
            until POSTrans.Next() = 0;
        dialogProgress.Close();
        Message('%1 Transactions successfully posted.', TransCount);
    end;

    var
        Store: Record "LSC Store";
        POSTerminal: Code[20];
        StaffID: Code[20];
        CustRequiredErr: Label 'Customer is required for %1 Transaction.', Comment = '%1=Ackn. Receipt No.';
        LowestAccptDenoErr: Label 'Lowest accept. denominator is %1', Comment = '%1=Rounding';
        RequiredErr: Label '%1 is required.';
}
