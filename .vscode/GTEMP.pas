procedure limpiarHistograma(var hist: Histograma);
    var c: letra;
begin
    for c in ['a'..'z'] do
        hist[c] := 0; {inicializar el contador de cada letra a 0}
end;

procedure calcularHistograma(pal : Palabra; var hist : Histograma);
    { Retorna en `hist` el histograma de `pal`, es decir la cantidad
    de ocurrencias de cada letra en esa palabra.
    No se puede asumir el estado inicial de histograma. }

    var 
        i : integer;
        c: Letra;
begin
    {iniicializar el histograma a cero}
    limpiarHistograma(hist);
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
    {inicializar el histograma auxiliar a cero}
    limpiarHistograma(h);
    {limpia el histograma}
    limpiarHistograma(hist);
    {recorrer el texto hasta que sea nulo}
    while tex <> nil do
    begin
        {calcular el histograma de la palabra y hustfstlo en el auxiliar}
        calcularHistograma(tex^.info, h);
        tex := tex^.sig;
        {sumar h a hist}
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
    pos := -1; {inicializar posición a -1 porque servirá de indice númerico y bandera}
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

procedure ocuparCelda(var celda: casillero; l: Letra; var mano: atril);
    {La letra L ocupa la celda de un tablero y elimina de var mano la letra L.}
begin
    celda.ocupada := true; {marcar el casillero como ocupado}
    celda.ficha := l; {asignar la letra al casillero}
    removerLetraAtril(mano, l);
end;

function entraEnTablero(pal : Palabra; pos : Posicion) : boolean;
    { Verifica si la palabra `pal` entra en el tablero a partir de la posición `pos`,
    teniendo en cuenta que no debe salirse de los límites del tablero. }
begin
    { Verificar si la palabra entra en el tablero según la dirección }
    if pos.direccion = Horizontal then {Se asume por letra que pos está inicializado}
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
    if pos.direccion = Horizontal then {Se asume por letra que pos está inicializado}
    begin
       if pos.col <> MAXCOLUMNAS then {Previene el acceso a una posición fuera de límites }
            pos.col := pos.col + 1; { Avanzar a la siguiente columna } 
    end
    else
    begin
        if pos.fila <> MAXFILAS then {Previene el acceso a una posición fuera de límites }
            pos.fila := chr(ord(pos.fila) + 1); { Avanzar a la siguiente fila }
    end;
end;

procedure avanzar(var i: integer; var pos: Posicion);
    {Procedure para resumir código en puedeArmarPalabra}
begin
    siguientePosicion(pos);
    i:=i+1;
end;

function puedeArmarPalabra(pal : Palabra; pos : Posicion; mano : Atril; tab : Tablero) : boolean;
    { Verifica que la palabra `pal` puede armarse a partir de la posición `pos`, 
    considerando las letras disponibles en el atril y en el tablero (respetando su ubicación).
    Se puede asumir que la palabra entra en el tablero. }
    var 
        i, j : integer; {Las letras sueltas son siempre indices génericos}
        booleano, auxB : boolean;
        celda :casillero;
begin
    i:= 1; {inicializar el índice de la palabra}
    booleano := true; {inicializar la variable booleana a true}
    repeat {recorrer cada letra de la palabra}
        celda := tab[pos.fila, pos.col]; {Creo que la variable facilita leer el código, pero no es necesario a nivel lógico}
        {Si está ocupado y pertenece a la palabra}
        auxB := celda.ocupada and (celda.ficha = pal.cadena[i]);
        booleano := not celda.ocupada;
        if booleano then {SI ESTÁ VACÍO}
        begin
            {LLEGA A LA SIGUIENTE CELDA VACÍA PARA AHORRAR PROCESOS}
            while tab[pos.fila, pos.col].ocupada and (i <=pal.tope)  do
                avanzar(i, pos); {i++; siguientePosicion()}
            j:= 1;
            booleano := false;
            {RECORRE LA MANO}
            while (j <= mano.tope) and not booleano do {Si booleano es True, sale del bucle }
            begin
                if (pal.cadena[i] = mano.letras[j]) then {Si la letra coincide con alguna ficha, se cambia a true}
                begin                        
                    booleano := true;
                    removerLetraAtril(mano, pal.cadena[i]); {remover la letra del atril}
                end;
                j:= j + 1;
            end;
            siguientePosicion(pos); {avanzar a la siguiente posición}
            i := i + 1; {avanzar al siguiente índice de la palabra}
        end
        else if auxB then {SI ESTÁ OCUPADO Y PERTENECE A LA PALABRA}
        begin
            booleano := auxB;
            avanzar(i, pos); {i++; siguientePosicion()}
        end;
    until not ((i <=pal.tope) and (booleano));
    puedeArmarPalabra := booleano; {no se puede armar la palabra}
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
        triple, i : integer;{triple cuenta cuantas veces se aplica el bono}
        b: boolean;
        celda: casillero;
begin
    resu.palabra := pal;
    resu.pos := pos;
    b:= true; {Si se mantiene True, se puede armar la palabra}
    { Verificar si no la palabra entra en el tablero }
    if not entraEnTablero(pal, pos) then
    begin
        { Si la palabra no entra en el tablero, se actualiza el resultado }
        resu.tipo := NoEntra; {la palabra no entra en el tablero}
        b:= false; {no se puede armar la palabra}
    end;

    { Verificar si no se puede armar la palabra }
    if not puedeArmarPalabra(pal, pos, mano, tab) then
    begin
        { Si no se pueden armar las fichas, se actualiza el resultado }
        resu.tipo := NoFichas; {no se pueden armar las fichas}
        b:= false; {no se puede armar la palabra}
    end;

    { Verificar si no la palabra es válida }
    if not esPalabraValida(pal, dicc) then
    begin
        { Si la palabra no existe en el diccionario, se actualiza el resultado }
        resu.tipo := NoExiste; {la palabra no existe en el diccionario}
        b:= false; {no se puede armar la palabra}
    end;
    
    if b then
    begin{ Si llega hasta aquí, la palabra es válida y se puede armar }
        resu.tipo := Valida;
        { Calcular el puntaje de la jugada }
        resu.puntaje := 0;
        triple:=0;        
        for i in [1..pal.tope] do
        begin 
            celda:= tab[pos.fila, pos.col]; {obtiene la información de la celda, sólo por estética}
            if not (celda.ocupada) then
            begin{ Si la letra no está ocupada, se agrega al tablero y se suma el puntaje }
                case celda.bonus of {a resultado le sumamos info del encabezado}
                    Ninguno:resu.puntaje := resu.puntaje + info[pal.cadena[i]].puntaje;
                    DobleLetra:resu.puntaje := resu.puntaje + info[pal.cadena[i]].puntaje*2;
                    TriplePalabra:
                    begin
                        triple:=triple+1;
                        resu.puntaje := resu.puntaje + info[pal.cadena[i]].puntaje;
                    end;
                    Trampa:resu.puntaje := resu.puntaje - info[pal.cadena[i]].puntaje;    
                end;
                {agregar la letra al tablero}
                ocuparCelda(tab[pos.fila, pos.col], pal.cadena[i], mano); {No usar celda porque no actualizaría}
            end;
            siguientePosicion(pos); {avanzar a la siguiente posición}
        end;
        {Si el contador de tiple es mayor a cero, triplica el valor de la palbra}
        if triple>0 then {No uso While para ahorrarme el bloque begin end; y para ahorar una comparación}
            for i in [1..triple] do
                resu.puntaje := resu.puntaje*3;
    end;
end;

procedure registrarJugada(var jugadas : HistorialJugadas; pal : Palabra; pos : Posicion; puntaje : integer);
    { Dada una lista de jugadas, una palabra, Posicion y puntaje, agrega la jugada al final de la lista }
    var 
        nuevaJugada : HistorialJugadas;
        aux : HistorialJugadas;
begin
    //TODO: Crea nuevo nodo
    new(nuevaJugada); {crear un nuevo nodo}
    nuevaJugada^.palabra := pal; {asignar la palabra}
    nuevaJugada^.pos := pos; {asignar la posición}
    nuevaJugada^.puntaje := puntaje; {asignar el puntaje}
    nuevaJugada^.sig := nil; {inicializar el siguiente nodo a nil}

    if jugadas = nil then {si la lista está vacía, asignar la nueva jugada como la primera}
        jugadas := nuevaJugada
    else {Si la lista existe, recorre la lista con un auxiliar y asigna el nuevo nodo como el último}
    begin
        aux := jugadas;
        while aux^.sig <> nil do
            aux := aux^.sig; {avanzar al final de la lista}
        aux^.sig := nuevaJugada; {agregar la nueva jugada al final de la lista}
    end;
end;