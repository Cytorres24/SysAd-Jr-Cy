page 50008 "Cluster List"
{
    ApplicationArea = All;
    Caption = 'Cluster List';
    PageType = List;
    SourceTable = Cluster;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    TableRelation = "LSC Store";
                }
            }
        }
    }
}
