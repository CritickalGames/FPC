program principal;
{ Con esta directiva queda incluido el archivo definiciones.pas }
{$INCLUDE ../definiciones.pas}

{ Con esta directiva queda incluido el archivo tarea2.pas }
{$INCLUDE ../tarea2.pas}
{$INCLUDE t.pas}

var 
   i: integer;
   hist: Histograma;
   c: Char;
   p1, pal: Palabra;
   p2: Palabra;
   ora: array[1..10] of Texto;
   dicc: Texto;
   booleano: boolean;
   info: InfoFichas;
   mano: Atril;
   tab: Tablero;
   pos: Posicion;
   resu: ResultadoJugada;
   jugadas : HistorialJugadas;
begin
   //TODO inicializar variables
   {inicializar el diccionario}
   dicc := crearDiccionario();
   {inicializar el histograma a cero}
   for c := 'a' to 'z' do
      hist[c] := 0;
   //TODO operar
   {while c <> "q"}
   c:='a';
   inicializarTablero(tab);
   {iniciar tab en cera horizontal I5 a I8}
   ocuparCelda(tab['I',5],'c', mano);
   ocuparCelda(tab['I',6],'e', mano);
   ocuparCelda(tab['I',7],'r', mano);
   ocuparCelda(tab['I',8],'a', mano);
   // while c <> 'q' do
   // begin
      // leerDiccionario(dicc);
      calcularHistogramaTexto(dicc, hist);
      calcularPuntajes(hist, info);
      i:=length(['L', 'R', 'A', 'P', 'A', 'I']);
      writeLn(i);
      rellenarAtrilX(mano, i, ['l', 'r', 'a', 'p', 'a', 'i']);
      // inicializarTablero(tab);
      // leerLetrasTablero(tab);
      mostrarAtril(mano, info);
      ingresarPalabraX(pal, pos, ['l','a','p','i','c','e','r','a'],'I', 1, 'H');
      {mostrar fila, col}
      imprimirPosicion(pos); writeln;
      intentarArmarPalabra(pal, pos, tab, mano, dicc, info, resu);
      write('Se intentó armar la palabra: ');
      mostrarPalabra(resu.palabra);
      writeln;
      write('En la posición: ');
      imprimirPosicion(resu.pos);
      writeln;
      case resu.tipo of
         NoEntra: writeln('La palabra no entra en el tablero.');
         NoFichas: writeln('No hay fichas en el atril y tablero para armar la palabra.');
         NoExiste: writeln('La palabra no existe en el diccionario.');
         Valida: begin
            write('Palabra armada "');mostrarPalabra(pal);writeln('" suma ', resu.puntaje:0, ' puntos.');
            mostrarTablero(tab);
            mostrarAtril(mano, info);
         end;
      end;
      liberarTexto(dicc);
   //    writeln('q para terminar...');
   //    readln(c);
   // end;
   {Hipotesis: PuedeArmarPalabra no comprueba si el espacio está ocupado por una ficha.}
end.

{
const
   MAXATRIL = 7; 
   MAXFILAS = 'I';   
   MAXCOLUMNAS = 9; 
   MAXPAL  = 30;      
   TOTALFICHAS = 100; 
   MAXPUNTAJE = 10; 
   RANDSEEDC = 42; 

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