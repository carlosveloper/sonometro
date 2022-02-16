import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miapp/model/sensor.dart';
import 'package:miapp/presentation/sonometro/sonometro.dart';

class SonoMetrorovider extends ChangeNotifier {
  late StreamSubscription<QuerySnapshot> streamSubscription;
  List<SensorModel> listaSensor = [];
  List<double> valoresSensor = [];
  bool inicie = false;

  var list = <QueryDocumentSnapshot>[];

  void listen() {
    if (!inicie) {
      inicie = true;
      streamSubscription = FirebaseFirestore.instance
          .collection('Mqtt_Values_Sensores')
          .where('idsensor', isEqualTo: '61BD9E7C')
          .orderBy('tiempo_lectura', descending: false)
          .limit(100)
          .snapshots()
          .listen((snapshot) {
        listaSensor = getSensor(snapshot.docs);
        for (var x in listaSensor) {
          valoresSensor.add(double.parse(x.valorRuido.toString()));
        }
//        valoresSensor.sort();
        notifyListeners();
      });
    }
  }
}

List<SensorModel> getSensor(
  List<QueryDocumentSnapshot> list,
) {
  List<SensorModel> lista = [];

  //Agrego los mensajes
  for (var doc in list) {
    var dato = doc.data() as Map<String, dynamic>;
    var mensaje = SensorModel.fromMap(dato);
    print(doc.id);
    lista.add(mensaje);
  }

  return lista;
}
                //      DateFormat('HH:mm a').format(widget.mensaje.date),
