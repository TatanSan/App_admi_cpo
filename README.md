# admi_cpo
A prototype Flutter project.
---
## Tabla de Contenidos
- [Introducción](#introducción)
- [Instalación](#instalación)
- [Uso](#uso)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Desarrollo](#desarrollo)
- [Contribuciones](#contribuciones)
- [Aportes del proyecto a la institución](#aportes-del-proyecto-a-la-institución)
- [Conclusiones del proyecto](#conclusiones-del-proyecto) 
- [Licencia](#licencia)
- [Contacto](#contacto)
- [Galería de Imágenes](#galería-de-imágenes)

## Introducción
Este proyecto fue desarrollado con los siguientes objetivos:
- Crear una app (prototipo) que permita realizar el registro de admisión de los pacientes que están programados para cirugías, reduciendo el desplazamiento de los usuarios a las instalaciones de la clínica, mitigando los errores en los datos del registro de admisión.
- Crear una alerta que permita recordar al usuario la asignación de su cupo quirúrgico, con recomendación y preparación antes de su cirugía.
- Activar el módulo de pagos (sujeto a convenios), que permita realizar los pagos de copagos a través de la aplicación por medio de convenios como por ejemplo (PSE).

### Objetivos Especificos
- Objetivo 1: Mejorar la precisión en el proceso de admisión y verificación de datos.
- Meta: Por medio de la interfaz de usuario de la app, se creara un formulario que permita el ingreso de los datos de identificación, edad, alergias, religión, y demás datos relevantes que alimentarán la base de datos de la cual se obtendrán los datos para el registro de admisión.
- Objetivo 2: Disminuir la necesidad del desplazamiento de los usuarios de manera presencial a las
instalaciones de la clínica para el proceso administrativo.
- Meta: La aplicación se podrá descargar a través de la plataforma de Android (Play Store) y distribución APK.
- Objetivo 3: Implementar un sistema de recordatorios automáticos para citas y procedimientos.
- Meta: Se creara un botón de alerta que permita notificar al usuario por medio de mensaje de texto y/o correo electrónico la asignación de su cupo quirúrgico.
- Objetivo 4: Programación, recomendaciones y preparación previa a la cirugía.
- Meta: Se implementara un icono que muestre la información de la programación de la cirugía para trámites pertinentes en cuanto a permisos laborales entre otros, con sus debidas recomendaciones y preparación previa.
- Objetivo 4: Facilitar el pago virtual de copagos a través de la aplicación.
- Meta: Habilitar la función de pago virtual por medio de un botón como PSE.

## Instalación
`Bash`
Cómo instalar y configurar el proyecto localmente.
### Clona el repositorio
git clone https://github.com/TatanSan/App_admi_cpo.git

### Navega al directorio del proyecto
cd admi_cpo (carpeta raiz o donde hayas clonado y guardado el archivo)

### Instala las dependencias
Este proyecto utiliza las siguientes dependencias principales:

- `flutter`: SDK de Flutter.
- `firebase_core`: Inicialización de Firebase.
- `cloud_firestore`: Para interactuar con Firestore.
- `http`: Para realizar solicitudes HTTP.
- `provider`: Para la gestión del estado.
- `flutter_local_notifications`: Para mostrar notificaciones locales.
- `intl`: Para la manipulación de fechas y horas.
- `firebase_auth`: Para la autenticación con Firebase.
- `sendgrid_mailer`: Para enviar correos electrónicos usando SendGrid.`
- `flutter pub get`: Actualia las dependencias

Asegúrate de añadir las dependencias a tu archivo `pubspec.yaml`.

### Ejemplo de archivo pubspec.yaml:
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/6cec0f76-b415-4f8c-8161-91bb9126b78f)

### Requisitos Funcionales
RF-1: Registro de Pacientes
- Los usuarios deben poder registrarse en la aplicación utilizando su correo electrónico y contraseña.
- Deben ingresar datos como nombre, edad, alergias, religión y otros datos relevantes.
RF-2: Validación de Datos
- Los datos ingresados por los usuarios deben ser validados antes de ser almacenados.
- La validación incluye verificar campos obligatorios y formatos de datos correctos.
RF-3: Almacenamiento Seguro en Base de Datos
- Los datos de los pacientes registrados deben almacenarse de forma segura en una base de datos en la nube (Firebase Firestore).
  
### Requisitos no funcionales
RNF-1: Seguridad de Datos
- La aplicación debe cumplir con estándares de seguridad para proteger la información confidencial de los pacientes.
RNF-2: Usabilidad
- La interfaz de usuario debe ser intuitiva y fácil de usar para los usuarios finales.
4. Diseño Inicial
DI-1: Interfaz de Usuario (UI)
- Se diseñará una interfaz de usuario limpia y moderna utilizando widgets de Flutter.
- Incluirá pantallas de registro, formularios de ingreso de datos y mensajes de retroalimentación.

### Desarrollo del Registro de Admisión
DR-1: Implementación de Páginas y Componentes
- Se implementarán las páginas y componentes necesarios para el registro de pacientes.
- Esto incluirá la lógica de validación de datos y el almacenamiento en Firebase.
DR-2: Integración con Firebase
- La aplicación se integrará con Firebase Authentication y Firebase Firestore para la autenticación y almacenamiento de datos.

### Diseño preliminar de interfaz
#### Interfaz gráfica principal
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/143f7f83-fb62-43ac-94da-cd84e7ac22ab)
#### Interfaz de registro y login
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/2a84f5b2-d4eb-4f25-8888-03747cdb7c71)
#### Integración a Firebase
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/0fd6e0b7-835e-4dc9-8ac1-572e3d86a583)
 
## Uso
- Ejecuta el proyecto
`flutter run`
- Registra un usuario en el botón registrar.
- Haz login en el botón iniciar sesión con el usuario creado anteriormente.
- Navega a través de la interfaz intuitiva que contine texto de ayuda para su navegación.

### Mejoras y pruebas
#### Mejora de interfaz principal
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/10cf0a2d-fee9-4d0d-b3dd-96c8d8d4a3d8)


## Estructura del Proyecto
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/49ce7360-9d11-47cc-9969-79730bb2779e)

## Desarrollo
Información sobre cómo contribuir al desarrollo del proyecto.

### A tener en cuenta: GitHub ha detectado como demasiado grandes los siguientes archivos:

Archivos que superan el límite de tamaño de GitHub. GitHub tiene un límite de tamaño de archivo de 100 MB por archivo y ha notificado que algunos de los archivos exceden este límite. Se utilizo Git LFS, pero aun asi no permitio por lo tanto:

### Archivos que indican que superan el tamaño permitido:
.dart_tool/flutter_build/5d633b90ea5306d17ce79d7de5357db3/app.dill (50.88 MB)
build/app/intermediates/incremental/debug-mergeJavaRes/zip-cache/HvfdPh0oezUFbM6ffAqKiF9KRHM= (69.24 MB)
build/app/intermediates/merged_native_libs/debug/out/lib/arm64-v8a/libVkLayer_khronos_validation.so (233.39 MB)
build/app/outputs/apk/debug/app-debug.apk (129.02 MB)

### Veamos cada archivo:

1. .dart_tool/flutter_build/5d633b90ea5306d17ce79d7de5357db3/app.dill: Este archivo es generado por el compilador Dart durante el proceso de compilación de una aplicación Flutter. Contiene el código compilado en formato binario. Por lo general, no necesitas mantener este archivo en tu repositorio, ya que puede ser regenerado fácilmente mediante el proceso de compilación. Eliminarlo no debería causar ningún conflicto. **(Archivo Eliminado)**

2. build/app/intermediates/incremental/debug-mergeJavaRes/zip-cache/HvfdPh0oezUFbM6ffAqKiF9KRHM=: Este parece ser un archivo de caché generado durante el proceso de compilación de la aplicación. Normalmente, los archivos de caché no son necesarios para el funcionamiento de la aplicación y pueden eliminarse sin problemas. No debería causar conflictos al eliminarlo. **(Archivo Eliminado)**

3. build/app/intermediates/merged_native_libs/debug/out/lib/arm64-v8a/libVkLayer_khronos_validation.so: Este archivo parece ser una biblioteca nativa de Android (libVkLayer_khronos_validation.so) utilizada para la validación de Vulkan. Podría ser una biblioteca necesaria para el funcionamiento de tu aplicación si estás utilizando Vulkan en tu proyecto. Antes de eliminarlo, asegúrate de que no afectará el rendimiento o la funcionalidad de tu aplicación. **(Archivo Eliminado)**

4. build/app/outputs/apk/debug/app-debug.apk: Este archivo es el archivo APK de depuración generado durante el proceso de compilación de tu aplicación Flutter. Es el archivo que se instala en dispositivos Android para probar la aplicación. Si ya tienes el código fuente de tu aplicación y no necesitas el archivo APK generado, puedes eliminarlo sin problemas. **(Este archivo no se eliminó)**

## Contribuciones
Instrucciones para contribuir al proyecto. 
- Entiendase que el proyecto prototipo concluye con la fase final de (simulación) en la cual el usuario accede al botón de pagos y este puede ser direccionado al metodo de pago de su elección.
- Si deseas contribuir, por favor enfocate solo en el desarrollo de la fase final para integrar los metodos de pagos.
- Se puede contribuir en el desarrollo del codigo en donde se traiga la informacion de contacto del paciente, las indicacciones de la cirugia, la programación y descripciones de la cirugía, para ser generada a través de un archivo PDF que el usuario pueda imprimir o capturar pantalla con la información completa.

## Aportes del proyecto a la institución
1. Mejora en la Precisión del Proceso de Admisión
- Beneficio: La implementación del formulario de registro digital reduce significativamente los errores en la admisión de pacientes. Los datos como identificación, edad, alergias, religión y otros relevantes se almacenan de manera precisa y segura en una base de datos en la nube (Firebase).
- Impacto: Aumenta la eficiencia y la precisión del proceso de admisión, asegurando que la información crítica de los pacientes sea correcta y esté disponible para el personal médico.

2. Reducción del Desplazamiento de los Usuarios
- Beneficio: Al permitir a los pacientes registrar sus datos y realizar procesos administrativos desde la comodidad de su hogar, se reduce la necesidad de desplazarse físicamente a las instalaciones de la clínica.
- Impacto: Mejora la conveniencia para los pacientes, especialmente aquellos con movilidad limitada o con dificultades para asistir a citas presenciales, y optimiza el flujo de trabajo administrativo en la clínica.

3. Implementación de Recordatorios Automáticos para Citas y Procedimientos
- Beneficio: La integración de alertas y recordatorios automáticos, gestionados a través de Twilio y SendGrid, permite a los pacientes recibir notificaciones sobre la asignación de sus cupos quirúrgicos, recomendaciones y preparativos previos a la cirugía.
- Impacto: Aumenta la puntualidad y la preparación de los pacientes para sus procedimientos, reduciendo la tasa de cancelaciones y retrasos.

4. Programación y Recomendaciones Previas a la Cirugía
- Beneficio: La aplicación proporciona información detallada sobre la programación de la cirugía, incluyendo recomendaciones y preparativos necesarios, lo que facilita la planificación de los pacientes.
- Impacto: Mejora la comunicación entre la clínica y los pacientes, asegurando que estén bien informados y preparados para sus procedimientos quirúrgicos.

5. Facilitar el Pago Virtual de Copagos
- Beneficio: Aunque actualmente simulado, la funcionalidad de pago virtual integrada permite a los pacientes realizar copagos a través de la aplicación, utilizando posibles futuros convenios con proveedores de servicios de pago como PSE.
- Impacto: Facilita el proceso de pago para los pacientes, ahorrando tiempo y eliminando la necesidad de realizar pagos en persona. En el futuro, esto podría mejorar la experiencia del paciente y la eficiencia financiera de la clínica.

## Conclusiones del proyecto
El proyecto ha cumplido con los objetivos establecidos, proporcionando una solución integral que mejora la precisión en la admisión de pacientes, reduce la necesidad de desplazamientos físicos, y asegura una comunicación efectiva mediante alertas automáticas y recomendaciones prequirúrgicas. 
Además, ha sentado las bases para la integración de pagos virtuales, lo que potencialmente aumentará la conveniencia y eficiencia de los procesos administrativos de la clínica. 
Estos avances no solo optimizan la operativa interna, sino que también mejoran significativamente la experiencia del paciente, alineándose con las metas de innovación y calidad de servicio de la clínica.

## Licencia
Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.
* Las imágenes están sujetas a derechos del autor.
* Los nombres y las imagenes de la institución se encuentras bajo derechos de autor del Centro Policlinico del Olaya (C.P.O S.A)
* Cualquier uso indebido o con fines comerciales de los nombres e imágenes del presente proyecto acarreará sanciones legales.

## Contacto
- Desarrollado por `tatan Sanmiguel`
- https://github.com/TatanSan
- https://www.linkedin.com/in/yonatan-alexander-sanmiguel-lopez-636103219/
- https://www.youtube.com/channel/UC3LSoOmw2VkcCuvoPtJ01nQ

## Galería de Imágenes
#### Creación de formularios y pantallas de usuario y administrador
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/15d2ecbe-bfd9-4988-b9da-0b8167286d98)
#### Mejora interfaz registro e integracion a Firebase
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/b9c08c31-7cd3-4482-ad75-4ca0634a2b7b)
#### Manejo de errores 
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/bc1bb188-397d-41b8-9501-146f742805cf)
#### Formulario de datos de usuario
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/154340cb-36ab-44d7-9ab5-4b6f19b8180b)
#### Modificación de datos
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/18edfaab-d601-47f3-923b-6e4d04f90512)
#### Preferencia de alertas
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/baf80e5c-2b59-47ed-86fd-32755639f0f4)
#### Indicaciones de cirugia
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/e2181515-3dae-4427-a251-b8e7747cc5fb)
#### Programación de cirugia
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/a4746d8f-4264-44f0-b254-7f13bcdc4da0)
#### Interfaz de administrador
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/f0664e0c-4bed-498f-af90-ee7078b4c1ce)
#### Integración a Twilio y SendGrid
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/47f1b1d3-f481-4d70-8a37-7021cb18fb13)
#### Almacenamiento en colección de Firebase
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/7b09996c-3e75-47f1-a092-cec2f47e18b8)
#### Finalización de botones para simulación de pagos
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/dcd17ead-e39f-4ba8-8085-cbaf2f06ee5d)
#### Pantalla de simulación de pagos
![image](https://github.com/TatanSan/App_admi_cpo/assets/91441477/38ff51b3-1658-4f98-b28b-c9209f61aba5)








