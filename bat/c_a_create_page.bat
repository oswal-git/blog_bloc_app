@echo off

:: Obtener la ruta del script
set script_path=%~dp0
echo La ruta del script es: %script_path%

:: Obtener la ruta del directorio actual
set current_dir=%cd%
echo El directorio actual es: %current_dir%


:: Verifica si se proporcionó un argumento
if "%1"=="" (
    echo Debes proporcionar un nombre de carpeta.
    pause
    exit /b
)

:: Crea la carpeta principal
md %current_dir%\lib\src\features\"%1"
md "%1"

:: Crea los archivos dentro de la carpeta
cd "%1"
type nul > "%1_controller.dart"
type nul > "%1_presenter.dart"
type nul > "%1_view.dart"
cd ..

echo ¡Carpetas y archivos creados correctamente!