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
procedure inicializarHistograma(var hist : Histograma);
    { Inicializa el histograma a cero. }
    var 
        c : Letra;
begin
        {recorrer cada letra de [a..z] y contar las ocurrencias de cada letra en `pal`}
        for c in ['a'..'z'] do
        begin
            {comprueba si la letra vale menos que 1 inicializa en 0}
            if hist[c] < 1 then
                hist[c] := 0; {inicializar el contador de cada letra a 0}        
        end;
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

{
type

   Letra        = 'a' .. 'z';
   Palabra	= record
      cadena : array [1 .. MAXPAL] of Letra;
      tope   : 0 .. MAXPAL
   end;

   Histograma =  array [Letra] of integer;

   InfoFicha = record
      puntaje : integer;
      cantidad : integer;
   end;

   InfoFichas = array[Letra] of InfoFicha;

   TipoBonus = (Ninguno, DobleLetra, TriplePalabra, Trampa);

   Casillero = record
      bonus : TipoBonus;
      case ocupada : boolean of
         true : (ficha : Letra);
         false : (); 
   end;

   Tablero = array['A'..MAXFILAS, 1..MAXCOLUMNAS] of Casillero;

   TipoDireccion = (Horizontal, Vertical);
   Posicion = record
      direccion : TipoDireccion;
      fila : 'A'..MAXFILAS;
      col  : 1..MAXCOLUMNAS;
   end;


   BolsaFichas = record
      letras : array[1..TOTALFICHAS] of Letra;
      tope : 0 .. TOTALFICHAS;
   end;

   Atril = record
      letras : array[1..MAXATRIL] of Letra;
      tope : 0 .. MAXATRIL;
   end;

   Texto	= ^NodoPal; 
   NodoPal	= record  
      info : Palabra;
      sig  : Texto
   end;

   TipoResultado = (Valida, NoEntra, NoFichas, NoExiste);

   ResultadoJugada = record
      palabra : Palabra;
      pos : Posicion;
      case tipo : TipoResultado of
         Valida : (puntaje : integer);
         NoEntra : ();
         NoFichas : ();
         NoExiste  : ();
   end;

   HistorialJugadas = ^NodoJugada;
   NodoJugada = record
      palabra : Palabra;
      pos : Posicion;
      puntaje : integer;
      sig : HistorialJugadas
   end;
}
procedure calcularHistograma(pal : Palabra; var hist : Histograma);
    { Retorna en `hist` el histograma de `pal`, es decir la cantidad
    de ocurrencias de cada letra en esa palabra.
    No se puede asumir el estado inicial de histograma. }

    var 
        i : integer;
        c: Letra;
begin
    {iniicializar el histograma a cero}
    for c in ['a'..'z'] do
        hist[c] := 0; {inicializar el contador de cada letra a 0}
    {recorrer cada letra de la palabra}
    for i := 1 to pal.tope do
    begin
        {si la letra de la palabra es igual a la letra del histograma}
        if pal.cadena[i] in ['a'..'z'] then
        begin
            {incrementar el contador de esa letra en el histograma}
            hist[pal.cadena[i]] := hist[pal.cadena[i]] + 1;
        end;
    end;
end;

function iguales(pal1, pal2 : Palabra) : boolean;
    { Dadas dos palabras, `pa1` y `pal2`, verifica si son iguales. Devolver con iguales:=}
    {Asumiremos que las palabras serán formateadas antes de llamar a iguales}
    var 
        i : integer;
        igual : boolean;
begin    
    { Si las palabras no tienen el mismo tope, no son iguales }
    if pal1.tope <> pal2.tope then
        igual := false
    else
    begin
        i := 1;
        igual := true;
        while (i <= pal1.tope) and igual do
        begin
            igual := (pal1.cadena[i] = pal2.cadena[i]);
            i := i + 1;
        end;
    end;
    { Devolver el resultado de la comparación }
    iguales := igual;
end;

procedure calcularHistogramaTexto(tex : Texto; var hist : Histograma);
    { Retorna en `hist` la cantidad de ocurrencias de cada letra en el texto `tex`.
    No se puede asumir el estado inicial de `hist`. }
    var
        h: Histograma;
        c: Letra;
begin
    {inicializar el histograma a cero}
    inicializarHistograma(h);
    //!{ limpiar el histograma hist:= h; da error}
    {limpia el histograma}
    for c in ['a'..'z'] do
        hist[c] := 0; {inicializar el contador de cada letra a 0}
    {recorrer el texto hasta que sea nulo}
    while tex <> nil do
    begin
        {calcular el histograma de la palabra}
        calcularHistograma(tex^.info, h);
        {avanzar al siguiente nodo del texto}
        tex := tex^.sig;
        {sumar h a histo}
        for c in ['a'..'z'] do
            hist[c] := hist[c] + h[c];
    end;
end;

function esPalabraValida(pal : Palabra; dicc : Texto) : boolean;
    { Dada una palabra `pal` y un diccionario `dicc`, verifica si la palabra
    está en el texto dicc. }
    var 
        bandera : boolean;
begin
    bandera := true; {inicializar bandera a true}
    esPalabraValida := false; {la palabra no es válida por defecto}
    {recorrer el diccionario hasta que sea nulo}
    while (dicc <> nil) and bandera do
    begin
        {si la palabra es igual a la palabra del diccionario}
        if iguales(pal, dicc^.info) then
        begin
            esPalabraValida := true; {la palabra es válida}
            bandera := false; {salir del bucle}
        end
        else
            {avanzar al siguiente nodo del diccionario}
            dicc := dicc^.sig;
    end;
end;

procedure removerLetraAtril(var mano : Atril; let : char);
    { Dada una letra `let`, elimina la primera aparición de esta
    del atril y deja a su lugar la última letra del atril.
    Se asume que la letra está en el atril. }
    var 
        i, pos : integer;
begin
    pos := -1; {inicializar posición a -1}
    {buscar la letra en el atril}
    i:=1; 
    while (pos = -1) and (i <= mano.tope) do
    begin
        if mano.letras[i] = let then
        begin
            pos := i; {guardar la posición de la letra}
        end;
        i := i + 1; {avanzar al siguiente índice}
    end;
    {si se encontró la letra}
    if pos <> -1 then
    begin
        mano.letras[pos] := mano.letras[mano.tope]; {reemplazar la letra por la última}
        mano.tope := mano.tope - 1; {disminuir el tope del atril}
    end;
end;

function entraEnTablero(pal : Palabra; pos : Posicion) : boolean;
    { Verifica si la palabra `pal` entra en el tablero a partir de la posición `pos`,
    teniendo en cuenta que no debe salirse de los límites del tablero. }
begin
    { Verificar si la palabra entra en el tablero según la dirección }
    if pos.direccion = Horizontal then
        { Verificar si la palabra cabe en la fila indicada }
        entraEnTablero := (pos.col + pal.tope - 1 <= MAXCOLUMNAS)
    else
        { Verificar si la palabra cabe en la columna indicada }
        entraEnTablero := (ord(pos.fila) + pal.tope - 1 <= ord(MAXFILAS));
end;

procedure siguientePosicion(var pos : Posicion);
    { Actualiza la posición `pos`, devuelve en la misma variable la posición del 
    siguiente casillero en la dirección indicada en `pos`. 
    Se asume que `pos` no corresponde a la última fila si la dirección es vertical, 
    ni a la última columna si la dirección es horizontal. }
begin
    { Actualizar la posición según la dirección }
    if pos.direccion = Horizontal then
    begin
       if pos.col <> MAXCOLUMNAS then
            pos.col := pos.col + 1; { Avanzar a la siguiente columna } 
    end
    else
    begin
        if pos.fila <> MAXFILAS then
            pos.fila := chr(ord(pos.fila) + 1); { Avanzar a la siguiente fila }
    end;
end;

function puedeArmarPalabra(pal : Palabra; pos : Posicion; mano : Atril; tab : Tablero) : boolean;
    { Verifica que la palabra `pal` puede armarse a partir de la posición `pos`, 
    considerando las letras disponibles en el atril y en el tablero (respetando su ubicación).
    Se puede asumir que la palabra entra en el tablero. }
    var 
        i, j : integer;
        booleano : boolean;
begin
    {compruebo si entra en el tablero}
    if not entraEnTablero(pal, pos) then
        puedeArmarPalabra := false {no entra en el tablero}
    else
    begin
        {inicializar la variable de retorno a true}
        puedeArmarPalabra := true;
        {recorrer cada letra de la palabra}
        i:= 1; {inicializar el índice de la palabra}
        booleano := true; {inicializar la variable booleana a true}
        while (i <=pal.tope) and (booleano) do
        begin
            {not: si la posición está ocupada y la ficha[i] != cadena[i]}
            booleano := not (tab[pos.fila, pos.col].ocupada and (tab[pos.fila, pos.col].ficha <> pal.cadena[i]));
            if booleano  then
            begin
                while tab[pos.fila, pos.col].ocupada and (i <=pal.tope)  do
                begin
                    siguientePosicion(pos);
                    i:=i+1;
                end;
                j:= 1;
                booleano := false;
                while (j <= mano.tope) and not booleano do {Si booleano es True, sale del bucle }
                begin
                    if (pal.cadena[i] = mano.letras[j]) then {Si la letra coincide con alguna ficha, se cambia a true}
                    begin                        
                        booleano := true;
                        {eliminar la letra del atril}
                        removerLetraAtril(mano, pal.cadena[i]); {remover la letra del atril}
                    end;
                    {letra, atril y booleano}
                    j:= j + 1;
                end;
                siguientePosicion(pos); {avanzar a la siguiente posición}
                i := i + 1; {avanzar al siguiente índice de la palabra}
            end;
            
            puedeArmarPalabra := booleano; {no se puede armar la palabra}
            
        end;
        
    end;

end;

procedure intentarArmarPalabra(pal : Palabra; pos : Posicion; 
                              var tab : Tablero; var mano : Atril; 
                              dicc : Texto; info : InfoFichas; 
                              var resu : ResultadoJugada);
    { Dada una palabra, posición, tablero, atril, diccionario, info y un resultado.}
    { En primer lugar, se verifica que la palabra entre en el tablero dada la posición. }
    { Luego que se pueda armar la palabra en el tablero con las fichas disponibles }
    { y por último que la palabra exista en el diccionario. }
    { Si es posible armar la palabra, esta se agrega en el tablero, actualiza `resu.tipo` y 
    almacena el puntaje en `resu.puntaje`.
    Para calcular el puntaje, se suman los puntos de las letras **agregadas**, utilizando 
    la información de `info` y la bonificación del casillero. Tanto para el puntaje calculado
    como para las bonificaciones **NO** suman las letras ya existentes en el tablero que conforman la palabra. 
    Si no se puede armar la palabra, devuelve el resultado correspondiente en `resu.tipo`. }
    var 
        i : integer;
        b: boolean;
begin
    b:= true;
    { Verificar si la palabra entra en el tablero }
    if not entraEnTablero(pal, pos) then
    begin
        { Si la palabra no entra en el tablero, se actualiza el resultado }
        resu.tipo := NoEntra; {la palabra no entra en el tablero}
        b:= false; {no se puede armar la palabra}
    end;

    { Verificar si se puede armar la palabra }
    if not puedeArmarPalabra(pal, pos, mano, tab) then
    begin
        { Si no se pueden armar las fichas, se actualiza el resultado }
        resu.tipo := NoFichas; {no se pueden armar las fichas}
        b:= false; {no se puede armar la palabra}
    end;

    { Verificar si la palabra es válida }
    if not esPalabraValida(pal, dicc) then
    begin
        { Si la palabra no existe en el diccionario, se actualiza el resultado }
        resu.tipo := NoExiste; {la palabra no existe en el diccionario}
        b:= false; {no se puede armar la palabra}
    end;
    
    if b then
    begin{ Si llega hasta aquí, la palabra es válida y se puede armar }
        resu.tipo := Valida;
        resu.palabra := pal;
        resu.pos := pos; 
        { Calcular el puntaje de la jugada }
        resu.puntaje := 0;
        
        for i in [1..pal.tope] do
        begin
            if not (tab[pos.fila, pos.col].ocupada) then
            begin
                { Si la letra no está ocupada, se agrega al tablero y se suma el puntaje }
                {a resultado le sumamos info del encabezado}
                resu.puntaje := resu.puntaje + info[pal.cadena[i]].puntaje;
                {agregar la letra al tablero}
                tab[pos.fila, pos.col].ocupada := true; {marcar el casillero como ocupado}
                tab[pos.fila, pos.col].ficha := pal.cadena[i]; {asignar la letra al casillero}
            end;
            siguientePosicion(pos); {avanzar a la siguiente posición}
        end;
    end;
end;

procedure registrarJugada(var jugadas : HistorialJugadas; pal : Palabra; pos : Posicion; puntaje : integer);
    { Dada una lista de jugadas, una palabra, Posicion y puntaje, agrega la jugada al final de la lista }
    var 
        nuevaJugada : HistorialJugadas;
        aux : HistorialJugadas;
begin
    new(nuevaJugada); {crear un nuevo nodo}
    nuevaJugada^.palabra := pal; {asignar la palabra}
    nuevaJugada^.pos := pos; {asignar la posición}
    nuevaJugada^.puntaje := puntaje; {asignar el puntaje}
    nuevaJugada^.sig := nil; {inicializar el siguiente nodo a nil}

    if jugadas = nil then
        jugadas := nuevaJugada {si la lista está vacía, asignar la nueva jugada como la primera}
    else
    begin
        aux := jugadas;
        while aux^.sig <> nil do
            aux := aux^.sig; {avanzar al final de la lista}
        aux^.sig := nuevaJugada; {agregar la nueva jugada al final de la lista}
    end;
end;