program p1;

begin
  {$ifdef Windows}
    writeln(#27'[31;1m' +'Ejecutando en Windows!'+#27'[0m');
    writeln('Ejecutando en Windows!');
    {writeln(#27'[2J');  { Borra la pantalla }
    {writeln(#27'[H');   { Mueve el cursor al inicio }
  {$endif}

  {$ifdef Unix}
    writeln('Ejecutando en Linux o macOS!');
    writeln(#27'[2J'); { Envío de código ANSI para limpiar la consola }
    writeln(#27'[H');   { Mueve el cursor al inicio }
  {$endif}
end.
