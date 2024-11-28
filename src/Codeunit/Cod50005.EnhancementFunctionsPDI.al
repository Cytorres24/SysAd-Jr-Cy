codeunit 50005 "Enhancement Functions PDI"
{
    // procedure GetLockedDispenseDate(POSTerminalNo: Code[20]): Date
    // var
    //     POSTerminal: Record "LSC POS Terminal";
    // begin
    //     if POSTerminal.Get(POSTerminalNo) then
    //         // if POSTerminal."Locked Dispense Date" <> 0D then
    //         //     exit(POSTerminal."Locked Dispense Date");
    //         if POSTerminal.LockedDate <> 0D then
    //             exit(POSTerminal.LockedDate);
    //     exit(Today);
    // end;

    procedure CreateCSVForBartender(var POSTrans: Record "LSC POS Transaction")
    var
        POSTransLine: Record "LSC POS Trans. Line";
        TempBlob: Codeunit "Temp Blob";
        InS: InStream;
        OutS: OutStream;
        TxtBuilder: TextBuilder;
        FileName: Text;
        CommaLbl: Label ',';
    begin
        if not Confirm('Are you sure you want to create CSV file for this transaction?', true) then
            exit;
        FileName := 'ReceiptNo_' + POSTrans."Receipt No." + '_' + Format(CurrentDateTime) + '.csv';
        TxtBuilder.AppendLine('Ackn. Receipt No.' + CommaLbl + 'Store No.' + CommaLbl + 'Item No.'
                                + CommaLbl + 'Item Description' + CommaLbl + 'Amount');
        POSTransLine.Reset();
        POSTransLine.SetRange("Store No.", POSTrans."Store No.");
        POSTransLine.SetRange("Receipt No.", POSTrans."Receipt No.");
        POSTransLine.SetRange("Entry Type", POSTransLine."Entry Type"::Item);
        if POSTransLine.FindSet() then
            repeat
                TxtBuilder.AppendLine(AddDoubleQuotes(Format(POSTransLine."Ackn. Receipt No.")) + CommaLbl +
                        AddDoubleQuotes(Format(POSTransLine."Store No.")) + CommaLbl +
                        AddDoubleQuotes(Format(POSTransLine.Number)) + CommaLbl +
                        AddDoubleQuotes(Format(POSTransLine.Description)) + CommaLbl +
                        AddDoubleQuotes(Format(POSTransLine.Amount)));
            until POSTransLine.Next() = 0;
        TempBlob.CreateOutStream(OutS);
        OutS.WriteText(TxtBuilder.ToText());
        TempBlob.CreateInStream(InS);
        DownloadFromStream(InS, '', '', '', FileName);
    end;

    local procedure AddDoubleQuotes(FieldValue: Text): Text
    begin
        exit('"' + FieldValue + '"');
    end;
}
