import 'package:flutter/material.dart';

class IndicacionesScreen extends StatelessWidget {
  const IndicacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicaciones para la Cirugía'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Apreciado paciente, lea atentamente y ponga en práctica:',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
          _buildIndicacion('1',
              'Si su cirugía requiere anestesia general o regional, la última comida será 8 horas antes del procedimiento quirúrgico.'),
          _buildIndicacion('2',
              'Asistirá 2 días antes de la fecha de la cirugía a la oficina de “Admisiones”, Horario de Lunes a Viernes de 8 a.m. a 4 p.m. Sábado, Domingo y festivos de 8 a.m. a 12 m. (Traer la Fotocopia del Documento de Identidad).'),
          _buildIndicacion('3',
              'Confirme en admisiones si debe realizar copago y cuánto es su valor. Debe ser cancelado en el momento de la admisión.'),
          _buildIndicacion('4',
              'Solo si aplica y si le indican realice reserva de sangre 5 días antes de la cirugía si su grupo sanguíneo es RH NEGATIVO, o 2 días antes de la cirugía si su grupo sanguíneo es RH POSITIVO.(Laboratorio Clínico segundo Piso- Torre2).'),
          _buildIndicacion('5',
              'Siga recomendaciones de la toma de medicamentos según como selo haya indicado el anestesiólogo. Si usted toma ANTICUAGULANTES por favor indíquelo en la llamada de programación de cirugía.'),
          _buildIndicacion('6',
              'Asista a la cirugía con un acompañante mayor de edad. Si no está acompañado, su procedimiento será cancelado.'),
          _buildIndicacion('7',
              'El día de la cirugía debe presentarse dos horas antes de la hora que está programada su cirugía.\nNo traer joyas,maquillaje,esmalte,prótesis dentales,Pestañas y uñas postizas,celular,lentes de contacto.El cabello debe estar limpio, seco y recogido.'),
          _buildIndicacion('8',
              'Debe venir con ropa cómoda y maleta para guardar sus pertenencias.'),
          _buildIndicacion('9',
              'Debe traer todos los exámenes de laboratorio y estudios diagnósticos. Ej. TAC, Ecografía, Radiografía, etc. En CD- NO PRESENTARLOS EL DIA DE SU CIRUGIA ES MOTIVO DE CANCELACION DE LA MISMA.'),
          _buildIndicacion('10',
              'El día de la cirugía debe presentar los CONSENTIMIENTOS INFORMADOS completamente leídos, diligenciados con esfero negro y sin enmendaduras.'),
          _buildIndicacion('11',
              'Recuerde que en el momento de la cirugía no puede presentar gripa, fiebre, tos o diarrea.'),
          _buildIndicacion('12',
              'Si usted no puede presentarse el día de la cirugía o tiene alguna inquietud comuníquese con la oficina de programación de cirugía al teléfono 3612888 Extensión. 7205 Lunes a Viernes entre 1:00 PM a 3:00PM.'),
          _buildIndicacion('13',
              'Debe estar al día en pagos y Activo en su EPS el día de la Admisión.'),
          const Text(
            '¡Gracias por Adherirse a estas Recomendaciones!\nCordialmente Programación de Cirugía CPO',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicacion(String numero, String texto) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Indicación $numero',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(texto),
        ],
      ),
    );
  }
}
