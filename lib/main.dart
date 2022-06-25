import 'package:flutter/material.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/services/auth/auth_service.dart';

import 'package:tm_mobile_app/views/complaint/complaint_form.dart';
import 'package:tm_mobile_app/views/complaint/complaint_log.dart';
import 'package:tm_mobile_app/views/complaint/dashboard_view.dart';
import 'package:tm_mobile_app/views/login_view.dart';
import 'package:tm_mobile_app/views/register_view.dart';
import 'package:tm_mobile_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        dashboardRoute: (context) => const DashboardView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        complainRoute: (context) => const ComplaintForm(),
        compLogRoute: (context) => const ComplaintLogView(),
      },
    ),
  );
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const DashboardView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
