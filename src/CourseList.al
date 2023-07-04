page 50100 "Course List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Course;

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Content Description"; Rec."Content Description") { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
            }
        }
    }
}