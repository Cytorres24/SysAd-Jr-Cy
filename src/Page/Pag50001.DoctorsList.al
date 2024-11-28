page 50001 "Doctors List"
{
    ApplicationArea = All;
    Caption = 'Doctors List';
    PageType = List;
    SourceTable = "Doctors List";
    UsageCategory = Lists;

    layout
    {

        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Select Doctors for this transaction';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("License No."; Rec."License No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("Store No."; Rec."Store No.")
                {
                    ApplicationArea = All;
                    TableRelation = "LSC Store";
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("Medical Type"; Rec."Medical Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("No. Series";Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                
            }
            
        }
        
    }
    var
    docid: Code[20];
        procedure getdocid(): code[20]
    begin
        exit(docid);
    end;
}
