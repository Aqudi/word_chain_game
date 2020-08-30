import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/constants.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';
import 'package:wordchaingame/utils/utils.dart';
import 'package:wordchaingame/validator.dart';
import 'package:wordchaingame/widgets/auth/base_auth_button.dart';
import 'package:wordchaingame/widgets/auth/base_auth_textfield.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  final betweenFieldSizedBox = SizedBox(height: 10);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmFocusNode = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseAuthProvider _auth;

  FirebaseUser user;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthProvider>(context);
    user = _auth.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "회원가입",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildSignUpForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
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
            focusNode: _emailFocusNode,
            onFieldSubmitted: (_) => FieldUtils.fieldFocusChange(
                context, _emailFocusNode, _passwordFocusNode),
          ),
          widget.betweenFieldSizedBox,
          BaseAuthTextField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            hintText: "password",
            controller: _passwordController,
            validator: Validator.validatePassword,
            focusNode: _passwordFocusNode,
            onFieldSubmitted: (_) => FieldUtils.fieldFocusChange(
                context, _passwordFocusNode, _passwordConfirmFocusNode),
          ),
          widget.betweenFieldSizedBox,
          BaseAuthTextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            prefixIcon: Icon(Icons.lock),
            hintText: "confirm password",
            controller: _passwordController,
            validator: (_) => Validator.validateConfirmPassword(
                _passwordController.text, _passwordConfirmController.text),
            onEditingComplete: () async => await _handleSignUp(),
            focusNode: _passwordConfirmFocusNode,
          ),
          widget.betweenFieldSizedBox,
          BaseAuthButton(
            buttonTitle: "Sign up",
            onPressed: () async => await _handleSignUp(),
          ),
          widget.betweenFieldSizedBox,
          widget.betweenFieldSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "계정을 이미 가지고 계신가요? ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              InkWell(
                child: Text(
                  "로그인",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff6bceff),
                  ),
                ),
                onTap: () => Navigator.pushNamed(context, loginRoute),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _handleSignUp() async {
    bool success = false;
    FocusScope.of(context).requestFocus(new FocusNode());
    try {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();

        success = await _auth.signUpWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
    } catch (e) {
      print(e);
      Get.snackbar(
        "회원가입에 실패했습니다ㅠㅠ",
        e.toString(),
        barBlur: 0,
      );
    }
    return success;
  }
}
