tableextension 50024 "Transfer Receipt Header" extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; "Receiver Name"; Text[100])
        {
            Caption = 'Receiver Name';
            DataClassification = CustomerContent;
        }
         field(50001; "Receiver Staff ID"; Code[20])
        {
            Caption = 'Receiver Staff ID';
            DataClassification = CustomerContent;
        }
    }
}
