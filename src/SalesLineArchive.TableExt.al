tableextension 50106 "CLIP Sales Line Archive" extends "Sales Line Archive"
{
    fields
    {
        modify("No.")
        {
            TableRelation = if (Type = const("CLIP Course")) "CLIP Course";
        }
        field(50100; "CLIP Course Edition"; Code[20])
        {
            CaptionML = ENU = 'Course Edition', ESP = 'Edición curso';
            DataClassification = CustomerContent;
            TableRelation = "CLIP Course Edition".Edition where("Course No." = field("No."));
        }
    }
}