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
        if Result <> Value1 then
            Error('El resultado no es correcto');
    end;
}