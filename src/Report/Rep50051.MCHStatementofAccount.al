report 50051 "MCH Statement of Account"
{
    ApplicationArea = All;
    Caption = 'MCH Statement of Account';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\MCH Statement of Account.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(LSCPOSTransaction; "LSC POS Transaction")
        {
            column(ReceiptNo; "Receipt No.") { }
            column(StoreNo; "Store No.") { }
            //column(TransDate; "Trans. Date") { }
            column(Dispense_Date; "Dispense Date") { }
            column(NetAmount; "Net Amount") { }
            column(GrossAmount; "Gross Amount") { }
            column(EntryStatus; "Entry Status") { }
            column(SalesType; "Sales Type") { }
            column(MemberCardNo; "Member Card No.") { }
            column(Description; GetYelloCardHolder("Member Card No.")) { }
            column(TransDateFrom; TransDateFrom) { }
            column(TransDateTo; TransDateTo) { }
            column(vstorefilter; vstorefilter) { }
            //column(StoreAdd; GetStoreAddress("Store No.")) { }
            column(StoreAdd; GetStoreAddress(vstorefilter)) { }
            column(PhoneDetails; GetPhoneDetails("Store No.")) { }
            column(TinCode; recCompanyInfo."VAT Registration No.") { }

            trigger OnPreDataItem()

            begin
                if vstorefilter <> '' then
                    SetFilter("Store No.", vstorefilter);

                if GetFilter("Store No.") = '' then
                    Error('Store must not be blank');

                SetRange("Entry Status", LSCPOSTransaction."Entry Status"::Suspended);
                //SetRange("Trans. Date", TransDateFrom, TransDateTo);
                SetRange("Dispense Date", TransDateFrom, TransDateTo);
                SetFilter("Net Amount", '<>0');
                //recStore.Get(vstorefilter);

                if vstorefilter = '' then
                    Error('Store must not be blank');
            end;
        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Report Filter';
                    field(TransDateFrom; TransDateFrom)
                    {
                        Caption = 'Dispence Date From';
                        ApplicationArea = All;
                        ToolTip = 'Enter the start date for filtering records.';
                    }

                    field(TransDateTo; TransDateTo)
                    {
                        Caption = 'Dispence Date To';
                        ApplicationArea = All;
                        ToolTip = 'Enter the end date for filtering records.';
                    }
                    field(vstorefilter; vstorefilter)
                    {
                        Caption = 'Store Code';
                        ApplicationArea = All;
                        TableRelation = "LSC Store";
                    }
                }
            }
        }

        actions
        {
            area(Processing) { }
        }
    }

    var
        TransDateFrom: Date;
        TransDateTo: Date;
        vstorefilter: Code[10];
        StoreAdd: Text[250];
        recStore: Record "LSC Store";
        recCompanyInfo: Record "Company Information";

    local procedure GetYelloCardHolder(pCustomer: Code[20]): Text
    var
        LRecMember: Record "LSC Member Account";
    begin
        if LRecMember.Get(pCustomer) then
            exit(LRecMember.Description) else
            exit('');
    end;

    //local procedure GetStoreAddress(vStore: Code[20]): Text
    local procedure GetStoreAddress(vstorefilter: Code[20]): Text
    var
        recStore: Record "LSC Store";
    begin
        //if recStore.Get(pStore) then
        if recStore.Get(vstorefilter) then
            exit(recStore.Address + ' ' + recStore."Address 2" + ' ' + recStore.City)
        else
            exit('');
    end;

    //local procedure GetPhoneDetails(pStore: Code[20]): Text
    local procedure GetPhoneDetails(vstorefilter: Code[20]): Text
    begin
        //if recStore.Get(pStore) then
        if recStore.Get(vstorefilter) then
            exit(recStore."Phone No.") else
            exit('');
    end;

    local procedure GetTinDetails(pStore: Code[20]): Text
    begin
        if recStore.Get(pStore) then
            exit(recCompanyInfo."VAT Registration No.") else
            exit('');
    end;
}
