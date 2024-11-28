tableextension 50029 "Inventory Lookup" extends "LSC Inventory Lookup Table"
{
    fields
    {
  
    }
    local procedure Updateinventory (PtsActive: Boolean)
    var
    LSCRETAIL: Record "LSC Retail Setup";
    begin
        if PtsActive then begin
            if "Variant Code" <> '' then
            "Net Inventory" := "Var. Phys. Inventory" - "Var. Total Sales" + "Var. Posted Sales" + "Var. Total Inv. Adjmt." - "Var. Posted Inv. Adjmt."

            else begin
                if LSCRETAIL."Enable Auto Tender Deduction" THEN begin
                    CalcFields("Calc. Phys. Inventory","Calc. Total Sales","Calc. Purch. Order.","Calc. Posted Sales","Calc. Total Inv. Adjmt.","Calc. Posted Inv. Adjmt.");

                    "Net Inventory" := ("Phys. Inventory" - "Total Sales" + "Posted Sales" + "Total Inv. Adjmt." - "Posted Inv. Adjmt.") + (-"Calc. Total Sales");
                end
                else
                "Net Inventory" := "Phys. Inventory" - "Total Sales" + "Posted Sales" + "Total Inv. Adjmt." - "Posted Inv. Adjmt.";
            end; 
            begin
                CalcFields("Calc. Phys. Inventory","Calc. Total Sales","Calc. Purch. Order.","Calc. Posted Sales","Calc. Total Inv. Adjmt.","Calc. Posted Inv. Adjmt.");

                 "Net Inventory" := "Calc. Phys. Inventory" - "Calc. Total Sales" + "Calc. Posted Sales" + "Calc. Total Inv. Adjmt." - "Calc. Posted Inv. Adjmt.";

                 "Net Inventory" := "Phys. Inventory" - "Calc. Total Sales" + "Calc. Posted Sales" + "Calc. Total Inv. Adjmt." - "Calc. Posted Inv. Adjmt.";
            END;
        end;
    end;
}
