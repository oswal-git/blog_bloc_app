@echo off

:: Obtener la ruta del script
set script_path=%~dp0
echo La ruta del script es: %script_path%

:: Obtener la ruta del directorio actual
set current_dir=%cd%
echo El directorio actual es: %current_dir%

:: Verifica si se proporcionó un argumento
if "%1"=="" (
    echo Debes proporcionar un nombre de característica.
    pause
    exit /b
)

:: Crea la carpeta principal

mkdir %current_dir%\lib\features\%1
mkdir %current_dir%\lib\features\%1\data
mkdir %current_dir%\lib\features\%1\data\datasources
mkdir %current_dir%\lib\features\%1\data\models
mkdir %current_dir%\lib\features\%1\data\repositories

mkdir %current_dir%\lib\features\%1\domain
mkdir %current_dir%\lib\features\%1\domain\repository
mkdir %current_dir%\lib\features\%1\domain\entities
mkdir %current_dir%\lib\features\%1\domain\usecases

mkdir %current_dir%\lib\features\%1\presentation
mkdir %current_dir%\lib\features\%1\presentation\bloc
mkdir %current_dir%\lib\features\%1\presentation\pages
mkdir %current_dir%\lib\features\%1\presentation\widgets


:: Crea los archivos dentro de la carpeta

type nul >  %current_dir%\lib\features\%1\data\datasources\%1_remote_data_source.dart
type nul >  %current_dir%\lib\features\%1\data\models\%1_model.dart
type nul >  %current_dir%\lib\features\%1\data\repositories\%1_repository_impl.dart

type nul >  %current_dir%\lib\features\%1\domain\repository\%1_repository.dart

type nul >  %current_dir%\lib\features\%1\presentation\pages\%1_page.dart

echo ¡Carpetas y archivos creados correctamente!