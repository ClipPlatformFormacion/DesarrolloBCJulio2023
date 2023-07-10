table 50101 "CLIP Courses Setup"
{
    CaptionML = ENU = 'Courses Setup', ESP = 'Config. cursos';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key', ESP = 'Clave primaria';
            DataClassification = SystemMetadata;
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

