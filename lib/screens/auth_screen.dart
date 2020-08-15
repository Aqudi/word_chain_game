import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordchaingame/providers/firebase_auth_provider.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  final betweenFieldPadding =
      const EdgeInsets.symmetric(vertical: 10, horizontal: 10);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FirebaseAuthProvider _auth;

  FirebaseUser user;

  ValueNotifier<bool> _isLoginForm = ValueNotifier(true);

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
          child: ValueListenableBuilder(
            valueListenable: _isLoginForm,
            builder: (BuildContext context, bool isLoginForm, Widget widget) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLoginForm ? "로그인" : "회원가입",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isLoginForm ? _buildLoginForm() : _buildSignUpForm()
                ],
              );
            },
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
          Padding(padding: widget.betweenFieldPadding),
          _buildEmailField(),
          Padding(padding: widget.betweenFieldPadding),
          _buildPasswordField(),
          Padding(padding: widget.betweenFieldPadding),
          _buildLoginButton(),
          Padding(padding: widget.betweenFieldPadding),
          Padding(padding: widget.betweenFieldPadding),
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
                onTap: () => _isLoginForm.value = false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(padding: widget.betweenFieldPadding),
          _buildEmailField(),
          Padding(padding: widget.betweenFieldPadding),
          _buildPasswordField(),
          Padding(padding: widget.betweenFieldPadding),
          _buildPasswordConfirmField(),
          Padding(padding: widget.betweenFieldPadding),
          _buildSignUpButton(),
          Padding(padding: widget.betweenFieldPadding),
          Padding(padding: widget.betweenFieldPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "이미 계정이 있으신가요? ",
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
                onTap: () => _isLoginForm.value = true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: "example@example.com",
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _emailController,
      onSaved: (value) => _emailController.text = value.trim(),
      validator: (value) {
        if (!value.contains("@")) {
          return "올바른 이메일을 입력해주세요.";
        }
        if(value.contains(" ")){
          return "이메일에 공백이 있습니다.";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      style: TextStyle(fontFamily: ''),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'password',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _passwordController,
      onSaved: (value) => _passwordController.text = value.trim(),
      validator: (value) {
        if (value.length < 6) {
          return "비밀번호는 6자 이상만 가능합니다";
        }
        return null;
      },
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      style: TextStyle(fontFamily: ''),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'password',
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _passwordController,
      onSaved: (value) => _passwordController.text = value.trim(),
      validator: (value) {
        if (value.length < 6) {
          return "비밀번호는 6자 이상만 가능합니다";
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blueGrey,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
          }
          _handleLogin();
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.blueGrey,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
          }
          _handleSignUp();
        },
        child: Text("SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )),
      ),
    );
  }

  Future<void> _handleLogin() async {
    await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  Future<void> _handleSignUp() async {
    await _auth.signUpWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    _isLoginForm.value = true;
  }
}
