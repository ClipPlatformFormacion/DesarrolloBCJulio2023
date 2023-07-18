page 50103 "CLIP Course Editions"
{
    CaptionML = ENU = 'Course Editions', ESP = 'Ediciones curso';
    PageType = List;
    UsageCategory = None;
    SourceTable = "CLIP Course Edition";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field(Edition; Rec.Edition) { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("Max. Students"; Rec."Max. Students") { ApplicationArea = All; }
                field("Sales (Qty.)"; Rec."Sales (Qty.)") { ApplicationArea = All; }
            }
        }
    }
}