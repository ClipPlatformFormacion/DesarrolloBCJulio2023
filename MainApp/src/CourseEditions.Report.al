report 50100 "CLIP Course Editions"
{
    CaptionML = ENU = 'Course edition list', ESP = 'Listado ediciones curso';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    // DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Course; "CLIP Course")
        {
            RequestFilterFields = "No.", Type;
            // column(ColumnName; SourceFieldName)
            // {
            // }
            dataitem(CourseEdition; "CLIP Course Edition")
            {
                DataItemLinkReference = Course;
                DataItemLink = "Course No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    EditionCounter += 1;
                end;
            }

            trigger OnPreDataItem()
            begin
                Dialog.Open(CourseProcessingMsg);
                Dialog.Update(2, Course.Count());
            end;

            trigger OnAfterGetRecord()
            begin
                CourseCounter += 1;
                Dialog.Update(1, CourseCounter);

                Course.Validate(Price, Course.Price + (Course.Price * Percentage / 100));
                Course.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Dialog.Close();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    CaptionML = ENU = 'Options', ESP = 'Opciones';
                    field(PercentageControl; Percentage)
                    {
                        CaptionML = ENU = 'Percentage', ESP = 'Porcentaje';
                        ToolTipML = ESP = 'Indique aquí el % en el que desee incrementar el precio de los cursos';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }
    trigger OnPostReport()
    begin
        Message('Cursos: %1   Ediciones: %2', CourseCounter, EditionCounter);
    end;

    var
        CourseCounter: Integer;
        EditionCounter: Integer;
        Percentage: Decimal;
        Dialog: Dialog;
        CourseProcessingMsg: TextConst ENU = 'Processing courses  #1##########',
                                        ESP = 'Procesando cursos  #1########## de #2##########';
}