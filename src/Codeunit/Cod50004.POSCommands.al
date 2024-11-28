codeunit 50004 POSCommands
{
    TableNo = "LSC POS Menu Line";

    trigger OnRun()
    var

        inputNumber: Decimal;
        inputText: Text;
        login: Page Login;
        InputValue: Code[20];
        dialog: TextEncoding;
        inputpassword: text[200];
        DISPENSE: Page DispenseDate;
        LDISPENSEDATE: Text[30];
        POSTRANSACTION: Record "LSC POS Transaction";
        selectphysician: Boolean;
        Physician: Page "Doctors List";
        Pcode: code[20];
        physiciantb: Record "Doctors List";
        POSTRANSC: Codeunit "LSC POS Transaction";
        DD_FORMAT: TextConst ENU = 'MM/DD/YYYY';
        postransfound: Boolean;
        POSTerminal: Record "LSC POS Terminal";
        storesetup: Record "LSC Store";
        POSSession: Codeunit "LSC POS Session";
        postrans: Record "LSC POS Transaction";
        sl: Record "LSC POS Trans. Line";
        PosFuncProfile: Record "LSC POS Func. Profile";



    begin
        if Rec."Registration Mode" then
            register(Rec)
        ELSE BEGIN
            POSTerminal.GET(POSSession.TerminalNo);

            StoreSetup.GET(POSTerminal."Store No.");
            // //  PosFuncProfile.GET(Globals.FunctionalityProfileID); //LS-3702
            PosFuncProfile.GET(POSSession.FunctionalityProfileID); //LS-3702

            POSTransFound := TRUE;
            IF PosTrans.GET(postrans."Receipt No.") THEN BEGIN
                IF sl.GET(PosTrans."Receipt No.", rec."Current-LINE") THEN;
            END ELSE
                POSTransFound := FALSE;

            case Rec.Command of
                'SELECT_pharma':
                    Selectpharma();
                'CH_DATE':
                    ChangeDispenseDate(Rec);
            END;
        end;
    end;

    local procedure Register(var POSMenuLine: Record "lsc POS Menu Line")
    var
        POSCommandReg: Codeunit "lsc POS Command Registration";

    begin
        // Register the module:
        POSCommandReg.RegisterModule('POSCOMMAND', 'PDSCOMMANDS', Codeunit::"POSCOMMANDS");
        // Register the command, as many lines as there are commands in the Codeunit:
#pragma warning disable AL0603
        POSCommandReg.RegisterExtCommand('SELECT_Pharma', 'Select Pharmacist', Codeunit::"POSCOMMANDS", 0, 'POSCOMMAND', false);
#pragma warning restore AL0603
#pragma warning disable AL0603
        POSCommandReg.RegisterExtCommand('CH_DATE', 'Change Dispense Date', Codeunit::"POSCOMMANDS", 0, 'POSCOMMAND', false);
#pragma warning restore AL0603
#pragma warning disable AL0603
        POSCommandReg.RegisterExtCommand('SELECT_DOC', 'Select Physician', Codeunit::"POSCOMMANDS", 0, 'POSCOMMAND', false);
#pragma warning restore AL0603
#pragma warning disable AL0603
        POSCommandReg.RegisterExtCommand('SELECT_YC', 'Select YellowCard', Codeunit::"POSCOMMANDS", 0, 'POSCOMMAND', false);
#pragma warning restore AL0603

        POSMenuLine."Registration Mode" := false;
    end;

    var
        LookupRecRef: RecordRef;
        SelectPhysicianOnly: Boolean;
    // GlobalLSCPOSMenuLine: Record "LSC POS Menu Line";
    // GlobalLSCPOSTransC: Codeunit "LSC POS Transaction";
    // GlobalPOSTransaction: Record "LSC POS Transaction";
    // GlobalLSCPOSTerminal: Record "LSC POS Terminal";
    // GlobalLSCPOSSessionC: Codeunit "LSC POS Session";

    local procedure ChangeDispenseDate(POSMenuLine: Record "LSC POS Menu Line") // WORKING
    var
        Dispense: Page DispenseDate;
        POSTRANSACTION: Record "LSC POS Transaction";
        TERMINAL: Record "LSC POS Terminal";
        POSSESSION: Codeunit "LSC POS Session";
        LDispenseDate: Text[30];
        CurrentDispenseDate: text[30];
        CanChangeDate: Boolean;
        LSCPosControl: Codeunit "LSC POS Control Interface";
        EnterDispenseDateLbl: Label 'Enter new dispense date (MMDDYYYY):';
        Result: Action;
        POSTransC: Codeunit "LSC POS Transaction";
    begin
        // Validate Receipt No.
        if POSMenuLine."Current-RECEIPT" = '' then begin
            PosMessage('No transaction found. Please select a valid transaction before changing the dispense date.');
            exit;
        end;

        // Fetch the POS Transaction record
        if not POSTRANSACTION.GET(POSMenuLine."Current-RECEIPT") then begin
            PosMessage('The specified transaction does not exist. Please verify the Receipt No.');
            exit;
        end;

        // Fetch the Terminal record
        if not TERMINAL.GET(POSSession.TerminalNo) then begin
            PosMessage('Unable to retrieve terminal information. Please try again.');
            exit;
        end;

        TERMINAL.Get(POSSession.TerminalNo);

        //Open numeric keyboard for user input
        // POSTransC.OpenNumericKeyboard(EnterDispenseDateLbl, 0, LDispenseDate, '');

        if Dispense.RunModal = Action::Yes then begin
            LDISPENSEDATE := Dispense.Getdispensedate();

            if LDispenseDate <> '' then
                Evaluate(POSTRANSACTION."Dispense Date", LDispenseDate)
            else
                if TERMINAL.EnableLockedDate = true then
                    POSTRANSACTION."Dispense Date" := TERMINAL.LockedDate
                else
                    POSTRANSACTION."Dispense Date" := today;
            POSTRANSACTION.Modify;

            if TERMINAL.EnableLockedDate = true then
                TERMINAL.LockedDate := POSTRANSACTION."Dispense Date"
            else
                TERMINAL.LockedDate := 0D;
            TERMINAL.Modify;


            PosMessage(StrSubstNo('Dispense date successfully updated to: %1', POSTRANSACTION."Dispense Date"));
        end
        else begin
            PosMessage('Dispense date update cancelled by user.');
        end;
    end;

    local procedure Selectpharma() // WORKING
    var
        Pharma: Code[20];
        tmpStaff: Record "LSC Staff";
        StaffStoreLink: Record "lsc Staff Store Link";
        POSSession: Codeunit "LSC POS Session"; // Replace with your POS session codeunit
        Terminal: Record "lsc POS Terminal"; // Replace with the actual terminal table name
        StaffStoreOk: Boolean;
        Text220: Label 'Staff not found: %1 %2';
        Text153: Label 'Staff is not authorized for this store.';
        txt001: Label 'Pharmacist %1 is now on duty.';
        POSCTRL: Codeunit "LSC POS Control Interface";
        login: Page Login;
        password: text[200];


    begin
        if login.RunModal = Action::Yes then begin
            Pharma := login.GetInputNumber();
            password := login.GetInputPassword();

            IF not tmpStaff.GET(Pharma) THEN BEGIN
                PosMessage(StrSubstNo('Error: Pharmacist ID %1 not recognized. Please try again.', Pharma));
                EXIT;
            END;

            IF Terminal.GET(POSSession.TerminalNo) THEN BEGIN
                Terminal.PharmacistDuty := Pharma;
                Terminal.MODIFY;
            END;

            PosMessage(STRSUBSTNO('Pharmacist %1 logged in successfully.', Pharma));
        end;
    end;


    local procedure PosMessage(Txt: Text): Boolean
    var
        Ok: Boolean;
        SCANNERENABLED: Boolean;
        POSGui: Codeunit "LSC POS GUI";
    begin
        Ok := POSGui.PosMessage(Txt);
        EXIT(Ok);
    end;
}


// local procedure ChangeDispenseDate()
// var
//     InputValue: Text[30];
//     DispenseDate: Date;
//     ReceiptNo: Code[20];
//     EnterDispenseDateLbl: Label 'Enter new dispense date (MMDDYYYY):';
// // IsInitialized: Boolean;
// begin

//     GlobalLSCPOSTransC.OpenNumericKeyboard(EnterDispenseDateLbl, 0, '', InputValue);

//     GlobalLSCPOSTerminal.Get(GlobalLSCPOSSessionC.TerminalNo);

//     if InputValue <> '' then
//         Evaluate(GlobalPOSTransaction."Dispense Date", InputValue);

//     GlobalPOSTransaction.Modify();

// end;    


// local procedure OpenNumericKeyboard(Caption: Text; KeybType: Integer; DefaultValue: Text; payload: text): Text
// var
//     Result: Text;
//     POSGUI: Codeunit "LSC POS GUI";
// begin
//     Commit;
//     POSGUI.OpenNumericKeyboard(Caption, KeybType, DefaultValue, 0, payload);

// end;

// local procedure ErrorBeep(Txt: Text[150])
// var
//     OposUtil: Codeunit "LSC POS OPOS Utility";
// begin
//     //ErrorBeep
//     OposUtil.Beeper;
//     OposUtil.Beeper;
// end;

//Look up and select list of doctors
// local procedure LookupAndSelectDoctor()
// var
//     recDoctor: Record "Doctors List";
//     doctorPageId: Integer;
//     selectedDoctorID: Code[20];
//     currentReceiptNo: Code[20];
// begin
//     // Run the Doctor List Lookup page
//     doctorPageId := Page::PhysicianLookup;
//     if Page.RunModal(doctorPageId, recDoctor) = Action::LookupOK then begin
//         // If a doctor is selected, capture the Doctor ID
//         selectedDoctorID := recDoctor."No.";

//         // Step 1: Get the current active transaction's receipt number
//         // currentReceiptNo := GetCurrentTransactionNo();
//         currentReceiptNo := GetCurrentTransactionNumber();

//         // If no current transaction is found, show an error
//         if currentReceiptNo = '' then begin
//             Message('No active transaction found.');
//             exit;
//         end;

//         // Step 2: Call the function to set the doctor in the transaction
//         // SetDoctorInTransaction(selectedDoctorID, currentReceiptNo);
//         ApplyDoctorToPOSTransaction(selectedDoctorID, currentReceiptNo);
//     end else
//         Message('No doctor selected.');
// end;

// local procedure SetDoctorInTransaction(DoctorID: Code[20]; currentReceiptNo: Code[20])
// var
//     recPOS: Record "LSC POS Transaction";
//     recDoctor: Record "Doctors List";
// begin
//     // Step 3: Fetch the POS transaction using the current receipt number
//     if not recPOS.Get(currentReceiptNo) then begin
//         Message('POS transaction not found for Receipt No. %1', currentReceiptNo);
//         exit;
//     end;

//     // Step 4: Fetch the doctor record using Doctor ID
//     if not recDoctor.Get(DoctorID) then begin
//         Message('Doctor with ID %1 not found.', DoctorID);
//         exit;
//     end;

//     // Step 5: Modify the transaction with the doctor's information
//     recPOS."MCHDOCID" := recDoctor."No.";             // Assign Doctor ID
//     recPOS."MCHDOCLICENSE" := recDoctor."License No."; // Assign Doctor's License Number
//     recPOS."MCHDOCNAME" := recDoctor.Name;            // Assign Doctor's Name

//     // Step 6: Modify the POS transaction and save the changes
//     recPOS.Modify();

//     // Step 7: Notify the user
//     Message('Transaction %1 has been updated with Doctor %2.', currentReceiptNo, recDoctor.Name);
// end;


// local procedure GetCurrentTransactionNo(): Code[20]
// var
//     recPOS: Record "LSC POS Transaction";
//     currentReceiptNo: Code[20];
//     menu: Record "LSC POS Menu Line";
//     session: Codeunit "LSC POS Session";
// begin
//     // Try to find the most recent (active) POS transaction
//     if recPOS.FindLast() then begin
//         // currentReceiptNo := recPOS."Receipt No.";
//         currentReceiptNo := recPOS."Receipt No."; // Get the most recent receipt number
//         exit(currentReceiptNo);
//     end;
//     // If no active transaction found, return an empty string
//     exit('');
// end;

// local procedure LookupAndSelectDoctor()
// var
//     recDoctor: Record "Doctors List"; // Replace with the actual table for doctors
//     doctorPageId: Integer;
//     selectedDoctorID: Code[20];
//     currentReceiptNo: Code[20];
// begin
//     // Run the Doctor List Lookup page
//     doctorPageId := Page::PhysicianLookup; // Replace with your actual page ID for the doctor lookup
//     if Page.RunModal(doctorPageId, recDoctor) = Action::LookupOK then begin
//         // If a doctor is selected, capture the Doctor ID
//         selectedDoctorID := recDoctor."No.";

//         // Step 1: Get the current active transaction's receipt number
//         currentReceiptNo := GetCurrentTransactionNumber();

//         // If no current transaction is found, show an error
//         if currentReceiptNo = '' then begin
//             Message('No active transaction found.');
//             exit;
//         end;

//         // Step 2: Call the function to set the doctor in the transaction
//         ApplyDoctorToPOSTransaction(selectedDoctorID, currentReceiptNo);
//     end else
//         Message('No doctor selected.');
// end;

// procedure ApplyDoctorToPOSTransaction(SelectedDoctorCode: Code[20]; CurrentTransaction: Code[30])
// var
//     DoctorRec: Record "Doctors List"; // Replace with the actual Doctors table
//     POSTransRec: Record "LSC POS Transaction"; // Replace with the actual POS Transaction table
// begin
//     // Validate the selected doctor's record exists
//     if not DoctorRec.Get(SelectedDoctorCode) then
//         Error('The selected doctor does not exist.');

//     // Retrieve the current POS transaction
//     if not POSTransRec.Get(CurrentTransaction) then
//         Error('POS transaction with Receipt No. %1 not found.', CurrentTransaction);

//     // Update the "MCH Doc Name" field with the selected doctor's name
//     POSTransRec.MCHDOCNAME := DoctorRec."Name"; // Replace "Name" with the field in your Doctors table
//     POSTransRec.Modify();

//     Message('Doctor "%1" has been applied to POS Transaction with Receipt No. %2.', DoctorRec."Name", CurrentTransaction);
// end;

// local procedure GetCurrentTransactionNumber(): Code[20]
// var
//     POSTransHeader: Record "LSC Transaction Header"; // Replace with your POS Transaction Header table
//     CurrentStaffID: Code[10]; // Adjust length based on "Staff ID" field
//     CurrentTerminalID: Code[20];
// begin
//     // Map USERID to a valid Staff ID
//     // CurrentStaffID := GetMappedStaffID(USERID); // Custom procedure to get the correct Staff ID
//     CurrentTerminalID := GetCurrentTerminalID(); // Custom procedure to fetch the terminal ID

//     // Filter the POS Transaction Header to find the active transaction
//     POSTransHeader.SetRange("Staff ID", CurrentStaffID);
//     POSTransHeader.SetRange("POS Terminal No.", CurrentTerminalID);

//     // Find the active transaction
//     if POSTransHeader.FindFirst() then
//         exit(POSTransHeader."Receipt No."); // Replace with the correct field for the receipt number

//     Error('No active transaction found for staff %1 on terminal %2.', CurrentStaffID, CurrentTerminalID);
// end;

// local procedure GetMappedStaffID(UserID: Text[50]): Code[10]
// var
//     StaffMapping: Record "LSC Staff"; // Replace with the actual table for staff/user mapping
//     recpos:Record "LSC POS Transaction";
// begin
//     UserID:= recpos."Staff ID";
//     // if StaffMapping.Get(UserID) then
//     if StaffMapping.Get(UserID) then
//         exit(StaffMapping.ID); // Replace "Staff ID" with the mapped field

//     Error('Unable to map user %1 to a valid Staff ID.', UserID);
// end;

// local procedure GetCurrentTerminalID(): Code[20]
// var
//     POSSetup: Record "LSC POS Terminal";
//     POSSession: Codeunit "LSC POS Session";
// begin
//     // Fetch the terminal ID linked to the current session or user
//     // if POSSetup.Get(USERID) then
//     if POSSetup.Get(POSSession.TerminalNo) then
//         exit(POSSetup."No."); // Replace with the actual terminal ID field
//     Error('Unable to determine the current terminal ID.');
// end;

// If no active transaction is found, return an empty string

// local procedure SelectPhysicianPressed(pLookupCode: Code[20])
// var
//     recPhysician: Record "Doctors List";
// begin
//     if SelectPhysicianOnly = true THEN begin
//         LookUp(true, pLookupCode, '');
//     end;
//     // Trigger the lookup with the pLookupCode

// end;


// // This procedure sets the physician information on a related transaction (e.g., LSC POS Transaction)
// local procedure SetPhysician(pDocID: Code[20])
// var
//     recPhysician: Record "Doctors List";
//     rec: Record "LSC POS Transaction";
//     plookupcode: code[20];
// begin
//     // Try to get the physician record from the Doctors List
//     IF recPhysician.GET(pDocID) THEN BEGIN
//         // Update the current record with the physician details
//         REC.MCHDOCID := recPhysician."No."; // Set the physician's ID
//         REC.MCHDOCLICENSE := recPhysician."License No."; // Set the physician's license number
//         REC.MCHDOCNAME := recPhysician.Name; // Set the physician's name
//         REC.Modify; // Modify the current record to save changes

//         // Provide feedback to the user about the selected physician
//         Message(STRSUBSTNO('Physician %1 selected successfully.', recPhysician.Name));
//     END ELSE BEGIN
//         // If no physician is found, display a message
//         Message('Physician with code %1 not found.', pDocID);
//     END;
// end;


// // The main lookup procedure which initiates the lookup process
// LOCAL PROCEDURE LookUp(Execute: Boolean; FormID: Code[20]; Filter: Code[20]): Code[30]
// begin
//     EXIT(LookUpEx(Execute, FormID, Filter, LookupRecRef));
// end;

// // This procedure performs the actual lookup and calls SetPhysician if a valid physician is selected
// LOCAL procedure LookUpEx(Execute: Boolean; FormID: Code[20]; Filter: Code[20]; VAR LookupRecRef: RecordRef): Code[30]
// var
//     DynVarMenuOk: Boolean;
//     KeyValue: Code[30];  // Holds the selected physician ID
//     lookup: Record "LSC POS Lookup";
//     command: record "LSC POS Command";
//     Possession: Codeunit "LSC POS Session";
// begin
//     IF lookup."Lookup ID" = 'DOCTOR' THEN BEGIN
//      IF SelectPhysicianOnly = true THEN
//         IF KeyValue <> '' THEN
//             SetPhysician(KeyValue);
//         SelectPhysicianOnly := FALSE;
//     END;
//     END;





