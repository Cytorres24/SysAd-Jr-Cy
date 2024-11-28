page 50004 Login

  {
    PageType = ConfirmationDialog;
    Editable = true;
    Caption = 'Pharmacist on duty';
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(PharmacistonDuty)
            {
                Caption = 'Enter Pharmacist On Duty';
                field("Staff ID"; InputNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter a numeric value.';
                }
                field(Password; InputPassword)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter a Password';
                }
            }
        }
    }

    actions
    {
        
    }

    var
        InputNumber: Code[20];
        InputPassword: Text[200];

    procedure GetInputNumber(): Code[20]
    begin
        exit(InputNumber);
    end;

    procedure GetInputPassword(): Text[200]
    begin
        exit(InputPassword);
    end;
}
