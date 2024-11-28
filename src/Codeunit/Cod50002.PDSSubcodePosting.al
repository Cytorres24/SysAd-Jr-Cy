// namespace SubcodeApp.SubcodeApp;
// using Microsoft.Sales.Posting;
// using Microsoft.Warehouse.History;
// using Microsoft.Purchases.Document;
// using Microsoft.Sales.Document;
// using Microsoft.Inventory.Transfer;
// using Microsoft.Purchases.History;
// using Microsoft.Purchases.Posting;
// using Microsoft.Sales.History;

codeunit 50002 "PDS Subcode Posting"
{
    //Posted Sales Shipment 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', false, false)]
    local procedure UpdateShipment(var SalesShptLine: Record "Sales Shipment Line"; SalesShptHeader: Record "Sales Shipment Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; PostedWhseShipmentLine: Record "Posted Whse. Shipment Line"; SalesHeader: Record "Sales Header"; WhseShip: Boolean; WhseReceive: Boolean; ItemLedgShptEntryNo: Integer; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var IsHandled: Boolean)
    begin
        SalesShptLine."Sub Description" := SalesLine."Sub Description";
        SalesShptLine."Sub Location Code" := SalesLine."Sub Location Code";
        SalesShptLine."Sub Description 2" := SalesLine."Sub Description 2";
    end;

    // Posted Sales Invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure UpdateInvoice(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; PostingSalesLine: Record "Sales Line"; SalesShipmentHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    begin
        SalesInvLine."Sub Description" := SalesLine."Sub Description";
        SalesInvLine."Sub Location Code" := SalesLine."Sub Location Code";
        SalesInvLine."Sub Description 2" := SalesLine."Sub Description 2";
    end;

    //Posted Purchase Invoice
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', false, false)]
    local procedure UpdateInfoPurchInvLine(var PurchInvLine: Record "Purch. Inv. Line"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    begin
        PurchInvLine."Sub Location Code" := PurchaseLine."Sub Location Code";
        PurchInvLine."Sub Description" := PurchaseLine."Sub Description";
        PurchInvLine."Sub Description 2" := PurchaseLine."Sub Description 2";
    end;

    //Posted Purchase Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', false, false)]
    local procedure UpdateInfoPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; PostedWhseRcptLine: Record "Posted Whse. Receipt Line"; var IsHandled: Boolean)
    begin
        PurchRcptLine."Sub Location Code" := PurchLine."Sub Location Code";
        PurchRcptLine."Sub Description" := PurchLine."Sub Description";
        PurchRcptLine."Sub Description 2" := PurchLine."Sub Description 2";
    end;

    //Posted Transfer Shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeInsertTransShptLine', '', false, false)]
    local procedure UpdateInfoTransferShipLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransShptHeader: Record "Transfer Shipment Header")
    begin
        TransShptLine."Sub Location Code" := TransLine."Sub Location Code";
        TransShptLine."Sub Description" := TransLine."Sub Description";
        TransShptLine."Sub Description 2" := TransLine."Sub Description 2";
    end;

    //Posted Transfer Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure UpdateInfoTransferRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransRcptLine."Sub Location Code" := TransLine."Sub Location Code";
        TransRcptLine."Sub Description" := TransLine."Sub Description";
        TransRcptLine."Sub Description 2" := TransLine."Sub Description 2";
    end;

    //Purchase Quote -> Purchase Order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', false, false)]
    local procedure UpdateInfoPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
        PurchOrderLine."Sub Location Code" := PurchQuoteLine."Sub Location Code";
        PurchOrderLine."Sub Description" := PurchQuoteLine."Sub Description";
        PurchOrderLine."Sub Description 2" := PurchQuoteLine."Sub Description 2";
    end;

    //Sales Quote -> Sales Order
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure UpdateInfoSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderLine."Sub Location Code" := SalesQuoteLine."Sub Location Code";
        SalesOrderLine."Sub Description" := SalesQuoteLine."Sub Description";
        SalesOrderLine."Sub Description 2" := SalesQuoteLine."Sub Description 2";
    end;

    //Posted Purchase Return Shipment
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeReturnShptLineInsert', '', false, false)]
    local procedure OnBeforeReturnShptLineInsert(var ReturnShptLine: Record "Return Shipment Line"; var ReturnShptHeader: Record "Return Shipment Header"; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean)
    begin
        ReturnShptLine."Sub Location Code" := PurchLine."Sub Location Code";
        ReturnShptLine."Sub Description" := PurchLine."Sub Description";
        ReturnShptLine."Sub Description 2" := PurchLine."Sub Description 2";
    end;

    //Posted Purchase Credit Memo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchCrMemoLineInsert', '', false, false)]
    local procedure OnBeforePurchCrMemoLineInsert(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean; var xPurchaseLine: Record "Purchase Line")
    begin
        PurchCrMemoLine."Sub Location Code" := PurchLine."Sub Location Code";
        PurchCrMemoLine."Sub Description" := PurchLine."Sub Description";
        PurchCrMemoLine."Sub Description 2" := PurchLine."Sub Description 2";
    end;

    //Posted Sales Return Receipt
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptLineInsert', '', false, false)]
    local procedure OnBeforeReturnRcptLineInsert(var ReturnRcptLine: Record "Return Receipt Line"; ReturnRcptHeader: Record "Return Receipt Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; xSalesLine: record "Sales Line"; var TempSalesLineGlobal: record "Sales Line" temporary; var SalesHeader: Record "Sales Header")
    begin
        ReturnRcptLine."Sub Location Code" := SalesLine."Sub Location Code";
        ReturnRcptLine."Sub Description" := SalesLine."Sub Description";
        ReturnRcptLine."Sub Description 2" := SalesLine."Sub Description 2";
    end;

    //Posted Sales Credit Memo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesCrMemoLineInsert', '', false, false)]
    local procedure OnBeforeSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; var SalesHeader: Record "Sales Header"; var SalesShptHeader: Record "Sales Shipment Header"; var ReturnRcptHeader: Record "Return Receipt Header"; var PostingSalesLine: Record "Sales Line")
    begin
        SalesCrMemoLine."Sub Location Code" := SalesLine."Sub Location Code";
        SalesCrMemoLine."Sub Description" := SalesLine."Sub Description";
        SalesCrMemoLine."Sub Description 2" := SalesLine."Sub Description 2";
    end;

}
