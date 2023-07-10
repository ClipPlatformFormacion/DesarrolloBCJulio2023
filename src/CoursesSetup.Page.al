page 50102 "CLIP Courses Setup"
{
    AccessByPermission = TableData "CLIP Course" = R;
    ApplicationArea = All;
    CaptionML = ENU = 'Courses Setup', ESP = 'Config. cursos';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "CLIP Courses Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Numbering)
            {
                CaptionML = ENU = 'Numbering', ESP = 'Numeración';
                field("Course Nos."; Rec."Course Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number series code you can use to assign numbers to Courses.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

