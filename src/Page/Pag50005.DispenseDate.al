page 50005 DispenseDate
{
    PageType = ConfirmationDialog;
    // ApplicationArea = All;
    Editable = true;
    Caption = '';
    UsageCategory = None;
    

    layout
    {
        area(content)
        {
            group(EnterDispenseDate)
            {
                Caption = 'Enter Dispense Date';
            
                field("Dispense Date"; DATE)
                {
                    ApplicationArea = All;
                    // Specify that this field should only accept numbers
                    ToolTip = 'Enter Dispense Date';
                }
            }
        }
    }

    var
        // InputNumber: Code[20];
        // Inputpaswword: text[200];
        DATE:Text[30];

    // Expose the input value as a public method
    procedure Getdispensedate(): Text
    begin
        exit(DATE);
    end;
  

    // procedure getinputpassword(): code[20]
    // begin
    //     exit(Inputpaswword);
    // end;
}
