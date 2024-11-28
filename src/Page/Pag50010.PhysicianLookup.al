page 50010 PhysicianLookup
{
    ApplicationArea = All;
    Caption = 'PhysicianLookup';
    PageType = List;
    SourceTable = "Doctors List";
    UsageCategory = Lists;
    
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("No.";Rec."No."){}
                field(Name;Rec.Name){}
                field("License No.";Rec."License No."){}
                field("Medical Type";Rec."Medical Type"){}
            }
        }
    }
    Actions
    {
        Area(Processing)
        {
            Action("SelectDoctor")
            {
                Caption = 'Select Doctor';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                Trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
    var
    Docid: code[20];

    procedure GetDocid(): Code[20]
    begin
        exit(Docid)
    end;
}

    

