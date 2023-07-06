page 50100 "CLIP Course List"
{
    CaptionML = ENU = 'Courses', ESP = 'Cursos';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Editable = false;
    CardPageId = "CLIP Course Card";

    layout
    {
        area(Content)
        {
            repeater(RepeaterControl)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
                field(Type; Rec.Type) { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            part(CourseEditionsFactbox; "CLIP Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(CourseEditions)
            {
                CaptionML = ENU = 'Editions', ESP = 'Ediciones';
                ApplicationArea = All;
                RunObject = page "CLIP Course Editions";
                RunPageLink = "Course No." = field("No.");
            }
        }
    }
}