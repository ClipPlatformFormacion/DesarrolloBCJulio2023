page 50105 "CLIP Course Ledger Entries"
{
    ApplicationArea = All;
    CaptionML = ENU = 'Course Ledger Entries', ESP = 'Movs. cursos';
    DataCaptionFields = "Course No.";
    Editable = false;
    PageType = List;
    SourceTable = "CLIP Course Ledger Entry";
    SourceTableView = SORTING("Course No.", "Posting Date")
                      ORDER(Descending);
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the date when the entry was posted.';
                }
                // field("Entry Type"; Rec."Entry Type")
                // {
                //     ApplicationArea = Jobs;
                //     ToolTip = 'Specifies the type of entry.';
                // }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the document number on the resource ledger entry.';
                }
                field("Course No."; Rec."Course No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the resource.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the description of the posted entry.';
                }
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                //     Visible = Dim1Visible;
                // }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                //     Visible = Dim2Visible;
                // }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of units of the item or resource specified on the line.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                    Visible = false;
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the total price of the posted entry.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                // field("Dimension Set ID"; Rec."Dimension Set ID")
                // {
                //     ApplicationArea = Dimensions;
                //     ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                //     Visible = false;
                // }
                // field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 3, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim3Visible;
                // }
                // field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 4, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim4Visible;
                // }
                // field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 5, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim5Visible;
                // }
                // field("Shortcut Dimension 6 Code"; Rec."Shortcut Dimension 6 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 6, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim6Visible;
                // }
                // field("Shortcut Dimension 7 Code"; Rec."Shortcut Dimension 7 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 7, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim7Visible;
                // }
                // field("Shortcut Dimension 8 Code"; Rec."Shortcut Dimension 8 Code")
                // {
                //     ApplicationArea = Dimensions;
                //     Editable = false;
                //     ToolTip = 'Specifies the code for Shortcut Dimension 8, which is one of dimension codes that you set up in the General Ledger Setup window.';
                //     Visible = Dim8Visible;
                // }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                // action(Dimensions)
                // {
                //     AccessByPermission = TableData Dimension = R;
                //     ApplicationArea = Dimensions;
                //     Caption = 'Dimensions';
                //     Image = Dimensions;
                //     ShortCutKey = 'Alt+D';
                //     ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                //     trigger OnAction()
                //     begin
                //         ShowDimensions();
                //     end;
                // }
                // action(SetDimensionFilter)
                // {
                //     ApplicationArea = Dimensions;
                //     Caption = 'Set Dimension Filter';
                //     Ellipsis = true;
                //     Image = "Filter";
                //     ToolTip = 'Limit the entries according to the dimension filters that you specify. NOTE: If you use a high number of dimension combinations, this function may not work and can result in a message that the SQL server only supports a maximum of 2100 parameters.';

                //     trigger OnAction()
                //     begin
                //         SetFilter("Dimension Set ID", DimensionSetIDFilter.LookupFilter);
                //     end;
                // }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                ApplicationArea = Jobs;
                Caption = 'Find entries...';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+Alt+Q';
                ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                trigger OnAction()
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.Run();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetDimVisibility();

        if (Rec.GetFilters() <> '') and not Rec.Find() then
            if Rec.FindFirst() then;
    end;

    var
        Navigate: Page Navigate;
    // DimensionSetIDFilter: Page "Dimension Set ID Filter";

    protected var
        Dim1Visible: Boolean;
        Dim2Visible: Boolean;
        Dim3Visible: Boolean;
        Dim4Visible: Boolean;
        Dim5Visible: Boolean;
        Dim6Visible: Boolean;
        Dim7Visible: Boolean;
        Dim8Visible: Boolean;

    local procedure SetDimVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
    end;
}

