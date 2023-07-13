codeunit 50141 "CLIP Min"
{
    // procedure GetMin(v1: Decimal; v2: Decimal): Decimal
    // begin
    //     if v1 <= v2 then
    //         exit(v1)
    //     else
    //         exit(v2);
    // end;

    // procedure GetMin(v1: Decimal; v2: Decimal): Decimal
    // begin
    //     if v1 <= v2 then
    //         exit(v1);
    //     exit(v2);
    // end;

    procedure GetMin(v1: Decimal; v2: Decimal) Result: Decimal
    begin
        Result := v1;
        if v2 < v1 then
            Result := v2;
    end;
}