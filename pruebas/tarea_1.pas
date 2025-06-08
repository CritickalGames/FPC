program tarea_1;
{$INCLUDE definiciones.pas}
procedure siguienteDigito(var num: Natural; var digito: integer);
var n: Natural;
begin
    n := num div 10 * 10;
    digito := num - n;
    num := num div 10;
end;

function esHistogramaDe(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9: integer; num: Natural): boolean;
var digi: integer; bandera : boolean;
begin
    bandera := true;
    writeln('-------------');
    writeln('c0:', c0);
    writeln('c1:', c1);
    writeln('c2:', c2);
    writeln('c3:', c3);
    writeln('c4:', c4);
    writeln('c5:', c5);
    writeln('c6:', c6);
    writeln('c7:', c7);
    writeln('c8:', c8);
    writeln('c9:', c9);
    writeln('-------------');
    writeln('num:', num);
    repeat 
        siguienteDigito(num, digi);
        case digi of
            0: begin c0:=c0-1; bandera := (c0 < 0);end;
            1: begin c1:=c1-1; bandera := (c1 < 0);end;
            2: begin c2:=c2-1; bandera := (c2 < 0);end;
            3: begin c3:=c3-1; bandera := (c3 < 0);end;
            4: begin c4:=c4-1; bandera := (c4 < 0);end;
            5: begin c5:=c5-1; bandera := (c5 < 0);end;
            6: begin c6:=c6-1; bandera := (c6 < 0);end;
            7: begin c7:=c7-1; bandera := (c7 < 0);end;
            8: begin c8:=c8-1; bandera := (c8 < 0);end;
            9: begin c9:=c9-1; bandera := (c9 < 0);end;
        end;
        writeln('num:', num, ' digi:',digi, ' bandera:', bandera);
    until ((num = 0) or bandera);
    writeln('-------------');
    writeln('c0:', c0);
    writeln('c1:', c1);
    writeln('c2:', c2);
    writeln('c3:', c3);
    writeln('c4:', c4);
    writeln('c5:', c5);
    writeln('c6:', c6);
    writeln('c7:', c7);
    writeln('c8:', c8);
    writeln('c9:', c9);
    writeln('-------------');
    if not bandera then
        esHistogramaDe := (c0 = 0) and (c1 = 0) and (c2 = 0) and (c3 = 0) and
                      (c4 = 0) and (c5 = 0) and (c6 = 0) and (c7 = 0) and
                      (c8 = 0) and (c9 = 0)
    else esHistogramaDe:= not bandera;
end;

function sonAnagramas(num1, num2: Natural): boolean;
var c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, digi: integer;
begin
    c0 := 0; c1 := 0; c2 := 0; c3 := 0; c4 := 0; c5 := 0; c6 := 0; c7 := 0; c8 := 0; c9 := 0;
    repeat 
        siguienteDigito(num1, digi);
        case digi of
            0: c0:=c0+1;
            1: c1:=c1+1;
            2: c2:=c2+1;
            3: c3:=c3+1;
            4: c4:=c4+1;
            5: c5:=c5+1;
            6: c6:=c6+1;
            7: c7:=c7+1;
            8: c8:=c8+1;
            9: c9:=c9+1;
        end;
    until (num1 = 0);
    sonAnagramas:=esHistogramaDe(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, num2)
end;
var num: Natural;
digito : integer;
begin
    writeln(sonAnagramas(21, 122));
end.