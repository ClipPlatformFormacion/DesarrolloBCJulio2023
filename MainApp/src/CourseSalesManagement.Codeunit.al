codeunit 50100 "CLIP Course - Sales Management"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterAssignFieldsForNo', '', false, false)]
    local procedure CopyFromCourse(var SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header")
    var
        Course: Record "CLIP Course";
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;

        Course.Get(SalesLine."No.");

        Course.TestField("Gen. Prod. Posting Group");
        SalesLine.Description := Course.Name;
        SalesLine."Unit Price" := Course.Price;
        SalesLine."Gen. Prod. Posting Group" := Course."Gen. Prod. Posting Group";
        SalesLine."VAT Prod. Posting Group" := Course."VAT Prod. Posting Group";
        SalesLine."Allow Item Charge Assignment" := false;
        OnAfterAssignCourseValues(SalesLine, Course, SalesHeader);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterAssignCourseValues(var SalesLine: Record "Sales Line"; Course: Record "CLIP Course"; SalesHeader: Record "Sales Header")
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Option Lookup Buffer", 'OnBeforeIncludeOption', '', false, false)]
    local procedure OnBeforeIncludeOption(OptionLookupBuffer: Record "Option Lookup Buffer" temporary; LookupType: Option; Option: Integer; var Handled: Boolean; var Result: Boolean; RecRef: RecordRef);
    begin
        if LookupType <> Enum::"Option Lookup Type"::Sales.AsInteger() then
            exit;

        if Option <> Enum::"Sales Line Type"::"CLIP Course".AsInteger() then
            exit;

        Result := true;
        Handled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforePostSalesLine', '', false, false)]
    local procedure OnPostSalesLineOnBeforePostSalesLine(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; GenJnlLineDocType: Enum "Gen. Journal Document Type"; SrcCode: Code[10]; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; var IsHandled: Boolean);
    begin
        PostCourseJournalLine(SalesHeader, SalesLine, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode);
    end;

    local procedure PostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; GenJnlLineDocNo: Code[20]; GenJnlLineExtDocNo: Code[35]; SrcCode: Code[10])
    var
        CourseJournalLine: Record "CLIP Course Journal Line";
        CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforePostCourseJournalLine(SalesHeader, SalesLine, IsHandled, GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, CourseJournalPostLine);
        if IsHandled then
            exit;

        if SalesLine."Qty. to Invoice" = 0 then
            exit;


        CourseJournalLine.Init();
        CourseJournalLine.CopyFromSalesHeader(SalesHeader);
        CourseJournalLine.CopyDocumentFields(GenJnlLineDocNo, GenJnlLineExtDocNo, SrcCode, SalesHeader."Posting No. Series");
        CourseJournalLine.CopyFromSalesLine(SalesLine);
        OnPostCourseJournalLineOnAfterInit(CourseJournalLine, SalesLine);

        CourseJournalPostLine.RunWithCheck(CourseJournalLine);

        OnAfterPostCourseJournalLine(SalesHeader, SalesLine, CourseJournalLine);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostCourseJournalLine(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var IsHandled: Boolean; DocNo: Code[20]; ExtDocNo: Code[35]; SourceCode: Code[10]; var CourseJournalPostLine: Codeunit "CLIP Course Journal-Post Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostCourseJournalLineOnAfterInit(var CourseJournalLine: Record "CLIP Course Journal Line"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterPostCourseJournalLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateEvent_SalesLine_Quantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        CheckCourseEditionSales(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'CLIP Course Edition', false, false)]
    local procedure OnAfterValidateEvent_SalesLine_CourseEdition(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    begin
        CheckCourseEditionSales(Rec);
    end;

    local procedure CheckCourseEditionSales(var SalesLine: Record "Sales Line")
    var
        CourseEdition: Record "CLIP Course Edition";
        MaxStudentsExceededMsg: TextConst ENU = 'The max. number of students for course %4 and edition %2 is %3. Previous sales are %1 students',
                                        ESP = 'El número máximo de alumnos para el curso %4 edición %2 es %3. Las ventas previas son de %1 alumnos';
    begin
        if SalesLine.Type <> SalesLine.Type::"CLIP Course" then
            exit;
        if (SalesLine."CLIP Course Edition" = '') or (SalesLine.Quantity = 0) then
            exit;

        CourseEdition.Get(SalesLine."No.", SalesLine."CLIP Course Edition");
        CourseEdition.CalcFields("Sales (Qty.)");
        if (CourseEdition."Sales (Qty.)" + SalesLine.Quantity) > CourseEdition."Max. Students" then
            Message(MaxStudentsExceededMsg, CourseEdition."Sales (Qty.)", SalesLine."CLIP Course Edition", CourseEdition."Max. Students", SalesLine."No.");
    end;
}