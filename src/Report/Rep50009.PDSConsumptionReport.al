report 50009 "PDS Consumption Report"
{
    ApplicationArea = Basic, Suite;
    Caption = 'PDS Consumption Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = '.\PDS Consumption Report.rdl';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("LSC POS Trans. Line"; "LSC POS Trans. Line")
        {
            RequestFilterFields = Number, "Item Category Code", "Retail Product Code";
            column(Number; Number) { }
            COLUMN(Unit_of_Measure; "Unit of Measure") { }
            column(Description; Description) { }
            COLUMN(Sub_Description; "Sub Description") { }
            COLUMN(Sub_Description_2; "Sub Description 2") { }
            COLUMN(Price; Price) { }
            COLUMN(Quantity; Quantity) { }
            COLUMN(Amount; Amount) { }
            column(Receipt_No_; "Receipt No.") { }
            column(vDispDateFrom; vDispDateFrom) { }
            column(vDispDateTo; vDispDateTo) { }
            column(vstorefilter; vstorefilter) { }
            column(Storeadd; recstore.Address) { }
            column(storephone; recstore."Phone No.") { }
            column(vfilters; vfilters) { }
            trigger OnPreDataItem()
            begin
                // Set a default filter to exclude zero values for the "Quantity" field
                SetFilter(Quantity, '<>0');

                if (vDispDateFrom = 0D) OR (vDispDateTo = 0D) THEN
                    ERROR('Dispense Date must no be blank');
                SETRANGE("Trans. Date", vDispDateFrom, vDispDateTo);

                if vstorefilter <> '' then
                    SetRange("Store No.", vstorefilter);

                SetFilter("Entry Status", '<>Voided');
                // Set other filters as needed

                vfilters := "LSC POS Trans. Line".GetFilters;

                recstore.Get(vstorefilter);
            end;
            // trigger OnAfterGetRecord()
            // begin
            //       "LSC POS Trans. Line".SetFilter(number, '%1', recsubcode."Item Code");
            //     // if itemledger.GET("Entry No.") THEN begin
            //     if recsubcode.Get() THEN begin
            //         "LSC POS Trans. Line"."Unit of Measure" := recsubcode.UnitofMeasure;
            //     end;
            // end;

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
                    field(vDispDateFrom; vDispDateFrom)
                    {
                        Caption = 'Dispense Date from';
                    }
                    field(vDispDateTo; vDispDateTo)
                    {
                        Caption = 'Dispense Date to';
                    }
                    field(vstorefilter; vstorefilter)
                    {
                        Caption = 'Store No.';
                    }

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    var
        vDispDateFrom: Date;
        vDispDateTo: Date;
        vstorefilter: Code[10];
        recstore: Record "LSC Store";
        vfilters: Text;
        recsubcode: Record "Planet Subcode";
}
