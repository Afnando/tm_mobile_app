import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:tm_mobile_app/services/cloud/firebase_cloud_storage.dart';
import 'package:tm_mobile_app/views/complaint/widget/edit_delete_button.dart';
import 'package:tm_mobile_app/views/navigation_bar.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';

class ComplaintLogView extends StatefulWidget {
  const ComplaintLogView({Key? key}) : super(key: key);

  @override
  State<ComplaintLogView> createState() => _ComplaintLogViewState();
}

class _ComplaintLogViewState extends State<ComplaintLogView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  PaginatorController? _controller;

  // final bool showActions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'COMPLAINT LOG',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<List<ComplaintLog>>(
        stream: readComplaint(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            final complaintLog = snapshot.data!;

            final DataTableSource _data = CompData(complaintLog);

            return PaginatedDataTable2(
              source: _data,

              header: const Text(
                'My Products',
                style: TextStyle(fontSize: 20),
              ),
              columns: const [
                DataColumn2(
                    label: Text(
                      'Bil',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    fixedWidth: 30),
                DataColumn(
                  label: Text(
                    'Log Date',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Stakeholder',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'PIC',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn2(
                    label: Text(
                      'Issues',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    size: ColumnSize.L),
                DataColumn(
                  label: Text(
                    'RFSI',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Owner',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn2(
                  label: Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

              initialFirstRowIndex: 0,
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (value) {
                _rowsPerPage = value!;
              },

              columnSpacing: 10,
              horizontalMargin: 10,
              minWidth: 800,
              // hidePaginator: ,
              fit: FlexFit.tight,
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
              border: TableBorder(
                  top: const BorderSide(color: Colors.black),
                  bottom: BorderSide(color: Colors.grey[300]!),
                  left: BorderSide(color: Colors.grey[300]!),
                  right: BorderSide(color: Colors.grey[300]!),
                  verticalInside: BorderSide(color: Colors.grey[300]!),
                  horizontalInside:
                      const BorderSide(color: Colors.grey, width: 1)),
              // Row( children: [ const Text('data')],);
            );

            // return ListView(
            //   children: complaintLog.map(buildLog).toList(),
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  // void del
}

// Widget buildLog(ComplaintLog complaintLog) => ListTile(
//       title: Text(
//         complaintLog.issues,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(complaintLog.logDate.toIso8601String()),
//       tileColor: Color.fromARGB(255, 86, 192, 253),
//     );

class CompData extends DataTableSource {
  final List<ComplaintLog> complaintLog;

  CompData(this.complaintLog);
  final _logService = FirebaseCloudStorage();

  int i = 1;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => complaintLog.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text((i++).toString())),
      DataCell(Text(complaintLog[index].logDate)),
      DataCell(Text(complaintLog[index].stakeholder)),
      DataCell(Text(complaintLog[index].pic)),
      DataCell(Text(complaintLog[index].issues)),
      DataCell(Text(complaintLog[index].rfsi)),
      DataCell(Text(complaintLog[index].owner)),
      DataCell(
        EditDeleteButton(
          logs: complaintLog,
          onDeleteLog: (log) async {
            await _logService.deleteComplaint(id: complaintLog[index].id);
          },
          index: index,
        ),
      ),
    ]);
  }
}
