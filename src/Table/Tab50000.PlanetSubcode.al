table 50000 "Planet Subcode"
{
    Caption = 'Planet Subcode';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = CustomerContent;
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get(Rec."Item Code");
                Rec.UnitofMeasure := Item."Base Unit of Measure";
            end;

        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(3; "Sub Description"; Text[100])
        {
            Caption = 'Sub Description';
            DataClassification = CustomerContent;
        }
        field(4; "Sub Description 2"; Text[100])
        {
            Caption = 'Sub Description 2';
            DataClassification = CustomerContent;
        }
        field(5; UnitofMeasure; code[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(6; Salestype; code[20])
        {
            Caption = 'Sales Type';
            DataClassification = CustomerContent;
            TableRelation = "LSC Sales Type";

        }
        // field(7; Enabled; Boolean)
        // {
        //     DataClassification = CustomerContent;

        //     trigger OnValidate()
        //     var
        //         IncludedItem: Record BufferTable;
        //     begin
        //         if Enabled <> false then begin
        //             IncludedItem.Init();
        //             // IncludedItem."Item No." := "Item Code";
        //             IncludedItem.Description := "Sub Description";
        //             IncludedItem."Unit of measure" := UnitofMeasure;
        //             IncludedItem.Quantity := 1;
        //             IncludedItem.Insert();
        //             Message('You successfully added the item on Medicine List Formulary');
        //         end else begin
        //             if IncludedItem.Get("Sub Description") then
        //                 IncludedItem.Delete();
        //             Message('You successfully delete the item on Medicine List Formulary');
        //         end;
        //     end;

        // }
    }
    keys
    {
        key(PK; "Item Code", "Location Code")
        {
            Clustered = true;
        }
    }

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterInsert(var ItemSubcode: Record "Planet Subcode")
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnAfterModify(var ItemSubcode: Record "Planet Subcode"; EnabledInclude: Boolean)
    // begin
    // end;

    // [IntegrationEvent(false, false)]
    // local procedure OnafterDelete(var ItemSubcode: Record "Planet Subcode"; EnabledInclude: Boolean)
    // begin
    // end;
    // // trigger OnInsert()
    // // var
    // // itemsubcode: Record "Planet Subcode";
    // // runtrigger: Boolean;
    // // pds: Codeunit "PDS General Utility";
    // // no: Code [20];

    // // begin
    // //      runtrigger := false;
    // //     if not runtrigger then begin
    // // if "Item Code" = '' then begin
    // // pds.SubcodingFilter(no,"Item Code");
    // // end;
    // //     end;
    // //     OnAfterInsert(ItemSubcode,runtrigger);
    // // end;

    // trigger OnModify()
    // var
    //     MedicineList: Record
    // begin
    //     if Rec.Enabled <> false then

    // end;
}
