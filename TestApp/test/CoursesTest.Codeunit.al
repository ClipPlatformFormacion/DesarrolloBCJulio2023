codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    begin

    end;

    [Test]
    procedure Test002()
    begin
        Error('Un error durante la ejecución');
    end;
}