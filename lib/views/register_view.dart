import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm_mobile_app/constants/routes.dart';
import 'package:tm_mobile_app/services/auth/auth_exceptions.dart';
import 'package:tm_mobile_app/services/auth/auth_service.dart';
import 'package:tm_mobile_app/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _isObscure = true;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 400,
          child: Column(
            children: <Widget>[
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(
                'assets/images/tm_logo_vector.svg',
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _password,
                obscureText: _isObscure,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Enter your password here',
                  prefixIcon: const Icon(Icons.lock),
                  // hide@unhide password
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  // catch errors and show the errors
                  try {
                    await AuthService.firebase().createUser(
                      email: email,
                      password: password,
                    );
                    AuthService.firebase().sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  } on WeakPasswordAuthException {
                    await showErrorDialog(
                      context,
                      'Weak Password',
                    );
                  } on EmailAlreadyInUseAuthException {
                    await showErrorDialog(
                      context,
                      'Email is already in use',
                    );
                  } on InvalidEmailAuthException {
                    await showErrorDialog(
                      context,
                      'This is not invalid email address',
                    );
                  } on GenericAuthException {
                    await showErrorDialog(
                      context,
                      'Failed to register',
                    );
                  }
                },
                child: const Text('Register'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  primary: Colors.black,
                  backgroundColor: Colors.orange,
                  shape: const StadiumBorder(
                      side: BorderSide(color: Colors.orange, width: 2)),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  },
                  child: const Text('Already rergistered? Login here!'),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
