// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'dart:convert';
import 'dart:html';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class NotificationPage extends StatelessWidget {
  String plant = "", group = "", date = "";

  NotificationPage(
      {required this.plant, required this.group, required this.date});

  late _JsonDataGridSource jsonDataGridSource;
  List<_Product> productlist = [];

  var list;

  // Future generateProductList() async {
  //   const url = "http://localhost:3090/notification";
  //   final uri = Uri.parse(url);

  //   final response = await http.post(uri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'mode': 'no-cors'
  //       },
  //       body: jsonEncode(<String, String>{
  //         "plant": plantController.text,
  //         "group": groupController.text,
  //         "date": dateController.text
  //       }));

  //   list = json.decode(response.body).cast<Map<String, dynamic>>();
  //   print("json ==============>");
  //   print(list.runtimeType);
  //   print(list);

  //   productlist =
  //       list.map<_Product>((dynamic json) => _Product.fromJson(json)).toList();

  //   print("list ==============>");
  //   print(productlist.runtimeType);

  //   jsonDataGridSource = _JsonDataGridSource(productlist);
  //   return productlist;
  // }

  List<GridColumn> getColumns() {
    List<GridColumn> columns;

    columns = ([
      GridColumn(
        columnName: 'NOTIFICATION_NO',
        width: 150,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'NOTIFICATION_NO',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'NOTIFICATION_TYPE',
        width: 200,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'NOTIFICATION_TYPE',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'FUNCTIONAL_LOCATION',
        width: 200,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'FUNCTIONAL_LOCATION',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'DESCRIPTION',
        width: 250,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'DESCRIPTION',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'SYSTEM_STATUS',
        width: 150,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'SYSTEM_STATUS',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'DATE_OF_NOTIFICATION',
        width: 200,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'DATE_OF_NOTIFICATION',
            // overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'TIME_OF_NOTIFICATION',
        width: 200,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'TIME_OF_NOTIFICATION',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'PRIORITY',
        width: 150,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'PRIORITY',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'EXTERNAL_NO',
        width: 150,
        label: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 204, 39),
            border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
          ),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'EXTERNAL_NO',
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ),
    ]);
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController plantController = TextEditingController(text: plant);
    TextEditingController groupController = TextEditingController(text: group);
    TextEditingController dateController = TextEditingController(text: date);

    Future generateProductList() async {
      const url = "http://localhost:3090/notification";
      final uri = Uri.parse(url);

      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'mode': 'no-cors'
          },
          body: jsonEncode(<String, String>{
            "plant": plantController.text,
            "group": groupController.text,
            "date": dateController.text
          }));

      print("runtime type of response.body");
      print(response.body.runtimeType);

      list = json.decode(response.body).cast<Map<String, dynamic>>();
      print("json ==============>");
      print(list.runtimeType);
      // print(list);

      productlist = list
          .map<_Product>((dynamic json) => _Product.fromJson(json))
          .toList();

      print("list ==============>");
      print(productlist.runtimeType);

      jsonDataGridSource = _JsonDataGridSource(productlist);
      return productlist;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Workorder Details'),
        backgroundColor: Color.fromARGB(255, 0, 102, 120),
      ),
      body: Container(
          child: FutureBuilder(
              future: generateProductList(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return snapshot.hasData
                    ? SfDataGrid(
                        source: jsonDataGridSource, columns: getColumns())
                    : Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      );
              })),
    );
  }
}

class _Product {
  factory _Product.fromJson(Map<String, dynamic> json) {
    return _Product(
        NOTIFICATION_NO: json['NOTIFICAT'],
        NOTIFICATION_TYPE: json['NOTIF_TYPE'],
        FUNCTIONAL_LOCATION: json['FUNCLOC'],
        DESCRIPTION: json['DESCRIPT'],
        SYSTEM_STATUS: json['S_STATUS'],
        DATE_OF_NOTIFICATION: json['NOTIFDATE'],
        TIME_OF_NOTIFICATION: json['NOTIFTIME'],
        PRIORITY: json['PRIOTYPE'],
        EXTERNAL_NO: json['EXTERNAL_NUMBER']);
  }

  _Product(
      {this.NOTIFICATION_NO,
      this.NOTIFICATION_TYPE,
      this.FUNCTIONAL_LOCATION,
      this.DESCRIPTION,
      this.SYSTEM_STATUS,
      this.DATE_OF_NOTIFICATION,
      this.TIME_OF_NOTIFICATION,
      this.PRIORITY,
      this.EXTERNAL_NO});
  String? NOTIFICATION_NO;
  String? NOTIFICATION_TYPE;
  String? FUNCTIONAL_LOCATION;
  String? DESCRIPTION;
  String? SYSTEM_STATUS;
  String? DATE_OF_NOTIFICATION;
  String? TIME_OF_NOTIFICATION;
  String? PRIORITY;
  String? EXTERNAL_NO;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'NOTIFICATION_NO': NOTIFICATION_NO,
        'NOTIFICATION_TYPE': NOTIFICATION_TYPE,
        'FUNCTIONAL_LOCATION': FUNCTIONAL_LOCATION,
        'DESCRIPTION': DESCRIPTION,
        'SYSTEM_STATUS': SYSTEM_STATUS,
        'DATE_OF_NOTIFICATION': DATE_OF_NOTIFICATION,
        'TIME_OF_NOTIFICATION': TIME_OF_NOTIFICATION,
        'PRIORITY': PRIORITY,
        'EXTERNAL_NO': EXTERNAL_NO,
      };
}

class _JsonDataGridSource extends DataGridSource {
  _JsonDataGridSource(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<_Product> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(
            columnName: 'NOTIFICATION_NO', value: dataGridRow.NOTIFICATION_NO),
        DataGridCell<String>(
            columnName: 'NOTIFICATION_TYPE',
            value: dataGridRow.NOTIFICATION_TYPE),
        DataGridCell<String>(
            columnName: 'FUNCTIONAL_LOCATION',
            value: dataGridRow.FUNCTIONAL_LOCATION),
        DataGridCell<String>(
            columnName: 'DESCRIPTION', value: dataGridRow.DESCRIPTION),
        DataGridCell<String>(
            columnName: 'SYSTEM_STATUS', value: dataGridRow.SYSTEM_STATUS),
        DataGridCell<String>(
            columnName: 'DATE_OF_NOTIFICATION',
            value: dataGridRow.DATE_OF_NOTIFICATION),
        DataGridCell<String>(
            columnName: 'TIME_OF_NOTIFICATION',
            value: dataGridRow.TIME_OF_NOTIFICATION),
        DataGridCell<String>(
            columnName: 'PRIORITY', value: dataGridRow.PRIORITY),
        DataGridCell<String>(
            columnName: 'EXTERNAL_NO', value: dataGridRow.EXTERNAL_NO),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[4].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[5].value.toString(),
          overflow: TextOverflow.visible,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[6].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[7].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 242, 205),
          border: Border.all(color: Color.fromARGB(255, 253, 216, 216)),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[8].value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }
}
