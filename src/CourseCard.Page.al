page 50101 "CLIP Course Card"
{
    CaptionML = ENU = 'Couse Card', ESP = 'Ficha curso';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "CLIP Course";

    layout
    {
        area(Content)
        {
            group(Course)
            {
                CaptionML = ENU = 'Course', ESP = 'Curso';
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTipML = ENU = 'Specifies the title of the course. This is the name that will be shown in sales documents when the course is sold', ESP = 'Especifica el título del curso. Este nombre es el que aparecerá en los documentos de venta cuando se venda el curso';
                }
            }
            part(CourseEditionsFactbox; "CLIP Course Editions Factbox")
            {
                SubPageLink = "Course No." = field("No.");
                ApplicationArea = All;
            }

            group(TrainingDetails)
            {
                CaptionML = ENU = 'Training Details', ESP = 'Detalles formativos';
                field(Type; Rec.Type) { ApplicationArea = All; }
                field("Duration (hours)"; Rec."Duration (hours)") { ApplicationArea = All; }
                field("Content Description"; Rec."Content Description") { ApplicationArea = All; }
            }
            group(Invoicing)
            {
                CaptionML = ENU = 'Invoicing', ESP = 'Facturación';
                field(Price; Rec.Price) { ApplicationArea = All; }
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
        }
    }
}