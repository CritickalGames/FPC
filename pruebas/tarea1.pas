procedure siguienteDigito(var num: Natural; var digito: integer);
var n: Natural;
begin
    n := num div 10 * 10;{quitamos el último digito (111->110)}
    digito := num - n; {Conseguimos el último digito (111-110=1)}
    num := num div 10; {Corremos la coma un espacio (111->11)}
end;

function esHistogramaDe(c0, c1, c2, c3, c4, c5, c6, c7, c8, c9: integer; num: Natural): boolean;
var digi: integer; bandera : boolean;
begin
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
    until ((num = 0) or bandera);
    bandera:= not bandera; {Para mayor legibilidad}
    if bandera then
        {Comparo si todos los Cx son iguales a 0}
        esHistogramaDe := (c0 = 0) and (c1 = 0) and (c2 = 0) and (c3 = 0) and
                      (c4 = 0) and (c5 = 0) and (c6 = 0) and (c7 = 0) and
                      (c8 = 0) and (c9 = 0)
    else esHistogramaDe:= bandera;
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