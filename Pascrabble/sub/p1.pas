program principal;
{ Con esta directiva queda incluido el archivo definiciones.pas }
{$INCLUDE ../definiciones.pas}

{ Con esta directiva queda incluido el archivo tarea2.pas }
{$INCLUDE ../tarea2.pas}
{$INCLUDE t.pas}

var 
   i, puntaje: integer;
   hist: Histograma;
   c: Char;
   pal: Palabra;
   dicc: Texto;
   booleano: boolean;
   bolsa: BolsaFichas;
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
   puntaje:= 0;
   //TODO operar
   inicializarTablero(tab);
   calcularHistogramaTexto(dicc, hist);
   calcularPuntajes(hist, info);
   llenarBolsaFichas(info, bolsa);
   iniciarAtril(mano);
   // reponerFichas(bolsa, mano);

   mostrarTablero(tab);
   mostrarAtril(mano, info);
   writeln('Puntaje total: ', puntaje:0);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
   capsula6(puntaje, bolsa, mano, tab,info);
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