# reset-password-AD
Script para cambio masivo de contraseñas en Active Directory con reporte CSV


CAMBIO MASIVO DE CONTRASEÑAS EN ACTIVE DIRECTORY
GUIA DE USO
=========================

OBJETIVO
Cambiar contraseñas de usuarios en Active Directory de forma masiva, automática y segura, generando un reporte en archivo CSV, sin forzar el cambio de contraseña al iniciar sesión.

---

1. REQUISITOS PREVIOS

Antes de ejecutar el script, se debe cumplir lo siguiente:

* Estar en una PC unida al dominio
* Tener permisos para resetear contraseñas en Active Directory
* Tener acceso a la carpeta:

C:\temp

* Tener instalado el módulo de Active Directory
* Ejecutar PowerShell con usuario del dominio
* Estar conectado a la VPN si se trabaja de forma remota

---

2. ARCHIVOS NECESARIOS

Dentro de la carpeta:

C:\temp

Deben existir exactamente estos dos archivos:

1. Script:
   reset_masivo_auto.ps1

2. Archivo con la lista de usuarios:
   usuarios.txt

El archivo usuarios.txt debe contener UN usuario por línea, sin espacios, por ejemplo:

11009440
11016759
11015511
11016407
11017104

---

3. ABRIR POWERSHELL EN LA RUTA CORRECTA

1) Presionar la tecla Windows
2) Escribir: powershell
3) Abrir PowerShell
4) Ejecutar este comando para entrar a la carpeta:

cd C:\temp

---

4. HABILITAR EJECUCION DEL SCRIPT (SOLO UNA VEZ POR SESION)

Ejecutar este comando:

Set-ExecutionPolicy Unrestricted -Scope Process

Cuando pregunte, escribir:

S

y presionar Enter.

---

5. EJECUTAR EL SCRIPT

Ejecutar este comando:

.\reset_masivo_auto.ps1

---

6. RESULTADO ESPERADO EN PANTALLA

Se verá algo similar a esto:

INICIANDO CAMBIO MASIVO DE CONTRASENAS
Usuarios detectados: 5
----------------------

OK: 11009440
OK: 11016759
ERROR: 11015511
OK: 11016407
OK: 11017104

---

7. REPORTE FINAL

Al finalizar el proceso, se genera automáticamente el archivo:

C:\temp\reporte_passwords.csv

Este archivo contiene:

* Usuario
* Password generada
* Estado del proceso (OK o ERROR)

Este archivo es el respaldo oficial del cambio masivo.

---

8. COMPORTAMIENTO DE LAS CONTRASEÑAS

* La contraseña se cambia automáticamente
* NO se obliga al usuario a cambiarla al iniciar sesión
* El vencimiento depende de la política del servidor
* El formato de la contraseña es:

Edgewell.12345

(Longitud total de 15 caracteres)

---

9. ERRORES COMUNES Y SOLUCION

Error: Get-ADUser AuthenticationException
Causa: No hay conexión al dominio.
Solución:

* Conectarse a la VPN
* Usar cuenta de dominio
* Ejecutar desde equipo unido al dominio

---

Error: .\reset_masivo_auto.ps1 no se reconoce
Causa: No estás en la carpeta correcta.
Solución:

* Ejecutar:

cd C:\temp

* Verificar que el archivo exista

---

10. BUENAS PRACTICAS

* Siempre respaldar el archivo reporte_passwords.csv
* Probar primero con un usuario antes de una lista grande
* Ejecutar solo con permisos autorizados
* No compartir el archivo CSV por canales inseguros

---

# FIN DEL DOCUMENTO
