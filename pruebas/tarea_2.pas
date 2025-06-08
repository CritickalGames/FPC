program tarea_1;
{$INCLUDE definiciones.pas}
procedure siguienteDigito(var num: Natural; var digito: integer);
var n: Natural;
begin
    n := num div 10 * 10;
    digito := num - n;
    num := num div 10;
end;
var num: Natural;
digito: integer;
begin
    readln(num);
    siguienteDigito(num, digito);
    writeln('Número: ', num, ' Dígito: ', digito);
end.