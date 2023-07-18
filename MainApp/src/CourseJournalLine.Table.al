table 50104 "CLIP Course Journal Line"
{
    CaptionML = ENU = 'Course Journal Line', ESP = 'Lín. diario curso';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            // TableRelation = "Res. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        // field(3; "Entry Type"; Enum "Res. Journal Line Entry Type")
        // {
        //     Caption = 'Entry Type';
        // }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';

            trigger OnValidate()
            begin
                TestField("Posting Date");
                Validate("Document Date", "Posting Date");
            end;
        }
        field(6; "Course No."; Code[20])
        {
            Caption = 'Course No.';
            TableRelation = "CLIP Course";

            trigger OnValidate()
            begin
                Course.Get("Course No.");
                Description := Course.Name;
                "Unit Price" := Course.Price;
            end;
        }
        field(7; "Course Edition"; Code[20])
        {
            CaptionML = ENU = 'Course Edition', ESP = 'Edición curso';
            TableRelation = "CLIP Course Edition".Edition;
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(16; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(17; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Price" := Round("Total Price" / Quantity, GeneralLedgerSetup."Unit-Amount Rounding Precision");
            end;
        }
        // field(18; "Shortcut Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,1';
        //     Caption = 'Shortcut Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
        //                                                   Blocked = CONST(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        //     end;
        // }
        // field(19; "Shortcut Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,2';
        //     Caption = 'Shortcut Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
        //                                                   Blocked = CONST(false));

        //     trigger OnValidate()
        //     begin
        //         ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
        //     end;
        // }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            // TableRelation = "Res. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        // field(25; "Recurring Method"; Option)
        // {
        //     BlankZero = true;
        //     Caption = 'Recurring Method';
        //     OptionCaption = ',Fixed,Variable';
        //     OptionMembers = ,"Fixed",Variable;
        // }
        // field(26; "Expiration Date"; Date)
        // {
        //     Caption = 'Expiration Date';
        // }
        // field(27; "Recurring Frequency"; DateFormula)
        // {
        //     Caption = 'Recurring Frequency';
        // }

        field(30; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(31; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }
        // field(480; "Dimension Set ID"; Integer)
        // {
        //     Caption = 'Dimension Set ID';
        //     Editable = false;
        //     TableRelation = "Dimension Set Entry";

        //     trigger OnLookup()
        //     begin
        //         ShowDimensions();
        //     end;

        //     trigger OnValidate()
        //     begin
        //         DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //     end;
        // }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        LockTable();
        // ResJnlTemplate.Get("Journal Template Name");
        // ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");

        // ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
        // ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
    end;

    var
        // ResJnlTemplate: Record "Res. Journal Template";
        // ResJnlBatch: Record "Res. Journal Batch";
        Course: Record "CLIP Course";
        GeneralLedgerSetup: Record "General Ledger Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        // DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;

    procedure EmptyLine(): Boolean
    begin
        exit(("Course No." = '') and (Quantity = 0));
    end;

    // procedure SetUpNewLine(LastResJnlLine: Record "CLIP Course Journal Line")
    // begin
    //     ResJnlTemplate.Get("Journal Template Name");
    //     ResJnlBatch.Get("Journal Template Name", "Journal Batch Name");
    //     ResJnlLine.SetRange("Journal Template Name", "Journal Template Name");
    //     ResJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
    //     if ResJnlLine.FindFirst() then begin
    //         "Posting Date" := LastResJnlLine."Posting Date";
    //         "Document Date" := LastResJnlLine."Posting Date";
    //         "Document No." := LastResJnlLine."Document No.";
    //     end else begin
    //         "Posting Date" := WorkDate;
    //         "Document Date" := WorkDate;
    //         if ResJnlBatch."No. Series" <> '' then begin
    //             Clear(NoSeriesMgt);
    //             "Document No." := NoSeriesMgt.TryGetNextNo(ResJnlBatch."No. Series", "Posting Date");
    //         end;
    //     end;
    //     "Recurring Method" := LastResJnlLine."Recurring Method";
    //     "Source Code" := ResJnlTemplate."Source Code";
    //     "Reason Code" := ResJnlBatch."Reason Code";
    //     "Posting No. Series" := ResJnlBatch."Posting No. Series";

    //     OnAfterSetUpNewLine(Rec, LastResJnlLine);
    // end;

    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     OnBeforeValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);

    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

    //     OnAfterValidateShortcutDimCode(Rec, xRec, FieldNumber, ShortcutDimCode);
    // end;

    // procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // begin
    //     DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    //     DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    // end;

    // procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    // begin
    //     DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    // end;

    procedure CopyDocumentFields(DocNo: Code[20]; ExtDocNo: Text[35]; SourceCode: Code[10]; NoSeriesCode: Code[20])
    begin
        Rec."Document No." := DocNo;
        Rec."External Document No." := ExtDocNo;
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header")
    begin
        Rec."Posting Date" := SalesHeader."Posting Date";
        Rec."Document Date" := SalesHeader."Document Date";

        OnAfterCopyCourseJournalLineFromSalesHeader(SalesHeader, Rec);
    end;

    procedure CopyFromSalesLine(SalesLine: Record "Sales Line")
    begin
        Rec."Course No." := SalesLine."No.";
        Rec."Course Edition" := SalesLine."CLIP Course Edition";
        Rec.Description := SalesLine.Description;
        // Rec."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
        // Rec."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
        // Rec."Dimension Set ID" := SalesLine."Dimension Set ID";
        // Rec."Entry Type" := "Entry Type"::Sale;
        Rec.Quantity := -SalesLine."Qty. to Invoice";
        Rec."Unit Price" := SalesLine."Unit Price";
        Rec."Total Price" := -SalesLine.Amount;

        OnAfterCopyCourseJournalLineFromSalesLine(SalesLine, Rec);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    // procedure ShowDimensions()
    // begin
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Journal Template Name", "Journal Batch Name", "Line No."));
    //     DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");

    //     OnAfterShowDimensions(Rec);
    // end;

    // procedure IsOpenedFromBatch(): Boolean
    // var
    //     ResJournalBatch: Record "Res. Journal Batch";
    //     TemplateFilter: Text;
    //     BatchFilter: Text;
    // begin
    //     BatchFilter := GetFilter("Journal Batch Name");
    //     if BatchFilter <> '' then begin
    //         TemplateFilter := GetFilter("Journal Template Name");
    //         if TemplateFilter <> '' then
    //             ResJournalBatch.SetFilter("Journal Template Name", TemplateFilter);
    //         ResJournalBatch.SetFilter(Name, BatchFilter);
    //         ResJournalBatch.FindFirst();
    //     end;

    //     exit((("Journal Batch Name" <> '') and ("Journal Template Name" = '')) or (BatchFilter <> ''));
    // end;



    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesHeader(var SalesHeader: Record "Sales Header"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesLine(var SalesLine: Record "Sales Line"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;
}

