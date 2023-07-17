table 50103 "CLIP Course Ledger Entry"
{
    CaptionML = ENU = 'Course Ledger Entry', ESP = 'Mov. curso';
    // DrillDownPageID = "CLIP Course Ledger Entries";
    // LookupPageID = "CLIP Course Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        // field(2; "Entry Type"; Enum "Res. Journal Line Entry Type")
        // {
        //     Caption = 'Entry Type';
        // }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5; "Course No."; Code[20])
        {
            Caption = 'Course No.';
            TableRelation = "CLIP Course";
        }
        field(6; "Course Edition"; Code[20])
        {
            CaptionML = ENU = 'Course Edition', ESP = 'Edición curso';
            TableRelation = "CLIP Course Edition".Edition;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(11; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
        }
        field(16; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
        }
        // field(17; "Global Dimension 1 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,1';
        //     Caption = 'Global Dimension 1 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        // }
        // field(18; "Global Dimension 2 Code"; Code[20])
        // {
        //     CaptionClass = '1,1,2';
        //     Caption = 'Global Dimension 2 Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        // }
        field(27; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(28; "External Document No."; Code[35])
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
        // }
        // field(481; "Shortcut Dimension 3 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,3';
        //     Caption = 'Shortcut Dimension 3 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(3)));
        // }
        // field(482; "Shortcut Dimension 4 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,4';
        //     Caption = 'Shortcut Dimension 4 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(4)));
        // }
        // field(483; "Shortcut Dimension 5 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,5';
        //     Caption = 'Shortcut Dimension 5 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(5)));
        // }
        // field(484; "Shortcut Dimension 6 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,6';
        //     Caption = 'Shortcut Dimension 6 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(6)));
        // }
        // field(485; "Shortcut Dimension 7 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,7';
        //     Caption = 'Shortcut Dimension 7 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(7)));
        // }
        // field(486; "Shortcut Dimension 8 Code"; Code[20])
        // {
        //     CaptionClass = '1,2,8';
        //     Caption = 'Shortcut Dimension 8 Code';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
        //                                                                             "Global Dimension No." = const(8)));
        // }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Course No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Document No.", "Posting Date")
        {
        }
    }

    // var
    //     DimensionManagement: Codeunit DimensionManagement;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(Rec, FieldNo("Entry No.")))
    end;

    // procedure CopyFromCourseJournalLine(CourseJournalLine: Record "CLIP Course Journal Line")
    // begin
    //     // "Entry Type" := ResJnlLine."Entry Type";
    //     "Document No." := CourseJournalLine."Document No.";
    //     "External Document No." := CourseJournalLine."External Document No.";
    //     "Posting Date" := CourseJournalLine."Posting Date";
    //     "Document Date" := CourseJournalLine."Document Date";
    //     "Course No." := CourseJournalLine."Course No.";
    //     Description := CourseJournalLine.Description;
    //     Quantity := CourseJournalLine.Quantity;
    //     "Unit Price" := CourseJournalLine."Unit Price";
    //     "Total Price" := CourseJournalLine."Total Price";
    //     // "Global Dimension 1 Code" := ResJnlLine."Shortcut Dimension 1 Code";
    //     // "Global Dimension 2 Code" := ResJnlLine."Shortcut Dimension 2 Code";
    //     // "Dimension Set ID" := ResJnlLine."Dimension Set ID";

    //     OnAfterCopyFromCourseJournalLine(Rec, CourseJournalLine);
    // end;

    procedure ShowDimensions()
    begin
        // DimensionManagement.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "Entry No."));
    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterCopyFromCourseJournalLine(var CourseLedgerEntry: Record "CLIP Course Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
    end;
}

