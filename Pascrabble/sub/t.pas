procedure initPalabra(s: array of char ; var p: Palabra);
    var
        i: integer;
begin
    {recorrer s hasta que s[i] sea nulo}
    for i in [0..length(s)-1]do
    begin
        p.cadena[i+1] := s[i]; {asignar la letra a la palabra}
    end;
    {asignar el tope de la palabra}
    p.tope := length(s); {asignar el tope de la palabra}
end;
procedure iniciarOracion(var ora : array of Texto);
    { Inicializa la oración `ora` con 10 nodos, cada uno apuntando al siguiente.
    { Inicializa la oración a nil. }
    var 
        i : integer;
begin
    {inicializar ora; ora[1]^.sig := ora[2];}
    i := 1;
    {inicializar el primer nodo de ora}
    new(ora[0]);
    for i in [1..9] do
    begin
        new(ora[i]);
        ora[i - 1]^.sig := ora[i];        
    end;
    ora[9]^.sig := nil; {el último nodo apunta a nil}
end;
procedure newTexto(var tex : Texto; t: array of char);
begin
    new(tex); {crear un nuevo nodo}
    { Inicializa el texto `tex` con una palabra formada por los caracteres de `t`. }
    initPalabra(t, tex^.info);
    tex^.sig := nil; {inicializa el siguiente nodo a nil}    
end;
procedure addTexto(var tex : Texto; t: array of char);
    var
        nuevo : Texto;
        puntero: texto;
begin
    newTexto(nuevo, t); {inicializar el nuevo nodo con la palabra t}
    {encontrar el último nodo de la lista}
    puntero := tex;
    while puntero^.sig <> nil do
        puntero := puntero^.sig; {avanzar al siguiente nodo}
    puntero^.sig := nuevo; {agregar el nuevo nodo al final de la lista}
end;
function crearDiccionario():Texto;
   var
      dicc: Texto;
begin
   {crear un diccionario de palabras con newTexto(var tex : Texto; t: array of char) y addTexto(var tex : Texto; t: array of char)}
   newTexto(dicc, ['h', 'o', 'l', 'a']);
   addTexto(dicc, ['m', 'u', 'n', 'd', 'o']);
   addTexto(dicc, ['p', 'a', 's', 'c', 'r', 'a', 'b', 'l', 'e']);
   addTexto(dicc, ['p', 'r', 'o', 'g', 'r', 'a', 'm', 'a', 'd', 'o']);
   addTexto(dicc, ['t', 'e', 's', 't']);
   addTexto(dicc, ['e', 'j', 'e', 'm', 'p', 'l', 'o']);
   addTexto(dicc, ['d', 'i', 'c', 'c', 'i', 'o', 'n', 'a', 'r', 'i', 'o']);
   addTexto(dicc, ['p', 'a', 'l', 'a', 'b', 'r', 'a']);
   {palabra mesa, amores, robots}
   addTexto(dicc, ['m', 'e', 's', 'a']);
   addTexto(dicc, ['a', 'm', 'o', 'r', 'e','s']);
   addTexto(dicc, ['r', 'o', 'b', 'o', 't','s']);
   crearDiccionario := dicc; {inicializar el diccionario a nil}
end;
// ------
procedure leerPosicionX(var pos : Posicion; cf: char; cc: integer; caux: char);
{ Lee la posición}
begin
    pos.fila := cf;
    pos.col := cc;
    if caux = 'H' then
        pos.direccion := Horizontal
    else if caux = 'V' then
        pos.direccion := Vertical;
end;
procedure rellenarAtrilX(var mano : Atril; num: integer; arrL: array of char);
{ Permite ingresar letras en el atril }
{ Se asume que el atril está vacío y se ingresan las letras sin espacios }
{ El usuario debe ingresar la cantidad de letras y luego las letras }
var i : integer;
begin
    writeln('Ingrese la cantidad de letras en el atril:');
    // readln(num);
    mano.tope := num;
    writeln('Ingrese las letras del atril (sin espacios):');
    for i := 1 to num do
    begin
        // read(l);
        mano.letras[i] := arrL[i-1];
    end;
end;

procedure ingresarPalabraX(var p : Palabra; var pos : Posicion; input: array of char; cf: char; cc: integer; caux: char);
{ Ingresa una palabra indicando su posición (coordenadas y dirección) }
begin
   writeln('Ingrese la palabra:');
   initPalabra(input, p);
   readln;
   leerPosicionX(pos, cf, cc, caux);
   writeln;
end;