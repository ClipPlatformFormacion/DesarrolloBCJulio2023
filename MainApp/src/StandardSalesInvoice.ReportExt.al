reportextension 50100 "CLIP Standard Sales - Invoice" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            column(CLIP_Course_Edition; "CLIP Course Edition") { IncludeCaption = true; }
        }
    }

    requestpage
    {
        layout
        {

        }
    }

    rendering
    {
        layout("CLIP RDLLayout")
        {
            Type = RDLC;
            LayoutFile = 'src/StandardSalesInvoice.rdl';
        }
    }
}