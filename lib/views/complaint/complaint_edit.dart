import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
import 'package:tm_mobile_app/services/cloud/firebase_cloud_storage.dart';
import 'package:tm_mobile_app/utilities/add_update_dialog.dart';
import 'package:tm_mobile_app/utilities/error_dialog.dart';
import 'package:tm_mobile_app/views/complaint/widget/custom_text_input.dart';
import 'package:tm_mobile_app/views/navigation_bar.dart';

class EditFormView extends StatefulWidget {
  final ComplaintLog? log;
  const EditFormView({Key? key, required this.log}) : super(key: key);

  @override
  State<EditFormView> createState() => _EditFormViewState();
}

enum ProjectStatus { open, close }

class _EditFormViewState extends State<EditFormView> {
  late final FirebaseCloudStorage _logService;
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
  final _stakeHolder = TextEditingController();
  late final List<String> picItem = ['Hj Daros', 'Zainuddin'];
  final _pic = TextEditingController();
  final _issues = TextEditingController();
  final _actionItem = TextEditingController();
  final _rfsi = TextEditingController();
  late final List<String> ownerItem = ['BRD', 'TM One', 'AND'];
  final _owner = TextEditingController();
  ProjectStatus? statusValue = ProjectStatus.open;
  String _status = 'Open';
  late final TextEditingController _closedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _logService = FirebaseCloudStorage();
    _month = TextEditingController();
    _logDate = TextEditingController();
    _stakeHolder.value =
        TextEditingValue(text: widget.log!.stakeholder.toString());
    _pic.value = TextEditingValue(text: widget.log!.pic.toString());
    _issues.value = TextEditingValue(text: widget.log!.issues.toString());
    _actionItem.value =
        TextEditingValue(text: widget.log!.actionItem.toString());
    _rfsi.value = TextEditingValue(text: widget.log!.rfsi.toString());
    _owner.value = TextEditingValue(text: widget.log!.owner.toString());
    _closedDate = TextEditingController();
    super.initState();
  }

  // // take changes of complaint and update it
  // void _textControllerListener() async {
  //   final log = _log;
  //   if (log == null) {
  //     return;
  //   }
  //   final logDate = _logDate.text;
  //   final stakeholder = _stakeHolder.text;
  //   final pic = _pic.text;
  //   final issues = _issues.text;
  //   final actionItem = _actionItem.text;
  //   final rfsi = _rfsi.text;
  //   final owner = _owner.text;
  //   final status = _status;
  //   final dateClosed = _closedDate.text;

  //   await _logService.updateComplaint(
  //     id: log.id,
  //     logDate: logDate,
  //     stakeholder: stakeholder,
  //     pic: pic,
  //     issues: issues,
  //     actionItem: actionItem,
  //     rfsi: rfsi,
  //     owner: owner,
  //     status: status,
  //     dateClosed: dateClosed,
  //   );
  // }

  // void _setupTextControllerListener() {
  //   //remove listener from TextEditingController
  //   _logDate.removeListener(_textControllerListener);
  //   _stakeHolder.removeListener(_textControllerListener);
  //   _pic.removeListener(_textControllerListener);
  //   _issues.removeListener(_textControllerListener);
  //   _actionItem.removeListener(_textControllerListener);
  //   _rfsi.removeListener(_textControllerListener);
  //   _owner.removeListener(_textControllerListener);
  //   // _status.removeListener(_textControllerListener);
  //   _closedDate.removeListener(_textControllerListener);

  //   //listen to changes
  //   _logDate.addListener(_textControllerListener);
  //   _stakeHolder.addListener(_textControllerListener);
  //   _pic.addListener(_textControllerListener);
  //   _issues.addListener(_textControllerListener);
  //   _actionItem.addListener(_textControllerListener);
  //   _rfsi.addListener(_textControllerListener);
  //   _owner.addListener(_textControllerListener);
  //   // _status.addListener(_textControllerListener);
  //   _closedDate.addListener(_textControllerListener);
  // }

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
          'EDIT COMPLAINT',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Iterable<ComplaintLog>>(
        future: _logService.getComplaint(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            // final complaintLog = snapshot.data!;

            // _setupTextControllerListener();
            return SingleChildScrollView(
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
                              // initialValue: DateFormat('dd/MM/yyyy',_logDate.text),
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (_logDate) {
                                if (_logDate == null) {
                                  return 'Please enter the date';
                                }
                                return null;
                              },
                            ),

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
                              value: _stakeHolder.text,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (_stakeHolder) {
                                if (_stakeHolder == null ||
                                    _stakeHolder.isEmpty) {
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
                              value: _pic.text,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              value: _owner.text,
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      compLogRoute,
                                      (route) => false,
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                ElevatedButton.icon(
                                  icon: const Icon(
                                    Icons.mode_edit,
                                    size: 30.0,
                                  ),
                                  label: const Text(
                                    'Update',
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
                                      // update complaint
                                      _logService.updateComplaint(
                                        id: widget.log!.id,
                                        // logDate: _logDate.text,
                                        stakeholder: _stakeHolder.text,
                                        pic: _pic.text,
                                        issues: _issues.text,
                                        actionItem: _actionItem.text,
                                        rfsi: _rfsi.text,
                                        owner: _owner.text,
                                        // statusField: status,
                                        // dateClosedField: dateClosed,
                                      );
                                      //  show update dialog
                                      await showAddUpdateDialog(
                                        context,
                                        'Complaint Added Successfully!!!',
                                      );

                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                        compLogRoute,
                                        (route) => false,
                                      );
                                    } else {
                                      await showErrorDialog(context,
                                          'Complaint cannot be updated!!!');
                                    }
                                  },
                                ),
                              ],
                            )
                          ],
                        ))));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// checkValidation(GlobalKey<FormState> _formKey) {
//   if (_formKey.currentState!.validate()) {
//     print('Validate');
//   } else {
//     print('NOT Validated');
//   }
// }
