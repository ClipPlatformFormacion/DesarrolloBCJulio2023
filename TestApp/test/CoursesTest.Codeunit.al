codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure Test001()
    var
        Min: Codeunit "CLIP Min";
        Value1, Value2 : Decimal;
        Result: Decimal;
    begin
        // [Escenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos (1 y 2)
        Value1 := 1;
        value2 := 2;

        // [When] llamada a la función GetMin
        Result := Min.GetMin(Value1, Value2);

        // [Then] el resultado es el esperado (1)
        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;

    [Test]
    procedure Test002()
    var
        Min: Codeunit "CLIP Min";
        LibraryAssert: Codeunit "Library Assert";
        Value1, Value2 : Decimal;
        Result: Decimal;
    begin
        // [Escenario] Una función llamada GetMin devuelve el mínimo de 2 valores numéricos

        // [Given] 2 valores numéricos (1 y 2)
        Value1 := 1;
        value2 := 2;

        // [When] llamada a la función GetMin
        Result := Min.GetMin(Value2, Value1);

        // [Then] el resultado es el esperado (1)
        LibraryAssert.AreEqual(value1, Result, 'El resultado no es correcto');
    end;

    [Test]
    procedure SelectingACourseOnASalesLine()
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
        LibraryCourse: Codeunit "CLIP Library - Course";
    begin
        // [Escenario] al seleccionar un curso en una línea de un documento de venta, el sistema rellena la información relacionada

        // [Given] Un curso y un documento de venta con una línea de venta
        LibraryCourse.CreateCourseNew(Course);

        LibrarySales.CreateSalesHeader(SalesHeader, Enum::"Sales Document Type"::Order, '');
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] se selecciona el curso en la línea
        SalesLine.Validate(Type, Enum::"Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] la línea tiene la Descripción, Precio y Grupos Contables correctos
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo contable producto no es correcto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo reg. IVA producto no es correcto');
    end;
}