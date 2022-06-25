import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tm_mobile_app/views/navigation_bar.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';

class ComplaintLogView extends StatefulWidget {
  const ComplaintLogView({Key? key}) : super(key: key);

  @override
  State<ComplaintLogView> createState() => _ComplaintLogViewState();
}

class _ComplaintLogViewState extends State<ComplaintLogView> {
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

            return PaginatedDataTable(
              source: _data,
              header: const Text(
                'My Products',
                style: TextStyle(fontSize: 20),
              ),
              columns: const [
                DataColumn(label: Text('Log Date')),
                DataColumn(label: Text('PIC')),
                DataColumn(label: Text('Issues')),
                DataColumn(label: Text('RFSI')),
                DataColumn(label: Text('Stakeholder')),
                DataColumn(label: Text('Owner')),
              ],
              columnSpacing: 50,
              horizontalMargin: 10,
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
}

// Widget buildLog(ComplaintLog complaintLog) => ListTile(
//       title: Text(
//         complaintLog.issues,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//       subtitle: Text(complaintLog.logDate.toIso8601String()),
//       tileColor: Color.fromARGB(255, 86, 192, 253),
//     );

Stream<List<ComplaintLog>> readComplaint() => FirebaseFirestore.instance
    .collection('complaint')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => ComplaintLog.fromJson(doc.data())).toList());

class CompData extends DataTableSource {
  final List<ComplaintLog> complaintLog;

  CompData(this.complaintLog);

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => complaintLog.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(complaintLog[index].logDate)),
      DataCell(Text(complaintLog[index].pic)),
      DataCell(Text(complaintLog[index].issues)),
      DataCell(Text(complaintLog[index].rfsi)),
      DataCell(Text(complaintLog[index].stakeholder)),
      DataCell(Text(complaintLog[index].owner)),
    ]);
  }
}
