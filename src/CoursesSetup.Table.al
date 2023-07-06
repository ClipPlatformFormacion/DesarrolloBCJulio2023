table 50101 "Courses Setup"
{
    CaptionML = ENU = 'Courses Setup', ESP = 'Config. cursos';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key', ESP = 'Clave primaria';
        }
        field(2; "Course Nos."; Code[20])
        {
            CaptionML = ENU = 'Course Nos.', ESP = 'Nº cursos';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}

