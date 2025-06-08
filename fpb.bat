@echo off
:: Verificar si se ha pasado un primer parámetro
if "%1"=="" (
  echo [31mError: No se ha proporcionado un archivo.[0m
  exit /b
)

:: Verificar si se ha pasado una ruta adicional como segundo parámetro
if not "%2"=="" (
  set "archivo_pas=%2\%1.pas"
  set "archivo_exe=%2\%1.exe"
) else (
  set "archivo_pas=.\%1.pas"
  set "archivo_exe=.\%1.exe"
)

:: Compilar el archivo .pas
echo Compilando el archivo %archivo_pas%...

echo [31m[2K[H

fpc -Co -Cr -gl -Miso "%archivo_pas%"
if errorlevel 1 (
  echo [0m
  exit /b
)
color 0A
pause
cls
color 07
:: Verificar si el .exe existe después de la compilación
if not exist "%archivo_exe%" (
  echo [31mError: El archivo %archivo_exe% no fue encontrado.[0m
  exit /b
)

:: Ejecutar el archivo .exe
echo Ejecutando el archivo %archivo_exe%...
"%archivo_exe%"
