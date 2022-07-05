import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/enums/menu_action.dart';
import 'package:tm_mobile_app/services/auth/auth_service.dart';
import 'package:tm_mobile_app/services/cloud/cloud_complaint.dart';
import 'package:tm_mobile_app/utilities/logout_dialog.dart';
import 'package:tm_mobile_app/views/navigation_bar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            // color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Hello'),
            Container(
              child: Column(
                children: [
                  StreamBuilder<Object>(
                    stream: readComplaint(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                        // } else if (snapshot.hasData) {
                        //   getStakeHolder();
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

late List<ComplaintLog> _stake = [];
Map<String, double> getStakeHolder() {
  Map<String, double> stakeMap = {};
  for (var item in _stake) {
    print(item.stakeholder);
    if (stakeMap.containsKey(item.stakeholder) == false) {
      stakeMap[item.stakeholder] = 1;
    } else {
      stakeMap.update(
          item.stakeholder, (int) => stakeMap[item.stakeholder]! + 1);
      // test[item.category] = test[item.category]! + 1;
    }
    print(stakeMap);
  }
  return stakeMap;
}

// Widget pieChartExampleOne() {
//   return PieChart();
// }
