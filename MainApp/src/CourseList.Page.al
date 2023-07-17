page 50100 "CLIP Course List"
{
    // CaptionML = ENU = 'Courses', ESP = 'Cursos';
    Caption = 'Courses';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CLIP Course";
    Editable = false;
    CardPageId = "CLIP Course Card";
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Course', ESP = 'Nuevo,Proceso,Informes,Curso';

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
                ApplicationArea = All;
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
                Image = ShowList;
                RunObject = page "CLIP Course Editions";
                RunPageLink = "Course No." = field("No.");
            }
            action("Ledger E&ntries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = ResourceLedger;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "CLIP Course Ledger Entries";
                RunPageLink = "Course No." = FIELD("No.");
                RunPageView = SORTING("Course No.")
                                  ORDER(Descending);
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'View the history of transactions that have been posted for the selected record.';
            }
        }
    }
}