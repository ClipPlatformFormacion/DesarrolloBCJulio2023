table 50100 Course
{
    fields
    {
        field(1; "No."; Code[20]) { }
        field(2; Name; Text[100]) { }
        field(3; "Content Description"; Text[2048]) { }
        field(4; "Duration (hours)"; Integer) { }
        field(5; Price; Decimal)
        {
            DecimalPlaces = 3 : 3;
        }
        field(6; Type; Enum "Course Type") { }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}