
rem Crear una estructura de carpetas para la Arquitectura Limpia en Flutter

rem Directorio principal de la aplicación

rem echo"Estructura de carpetas de la Arquitectura Limpia creada con éxito."

:: Obtener la ruta del script
set script_path=%~dp0
echo La ruta del script es: %script_path%

:: Obtener la ruta del directorio actual
set current_dir=%cd%
echo El directorio actual es: %current_dir%

mkdir %current_dir%\lib\core
mkdir %current_dir%\lib\core\common
mkdir %current_dir%\lib\core\common\cubits
mkdir %current_dir%\lib\core\common\cubits\cubit
mkdir %current_dir%\lib\core\common\entities
mkdir %current_dir%\lib\core\common\widgets
mkdir %current_dir%\lib\core\constants
mkdir %current_dir%\lib\core\error
mkdir %current_dir%\lib\core\network
mkdir %current_dir%\lib\core\routes
mkdir %current_dir%\lib\core\secrets
mkdir %current_dir%\lib\core\theme
mkdir %current_dir%\lib\core\usecase
mkdir %current_dir%\lib\core\utils
rem *************************************************

rem *************************************************
rem type nul >  %current_dir%\lib\core\common\entities\no_params.dart
rem type nul >  %current_dir%\lib\core\common\widgets\loader.dart
rem type nul >  %current_dir%\lib\core\constants\constants.dart
rem type nul >  %current_dir%\lib\core\error\failure.dart
rem type nul >  %current_dir%\lib\core\error\server_exception.dart
rem type nul >  %current_dir%\lib\core\network\connection_checker.dart
rem *************************************************

rem *************************************************
type nul >  %current_dir%\lib\core\routes\go_router_provider.dart
type nul >  %current_dir%\lib\core\routes\routes_name.dart
type nul >  %current_dir%\lib\core\secrets\app_secrets.dart
type nul >  %current_dir%\lib\core\theme\app_theme.dart
type nul >  %current_dir%\lib\core\theme\app_pallete.dart
type nul >  %current_dir%\lib\core\usecase\use_case.dart

rem *************************************************
type nul >  %current_dir%\lib\ini_dependencies_rel.dart
type "import 'package:%current_dir%/ini_dependencies_rel.dart';" >  %current_dir%\lib\ini_dependencies.dart
rem *************************************************

echo"Estructura de carpetas de la Arquitectura Limpia creada con éxito."