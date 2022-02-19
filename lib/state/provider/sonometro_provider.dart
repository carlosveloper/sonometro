import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miapp/model/dispositivo.dart';
import 'package:miapp/model/sensor.dart';
import 'package:miapp/presentation/sonometro/sonometro.dart';

class SonoMetrorovider extends ChangeNotifier {
  late StreamSubscription<QuerySnapshot> streamSubscription,
      streamSubscription2;
  List<SensorModel> listaSensor = [];
  bool inicie = false;
  bool inicie2 = false;

  String idSensor = "";

  var list = <QueryDocumentSnapshot>[];
  List<Dispositivo> listaDispositivo = [];
  void disposeSuscription() {
    if (inicie) streamSubscription.cancel();
    listaSensor = [];
    inicie = false;
  }

  void listen() {
    if (!inicie) {
      inicie = true;
      streamSubscription = FirebaseFirestore.instance
          .collection('Mqtt_Values_Sensores')
          .where('idsensor', isEqualTo: idSensor /* '61BD9E7C' */)
          .orderBy('tiempo_lectura', descending: true)
          .limit(100)
          .snapshots()
          .listen((snapshot) {
        listaSensor = getSensor(snapshot.docs).reversed.toList();
//        valoresSensor.sort();
        notifyListeners();
      });
    }
  }

  void listenDispositivos() {
    if (!inicie2) {
      inicie2 = true;
      streamSubscription2 = FirebaseFirestore.instance
          .collection('Sensores')
          .snapshots()
          .listen((snapshot) {
        listaDispositivo = getDispositivos(snapshot.docs).toList();
//        valoresSensor.sort();
        notifyListeners();
      });
    }
  }
}

List<Dispositivo> getDispositivos(
  List<QueryDocumentSnapshot> list,
) {
  List<Dispositivo> lista = [];

  //Agrego los mensajes
  for (var doc in list) {
    var dato = doc.data() as Map<String, dynamic>;
    var mensaje = Dispositivo.fromMap(dato);
    print(doc.id);
    lista.add(mensaje);
  }

  return lista;
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
