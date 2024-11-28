codeunit 50003 BufferTablePopulator
{
    // trigger OnRun()
    // var
    // posline: Record "LSC POS Trans. Line";
    // buffer:Record BufferTable;

    // begin
    //     buffer.DeleteAll();

    //     if posline.FindSet() then
    //     begin
    //         repeat
    //         buffer.Init();
    //         buffer."Item No." := posline.Number;
    //         buffer.Description := posline."Sub Description";
    //         buffer.Brand := posline."Sub Description 2";
    //         buffer."Unit of measure" := posline."Unit of Measure";
    //         buffer.Quantity := posline.Quantity;
    //         buffer.Insert();
    //         until posline.Next = 0;
    //     end;
    // end;
}
