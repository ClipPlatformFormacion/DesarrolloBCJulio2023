pageextension 50100 "CLIP Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        moveafter(Description; "Item Reference No.")
        movefirst(Control1; "Reserved Quantity")
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }

        addafter("No.")
        {
            field("CLIP Course Edition"; Rec."CLIP Course Edition")
            {
                ApplicationArea = All;
            }
            field("CLIP Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}