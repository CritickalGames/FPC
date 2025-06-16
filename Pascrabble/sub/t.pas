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
