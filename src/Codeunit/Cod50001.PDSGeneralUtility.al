codeunit 50001 "PDS General Utility"
{

    //Sales Shipment Header / Restrictions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; WhseShip: Boolean; InvtPickPutaway: Boolean)
    begin
        SalesShptHeader."Staff Name" := SalesHeader."Staff Name";
        SalesShptHeader."Staff ID" := SalesHeader."Staff ID";

        if SalesHeader."Staff ID" = '' then
            Error('Staff ID is Required');
    end;
    //Purchase Receipt Header / Restrictions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        PurchRcptHeader."Receiver Name" := PurchaseHeader."Receiver Name";
        PurchRcptHeader."Receiver Staff ID" := PurchaseHeader."Receiver Staff ID";

        if PurchaseHeader."Processor Staff ID" = '' then
            Error('Processor Staff ID is required');

        if PurchaseHeader."Receiver Staff ID" = '' then
            Error('Receiver Staff ID is required');

        IF PurchaseHeader."Vendor Invoice No." = '' then
            ERROR('Vendor Invoice No. is required');
    end;
    //Transfer Shipment Header / Restrictions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptHeader', '', false, false)]
    local procedure OnBeforeInsertTransShptHeader(var TransShptHeader: Record "Transfer Shipment Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean)
    begin
        TransShptHeader."Staff Name" := TransHeader."Staff Name";
        TransShptHeader."Staff ID" := TransHeader."Staff ID";

        if TransHeader."Staff ID" = '' then
            Error('Staff ID is required');
    end;
    //Transfer Receipt Header / Restrictions
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptHeader', '', false, false)]
    local procedure OnBeforeInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; TransHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var Handled: Boolean)
    begin
        TransRcptHeader."Receiver Name" := TransHeader."Receiver Name";
        TransRcptHeader."Receiver Staff ID" := TransHeader."Receiver Staff ID";

        if TransHeader."Receiver Staff ID" = '' then
            Error('Receiver Staff ID is required');
    end;

    //Posted Purchase Invoice / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        PurchInvHeader."Staff Name" := PurchHeader."Staff Name";
        PurchInvHeader."Staff ID" := PurchHeader."Staff ID";

        // if PurchHeader."Staff ID" = '' then
        //     Error('Staff ID is Required');
    end;

    //Posted Sales Invoice / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', false, false)]
    local procedure OnBeforeSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; WhseShip: Boolean; WhseShptHeader: Record "Warehouse Shipment Header"; InvtPickPutaway: Boolean)
    begin
        SalesInvHeader."Staff Name" := SalesHeader."Staff Name";
        SalesInvHeader."Staff ID" := SalesHeader."Staff ID";

        if SalesHeader."Staff ID" = '' then
            Error('Staff ID is required');
    end;

    //Sales Return Receipt / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnRcptHeaderInsert(var ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var TempWhseRcptHeader: Record "Warehouse Receipt Header" temporary; WhseReceive: Boolean; var TempWhseShptHeader: Record "Warehouse Shipment Header" temporary; WhseShip: Boolean)
    begin
        ReturnRcptHeader."Staff Name" := SalesHeader."Staff Name";
        ReturnRcptHeader."Staff ID" := SalesHeader."Staff ID";

        if SalesHeader."Staff ID" = '' then
            Error('Staff ID is required');
    end;

    //Purchase Return Shipment / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptHeaderInsert', '', false, false)]
    local procedure OnBeforeReturnShptHeaderInsert(var ReturnShptHeader: Record "Return Shipment Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        ReturnShptHeader."Staff Name" := PurchHeader."Staff Name";
        ReturnShptHeader."Staff ID" := PurchHeader."Staff ID";

        if PurchHeader."Staff ID" = '' then
            Error('Staff ID is required');

    end;

    //Purch. Quote / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
        PurchOrderHeader."Staff ID" := PurchQuoteHeader."Staff ID";
        PurchOrderHeader."Staff Name" := PurchQuoteHeader."Staff Name";
        PurchOrderHeader."Processor Staff ID" := PurchQuoteHeader."Processor Staff ID";
        PurchOrderHeader."Processor Name" := PurchQuoteHeader."Processor Name";

        IF PurchQuoteHeader."Staff Name" = '' then
            ERROR('Requestor Staff ID is required');

        if PurchQuoteHeader."Processor Staff ID" = '' then
            ERROR('Processor Staff ID is required and Status should be Released');
    end;

    // Sales Quote -> Sales Order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Staff Name" := SalesQuoteHeader."Staff Name";
        SalesOrderHeader."Staff ID" := SalesQuoteHeader."Staff ID";

        if SalesQuoteHeader."Staff ID" = '' then
            Error('Staff ID is Required');
    end;

    //Release / Restriction
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforePerformManualRelease', '', false, false)]
    local procedure OnBeforePerformManualRelease(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        if PurchaseHeader."Staff ID" = '' then
            error('Requestor Staff ID is required');
    end;

    //Item Journal -> Item Ledger
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnItemQtyPostingOnBeforeApplyItemLedgEntry', '', false, false)]
    local procedure OnItemQtyPostingOnBeforeApplyItemLedgEntry(var ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Staff ID" := ItemJournalLine."Staff ID";
    end;
    //Sales Shipment -> Item Ledger
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostItemJnlLineOnBeforeCopyTrackingFromSpec', '', false, false)]
    local procedure OnPostItemJnlLineOnBeforeCopyTrackingFromSpec(TrackingSpecification: Record "Tracking Specification"; var ItemJnlLine: Record "Item Journal Line"; SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; IsATO: Boolean)
    begin
        ItemJnlLine."Staff ID" := SalesHeader."Staff ID";
    end;
    //Purchase Receipt -> Item Ledger
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemJnlLineOnBeforeCopyDocumentFields', '', false, false)]
    local procedure OnPostItemJnlLineOnBeforeCopyDocumentFields(var ItemJournalLine: Record "Item Journal Line"; PurchaseHeader: Record "Purchase Header"; PurchaseLine: Record "Purchase Line"; WhseReceive: Boolean; WhseShip: Boolean; InvtPickPutaway: Boolean)
    begin
        ItemJournalLine."Staff ID" := PurchaseHeader."Receiver Staff ID";
    end;
    //Transfer Shipment -> Item Ledger
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]
    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Staff ID" := TransferShipmentHeader."Staff ID";
    end;

    // Additional of Dispense Date
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeStartNewTransaction', '', false, false)]
    internal procedure OnBeforeStartNewTransaction(var POSTransaction: Record "LSC POS Transaction")
    var
        terminal: Record "LSC POS Terminal";
    begin
        IF POSTransaction."Dispense Date" = 0D then
            POSTransaction."Dispense Date" := Today;
        if terminal.Get(POSTransaction."Created on POS Terminal") then begin
            if terminal.EnableLockedDate = true then
                POSTransaction."Dispense Date" := terminal.LockedDate
            else
                POSTransaction."Dispense Date" := Today;
        end;

        if terminal.GET(POSTransaction."POS Terminal No.") then begin
            // Set the PharmacistDuty from the terminal record if it's not already set
            if POSTransaction.PharmacistDuty = '' then
                POSTransaction.PharmacistDuty := terminal.PharmacistDuty;
        end;
    end;

    // POSTRANS. LINE -> DISPENSE DATE
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterInsertItemLine', '', false, false)]
    internal procedure OnAfterInsertItemLine(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line"; var CurrInput: Text)
    begin
        if POSTransLine."Dispense Date" = 0D then
            POSTransLine."Dispense Date" := POSTransaction."Dispense Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterLogoff', '', false, false)]
    internal procedure OnAfterLogoff(var POSTransaction: Record "LSC POS Transaction"; var SalesType: Record "LSC Sales Type"; var closePos: Boolean)
    var
        terminal: Record "LSC POS Terminal";
        PosSession: Codeunit "LSC POS Session";
    begin
        terminal.Get(PosSession.TerminalNo);
        terminal.LockedDate := 0D;
        TERMINAL.Modify;
    end;










    //Global Procedure
    procedure ValidationStaff(StaffID: Code[20])
    var
        STAFF: Record "LSC Staff";
    begin
        if StaffID = '' then begin
            exit;
        end;


        IF NOT STAFF.GET(StaffID) THEN begin
            ERROR('Staff ID not found in staff list');
        end;
    end;

    procedure SubcodingFilter(ItemNo: code[20]; UnitofMeasure: code[10])
    var
        Item: Record Item;
    begin
        Item.SetFilter("No.", ItemNo);
        // Item.Get(Item."Base Unit of Measure", UnitofMeasure);

    end;

    // procedure Getlockeddispensedate(): Date
    // var
    //     terminal: Record "LSC POS Terminal";
    //     PosTransaction: Record "LSC POS Transaction";
    // begin
    //     if terminal.Get(POSTransaction."Created on POS Terminal") and (terminal.EnableLockedDate = true) then
    //         exit(terminal.LockedDate);
    // end;

}


