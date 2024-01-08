import 'package:flutter/material.dart';

import '../data/auth_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

enum AuthMode { Signup, Login }

class _LoginPageState extends State<LoginPage> {
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  //final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  bool _isLoading = false;

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.Login) {
      AuthenticationRemote().login(email.text, password.text);
    } else {
      AuthenticationRemote()
          .register(email.text, password.text, confirmPassword.text);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/3.png'),
                    scale: 6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              child: TextFormField(
                controller: email,
                focusNode: _focusNode1,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
            ),
            Container(
              width: 300,
              child: TextFormField(
                controller: password,
                focusNode: _focusNode2,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            if (_authMode == AuthMode.Signup)
              Container(
                width: 300,
                child: TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  controller: confirmPassword,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              ElevatedButton(
                child: Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                onPressed: _submit,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green),
                ),
              ),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
