page 50101 "Course Card"
{
    CaptionML = ENU = 'Couse Card', ESP = 'Ficha curso';
    PageType = Card;
    UsageCategory = None;
    SourceTable = Course;

    layout
    {
        area(Content)
        {
            group(Course)
            {
                CaptionML = ENU = 'Course', ESP = 'Curso';
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
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
}