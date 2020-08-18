import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';
import 'package:wordchaingame/validator.dart';
import 'package:wordchaingame/widgets/auth/base_auth_button.dart';
import 'package:wordchaingame/widgets/auth/base_auth_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  final betweenFieldSizedBox = SizedBox(height: 10);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseAuthProvider _auth;

  FirebaseUser user;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthProvider>(context);
    user = _auth.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "로그인",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _buildLoginForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          widget.betweenFieldSizedBox,
          BaseAuthTextField(
            textInputAction: TextInputAction.next,
            prefixIcon: Icon(Icons.email),
            hintText: "exmaple@example.com",
            controller: _emailController,
            validator: Validator.validateEmail,
          ),
          widget.betweenFieldSizedBox,
          BaseAuthTextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            hintText: "password",
            controller: _passwordController,
            validator: Validator.validatePassword,
            onEditingComplete: () async => await _handleLogin(),
          ),
          widget.betweenFieldSizedBox,
          BaseAuthButton(
            buttonTitle: "Login",
            onPressed: () async => await _handleLogin(),
          ),
          widget.betweenFieldSizedBox,
          widget.betweenFieldSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "계정이 없으신가요? ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              InkWell(
                child: Text(
                  "회원가입",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff6bceff),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, signupRoute),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _handleLogin() async {
    bool success = false;
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      success = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
    return success;
  }
}
