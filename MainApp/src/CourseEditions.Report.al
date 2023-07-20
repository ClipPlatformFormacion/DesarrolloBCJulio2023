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

            trigger OnPreDataItem()
            begin
                Message('OnPreDataItem Contador:%1', Counter);
            end;

            trigger OnAfterGetRecord()
            begin
                Counter += 1;

                Course.Validate(Price, Course.Price + (Course.Price * Percentage / 100));
                Course.Modify(true);
            end;

            trigger OnPostDataItem()
            begin
                Message('Se han ejecutado %1 iteraciones', Counter);
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
                    field(Percentage; Percentage)
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

    var
        Counter: Integer;
        Percentage: Decimal;
}