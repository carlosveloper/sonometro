import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miapp/config/colors.dart';
import 'package:miapp/model/sensor.dart';

class TablePage extends StatefulWidget {
  final String idSensor;
  TablePage({Key? key, required this.idSensor}) : super(key: key);

  static const String namePage = '/Table';

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  String fechaInicio = "Fecha Inicio";
  String fechaFin = "Fecha Fin";
  DateTime? inicio, fin;

  bool seleccioneFecha = false;

  @override
  void initState() {
    super.initState();
  }

  resetear() {
    seleccioneFecha = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Tabla de sensor",
          ),
          actions: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                await showDialogPresentar(context);
                setState(() {});
              },
            )
          ],
        ),
        body: !seleccioneFecha
            ? Center(
                child: Text(
                    "Seleccione la fecha en el icono de calendario para comenzar la búsqueda"),
              )
            : _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    log("probando dibujando");

    var filtroInicio = inicio!.millisecondsSinceEpoch;
    var filtroFIN = fin!.add(Duration(days: 1)).millisecondsSinceEpoch;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Mqtt_Values_Sensores')
          .where('idsensor', isEqualTo: '61BD9E7C')
          //.orderBy('tiempo_lectura', descending: true)
          .where(
            'tiempo_lectura',
            isGreaterThanOrEqualTo: filtroInicio,
          )
          .where(
            'tiempo_lectura',
            isLessThanOrEqualTo: filtroFIN,
          )
          .orderBy('tiempo_lectura', descending: true)
          /*  .startAt(
              [startAtTimestamp])  */ /* .endAt([endTimestamp]) */ .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: DataTable(columns: [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Tipo')),
              DataColumn(label: Text('Valor')),
              DataColumn(label: Text('Fecha')),
            ], rows: _buildList(context, snapshot.data!.docs)),
          ),
        );
      },
    );
  }

  List<DataRow> _buildList(
      BuildContext context, List<QueryDocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, QueryDocumentSnapshot data) {
    var dato = data.data() as Map<String, dynamic>;
    var mensaje = SensorModel.fromMap(dato);

    return DataRow(cells: [
      DataCell(Text(mensaje.nombreSensor)),
      DataCell(Text(mensaje.tipoLectura.toString())),
      DataCell(Text(mensaje.valorRuido.toString())),
      DataCell(Text(
          DateFormat('dd-MM-yyyy HH:mm:ss a').format(mensaje.tiempoLectura))),
    ]);
  }

  Future<void> showDialogPresentar(contextMain, {bool plan = true}) async {
    showDialog(
      context: contextMain,
      barrierDismissible: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    if (plan) ...{
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FlatButton(
                                  color: AppColors.mainColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () async {
                                    var x = await calendar();

                                    if (x != null) {
                                      inicio = x;

                                      fechaInicioNuevo(inicio);

                                      setState(() {
                                        String formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(inicio!);
                                        fechaInicio = formattedDate.toString();
                                      });
                                    }
                                  },
                                  child: Text(
                                    fechaInicio,
                                    style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FlatButton(
                                  color: AppColors.mainColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                  onPressed: () async {
                                    var x = await calendar();
                                    if (x != null) {
                                      fin = x;
                                      fechaFinNuevo(fin);
                                      setState(() {
                                        String formattedDate =
                                            DateFormat('dd/MM/yyyy')
                                                .format(fin!);
                                        fechaFin = formattedDate.toString();
                                      });
                                    }
                                  },
                                  child: Text(
                                    fechaFin,
                                    style: TextStyle(
                                      fontSize: 18,
                                      decoration: TextDecoration.none,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: FlatButton(
                              color: Colors.red,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: FlatButton(
                              color: Colors.green,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () {
                                if (inicio != null && fin != null) {
                                  resetear();
                                  Navigator.of(context).pop();
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'Seleccione las fechas  para confirmar'),
                                  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text(
                                "Confirmar",
                                style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ])),
            );
          },
        );
      },
    );
  }

  Future<DateTime?> calendar() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Center(child: child);

        /* Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 450,
                  width: 700,
                  child: child,
                ),
              ),
            ],
          ),
        ); */
      },
    );

    return picked;
  }

  void fechaFinNuevo(fin) {
    /*   setState(() {
      String formattedDate = DateFormat('dd/MM/yyyy').format(fin!);
      fechaFin = formattedDate.toString();
    }); */
  }

  void fechaInicioNuevo(inicio) {
    /*  setState(() {
      String formattedDate = DateFormat('dd/MM/yyyy').format(inicio!);
      fechaInicio = formattedDate.toString();
    }); */
  }
}
