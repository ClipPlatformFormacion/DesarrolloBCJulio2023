page 50104 "CLIP Course Editions Factbox"
{
    CaptionML = ENU = 'Editions', ESP = 'Ediciones';
    PageType = ListPart;
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
            }
        }
    }
}