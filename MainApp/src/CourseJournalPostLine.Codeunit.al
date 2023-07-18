codeunit 50101 "CLIP Course Journal-Post Line"
{
    Permissions = TableData "CLIP Course Ledger Entry" = imd;
    TableNo = "CLIP Course Journal Line";

    trigger OnRun()
    begin
        GetGLSetup();
        RunWithCheck(Rec);
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        CourseJournalLine: Record "CLIP Course Journal Line";
        CourseLedgerEntry: Record "CLIP Course Ledger Entry";
        NextEntryNo: Integer;
        GLSetupRead: Boolean;

    procedure RunWithCheck(var CourseJournalLine2: Record "CLIP Course Journal Line")
    begin
        CourseJournalLine.Copy(CourseJournalLine2);
        Code();
        CourseJournalLine2 := CourseJournalLine;
    end;

    local procedure "Code"()
    begin
        OnBeforePostCourseJournalLine(CourseJournalLine);

        if CourseJournalLine.EmptyLine() then
            exit;

        CourseJournalLine.TestField("Course No.", ErrorInfo.Create());
        CourseJournalLine.TestField("Posting Date", ErrorInfo.Create());

        CheckPostingDate(CourseJournalLine);

        if NextEntryNo = 0 then begin
            CourseLedgerEntry.LockTable();
            NextEntryNo := CourseLedgerEntry.GetLastEntryNo() + 1;
        end;

        if CourseJournalLine."Document Date" = 0D then
            CourseJournalLine."Document Date" := CourseJournalLine."Posting Date";

        CourseLedgerEntry.Init();
        CourseLedgerEntry.CopyFromCourseJournalLine(CourseJournalLine);

        GetGLSetup();
        CourseLedgerEntry."Total Price" := Round(CourseLedgerEntry."Total Price");
        CourseLedgerEntry."Entry No." := NextEntryNo;

        OnBeforeCourseLedgerEntryInsert(CourseLedgerEntry, CourseJournalLine);

        CourseLedgerEntry.Insert(true);

        NextEntryNo := NextEntryNo + 1;

        OnAfterPostCourseJournalLine(CourseJournalLine, CourseLedgerEntry);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line"; var CourseLedgerEntry: Record "CLIP Course Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;



    [IntegrationEvent(false, false)]
    local procedure OnBeforeCourseLedgerEntryInsert(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    local procedure CheckPostingDate(CourseJournalLine2: Record "CLIP Course Journal Line")
    var
        UserSetupManagement: Codeunit "User Setup Management";
        IsHandled: Boolean;
        Text000Err: Label 'cannot be a closing date';
    begin
        if CourseJournalLine2."Posting Date" <> NormalDate(CourseJournalLine2."Posting Date") then
            CourseJournalLine2.FieldError("Posting Date", ErrorInfo.Create(Text000Err, true));

        IsHandled := false;
        OnCheckPostingDateOnBeforeCheckAllowedPostingDate(CourseJournalLine2."Posting Date", IsHandled);
        if IsHandled then
            exit;

        UserSetupManagement.CheckAllowedPostingDate(CourseJournalLine2."Posting Date");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCheckPostingDateOnBeforeCheckAllowedPostingDate(PostingDate: Date; var IsHandled: Boolean);
    begin
    end;
}

