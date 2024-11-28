codeunit 50000 "EventSubscription PDI"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeInsertItemLine', '', false, false)]
    local procedure LSCPOSTransEvents_OnBeforeInsertItemLine(var POSTransaction: Record "LSC POS Transaction"; var POSTransLine: Record "LSC POS Trans. Line")
    begin
        POSTransLine."Dispense Date" := POSTransaction."Dispense Date";
        POSTransLine."Ackn. Receipt No." := POSTransaction."Ackn. Receipt No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterSuspend', '', false, false)]
    local procedure LSCPOSTransEvents_OnAfterSuspend(var POSTransaction: Record "LSC POS Transaction")
    var
        POSTerminal: Record "LSC POS Terminal";
        POSTransLine: Record "LSC POS Trans. Line";
        NoSeriesMngt: Codeunit NoSeriesManagement;
    begin
        if POSTerminal.Get(POSTransaction."Created on POS Terminal") then begin
            POSTerminal.TestField("Ackn. Receipt No. Series");
            if POSTransaction."Ackn. Receipt No." = '' then
                POSTransaction."Ackn. Receipt No." := NoSeriesMngt.GetNextNo(POSTerminal."Ackn. Receipt No. Series", Today, true);

            // if POSTransaction."Dispense Date" = 0D then
            //     POSTransaction."Dispense Date" := Today;
            // Clear(POSTransLine);
            // POSTransLine.SetFilter("Receipt No.", POSTransaction."Receipt No.");
            // if POSTransLine.FindSet() then begin
            //     POSTransLine.ModifyAll("Dispense Date", POSTransaction."Dispense Date");
            //     POSTransLine.ModifyAll("Ackn. Receipt No.", POSTransaction."Ackn. Receipt No.");
            // end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnBeforeStartNewTransaction', '', false, false)]
    local procedure LSCPOSTransEvents_OnBeforeStartNewTransaction(var POSTransaction: Record "LSC POS Transaction")
    begin
        // POSTransaction."Dispense Date" := EnhancementFunctions.GetLockedDispenseDate(POSTransaction."Created on POS Terminal");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction Events", 'OnAfterLogoff', '', false, false)]
    local procedure LSCPOSTransEvents_OnAfterLogoff(var POSTransaction: Record "LSC POS Transaction")
    var
        POSTerminal: Record "LSC POS Terminal";
    begin
        // if POSTerminal.Get(POSTransaction."Created on POS Terminal") then begin
        //     //POSTerminal."Locked Dispense Date" := 0D;
        //     POSTerminal.LockedDate := 0D;
        //     POSTerminal.Modify();
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Post Utility", 'OnAfterInsertTransHeader', '', false, false)]
    local procedure LSCPOSPostUtility_OnAfterInsertTransHeader(var Transaction: Record "LSC Transaction Header"; var POSTrans: Record "LSC POS Transaction")
    var
        POSTerminal: Record "LSC POS Terminal";
    begin
        Transaction."Dispense Date2" := POSTrans."Dispense Date";
        Transaction."Ackn. Receipt No." := POSTrans."Ackn. Receipt No.";
        // modify Official Receipt No here into Ackn. Receipt No.
        // if (POSTrans."Transaction Type" = POSTrans."Transaction Type"::Sales) and
        //         (POSTrans."Entry Status" = POSTrans."Entry Status"::" ") then
        //     if POSTerminal.Get(POSTrans."POS Terminal No.") then
        //         if POSTerminal."Official Receipt Nos." = POSTerminal."Ackn. Receipt No. Series" THEN
        //             OfficialReceiptNo := POSTrans."Ackn. Receipt No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Print Utility", 'OnAfterPrintSuspendSlip', '', false, false)]
    local procedure LSCPOSPrintUtil_OnBeforePrintSuspendSlip(var POSTrans: Record "LSC POS Transaction")
    begin
        //-Create CSV
        EnhancementFunctions.CreateCSVForBartender(POSTrans);
    end;


    var
        EnhancementFunctions: Codeunit "Enhancement Functions PDI";


    // for testing 
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"LSC POS Transaction", 'OnAfterKeyboardTriggerToProcess', '', true, true)]
    // local procedure HandlePOSCustomNumpadTrigger(InputValue: Text; KeyboardTriggerToProcess: Integer; var Rec: Record "LSC Transaction Header"; var IsHandled: Boolean; ResultOk: Boolean)
    // var
    //     POSHandler: Codeunit POSCommands;
    //     NumPadTrigger: Enum "LSC POS Command";
    // begin
    //     // Check if the trigger corresponds to our custom action
    //     if KeyboardTriggerToProcess = Integer(NumPadTrigger::ChangeDsDate) then begin
    //         // Call the custom handler to process the Change Dispense Date action
    //         POSHandler.HandleCustomNumpadTrigger(KeyboardTriggerToProcess, InputValue);
    //         IsHandled := true; // Mark as handled
    //     end;
    // end;
}


