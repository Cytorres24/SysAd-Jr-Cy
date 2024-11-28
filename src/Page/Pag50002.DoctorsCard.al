page 50002 "Doctors Card"
{
    Caption = 'Doctors Card';
    PageType = Card;
    SourceTable = "Doctors List";
    //ApplicationArea = All;
    //UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
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
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
                field("Medical Type"; Rec."Medical Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License No. field.', Comment = '%';
                }
            }
        }
    }
}
