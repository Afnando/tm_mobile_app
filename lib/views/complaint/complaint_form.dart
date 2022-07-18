import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
import 'package:tm_mobile_app/utilities/add_update_dialog.dart';
import 'package:tm_mobile_app/utilities/error_dialog.dart';
import 'package:tm_mobile_app/views/complaint/widget/custom_text_input.dart';
import 'package:tm_mobile_app/views/navigation_bar.dart';
import 'package:tm_mobile_app/constants/routes.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({Key? key}) : super(key: key);

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

enum ProjectStatus { open, close }

class _ComplaintFormState extends State<ComplaintForm> {
  late final TextEditingController _month;
  late final TextEditingController _logDate;
  late final List<String> stakeHolderItem = [
    'BPA',
    'DO',
    'Individu',
    'Ketua Penduduk',
    'MCMC',
    'Media',
    'Menteri',
    'MP/ADUN',
    'SME',
    'SUK',
    'Unsolicited Proposal'
  ];
  late final TextEditingController _stakeHolder;
  late final List<String> picItem = ['Hj Daros', 'Zainuddin'];
  late final TextEditingController _pic;
  late final TextEditingController _issues;
  late final TextEditingController _actionItem;
  late final TextEditingController _rfsi;
  late final List<String> ownerItem = ['BRD', 'TM One', 'AND'];
  late final TextEditingController _owner;
  ProjectStatus? statusValue = ProjectStatus.open;
  String _status = 'Open';
  late final TextEditingController _closedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _month = TextEditingController();
    _logDate = TextEditingController();
    _stakeHolder = TextEditingController();
    _pic = TextEditingController();
    _issues = TextEditingController();
    _actionItem = TextEditingController();
    _rfsi = TextEditingController();
    _owner = TextEditingController();
    _closedDate = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _logDate.dispose();
    _stakeHolder.dispose();
    _pic.dispose();
    _issues.dispose();
    _actionItem.dispose();
    _rfsi.dispose();
    _owner.dispose();
    _closedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'COMPLAINT FORM',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      //make page can scroll
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LOG DATE PICKER FIELD
                const Text(
                  'Log Date',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                DateTimeField(
                  controller: _logDate,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Log Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  format: DateFormat('dd/MM/yyyy'),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(2016),
                      lastDate: DateTime(2050),
                      initialDate: currentValue ?? DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.input,
                      helpText: 'Select Log Date',
                      fieldLabelText: 'Log Date',
                    );
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_logDate) {
                    if (_logDate == null) {
                      return 'Please enter the date';
                    }
                    return null;
                  },
                ),

                // TextFormField(
                //   controller: _logDate,
                //   style: const TextStyle(
                //     fontSize: 20,
                //   ),
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //     hintText: 'Enter Log Date',
                //     prefixIcon: Icon(Icons.calendar_today),
                //   ),
                //   onTap: () async {
                //     // dismiss on screen keyboard
                //     FocusManager.instance.primaryFocus?.unfocus();

                //     DateTime? pickedLogDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime(2016),
                //       lastDate: DateTime(2050),
                //       initialEntryMode: DatePickerEntryMode.input,
                //       helpText: 'Select Log Date',
                //       fieldLabelText: 'Log Date',
                //     );

                //     if (pickedLogDate != null) {
                //       DateTime formatLogDate = DateFormat('yyyy/MM/dd')
                //           .parse(pickedLogDate.toString());
                //       String formatMonth =
                //           DateFormat('MMMM').format(pickedLogDate);

                //       _logDate.text = formatLogDate.toString();

                //       _month.text = formatMonth.toString();
                //       // _logDate.text = pickedLogDate.toString();
                //     }
                //   },
                // ),
                const SizedBox(height: 20),

                // MONTH PICKER FIELD
                const Text(
                  'Month',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),

                TextFormField(
                  controller: _month,
                  readOnly: true,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Month',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 20),

                // STAKEHOLDER DROPDOWN BUTTON FIELD
                const Text(
                  'StakeHolder',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),

                DropdownButtonFormField<String>(
                  items: stakeHolderItem
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(
                      () {
                        _stakeHolder.text = newValue!;
                      },
                    );
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_stakeHolder) {
                    if (_stakeHolder == null || _stakeHolder.isEmpty) {
                      return 'Please enter the stakeholder';
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Stakeholder',
                    hintStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.business),
                  ),
                ),
                const SizedBox(height: 20),

                // PERSON IN CHANGE DROPDOWN BUTTON FIELD
                const Text(
                  'Person-In-Charge',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                DropdownButtonFormField<String>(
                  items: picItem
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(
                      () {
                        _pic.text = newValue!;
                      },
                    );
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'PIC',
                    hintStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.person),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return 'Please enter the person-in-charge';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // ISSUES FIELD
                makeInput(
                  label: 'Help Needed / Issues / Challenges',
                  controller: _issues,
                ),

                // ACTION ITEMS FIELD
                const SizedBox(height: 20),
                makeInput(
                  label: 'Action Items',
                  controller: _actionItem,
                ),

                // RFSI FIELD
                const SizedBox(height: 20),
                makeInput(
                  label: 'RFSI',
                  controller: _rfsi,
                ),

                // OWNER DROPDOWN BUTTON
                const SizedBox(height: 20),
                const Text(
                  'Owner',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                DropdownButtonFormField<String>(
                  items: ownerItem
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (newValue) {
                    setState(
                      () {
                        _owner.text = newValue!;
                      },
                    );
                  },
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Owner',
                    hintStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.business_center),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return 'Please enter the owner';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // STATUS RADIO BUTTON
                const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ListTile(
                  title: const Text(
                    'Open',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Radio<ProjectStatus>(
                    value: ProjectStatus.open,
                    groupValue: statusValue,
                    onChanged: (ProjectStatus? value) {
                      setState(() {
                        statusValue = value;
                        _status = 'Open';
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Close',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Radio<ProjectStatus>(
                      value: ProjectStatus.close,
                      groupValue: statusValue,
                      onChanged: (ProjectStatus? value) {
                        setState(() {
                          statusValue = value;
                          _status = 'Close';
                        });
                      }),
                ),
                const SizedBox(height: 20),

                // DATE CLOSED PICKER FIELD
                const Text(
                  'Date Closed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                DateTimeField(
                  controller: _closedDate,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter the Date Closed',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  format: DateFormat('yyyy-MM-dd'),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(2016),
                      lastDate: DateTime(2050),
                      initialDate: currentValue ?? DateTime.now(),
                      initialEntryMode: DatePickerEntryMode.input,
                      helpText: 'Select Date Closed',
                      fieldLabelText: 'Date Closed',
                    );
                  },
                ),

                const SizedBox(
                  height: 25,
                ),

                // SUBMIT BUTTON
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 30.0,
                      ),
                      label: const Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          dashboardRoute,
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.send,
                        size: 30.0,
                      ),
                      label: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final complaintLog = ComplaintLog(
                            logDate: _logDate.text,
                            // month: DateTime.parse(_month.text),
                            stakeholder: _stakeHolder.text,
                            pic: _pic.text,
                            issues: _issues.text,
                            actionItem: _actionItem.text,
                            rfsi: _rfsi.text,
                            owner: _owner.text,
                            status: _status,
                            dateClosed: DateTime.parse(_closedDate.text),
                          );

                          // create complaint
                          createComplaint(complaintLog);

                          //show add dialog
                          await showAddUpdateDialog(
                            context,
                            'Complaint Update Successfully!!!',
                          );

                          Navigator.of(context).pushNamedAndRemoveUntil(
                            compLogRoute,
                            (route) => false,
                          );
                        } else {
                          await showErrorDialog(
                              context, 'Complaint cannot be added!!!');
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future createComplaint(ComplaintLog complaintLog) async {
  // Refrence to document
  final complaintUser =
      FirebaseFirestore.instance.collection('complaint').doc();
  complaintLog.id = complaintUser.id;

  final json = complaintLog.toJson();
  // create document and write data to Firestore
  await complaintUser.set(json);
}
