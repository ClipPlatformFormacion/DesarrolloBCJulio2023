table 50102 "CLIP Course Edition"
{
    CaptionML = ENU = 'Course Edition', ESP = 'Edición curso';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Course No."; Code[20])
        {
            CaptionML = ENU = 'Course No.', ESP = 'Nº curso';
            TableRelation = "CLIP Course";
        }
        field(2; Edition; Code[20])
        {
            CaptionML = ENU = 'Edition', ESP = 'Edición';
        }
        field(3; "Start Date"; Date)
        {
            CaptionML = ENU = 'Start Date', ESP = 'Fecha inicio';
        }
        field(4; "Max. Students"; Integer)
        {
            CaptionML = ENU = 'Max. Students', ESP = 'Nº máx. alumnos';
        }
#pragma warning disable AA0232
        field(5; "Sales (Qty.)"; Decimal)
        {
            CaptionML = ENU = 'Sales (Qty.)', ESP = 'Ventas (cdad.)';
            FieldClass = FlowField;
            CalcFormula = sum("CLIP Course Ledger Entry".Quantity where("Course No." = field("Course No."), "Course Edition" = field(Edition)));
            Editable = false;
            DecimalPlaces = 0 : 2;
            BlankZero = true;
        }
#pragma warning restore
    }

    keys
    {
        key(PK; "Course No.", Edition)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Edition, "Start Date", "Max. Students") { }
    }
}