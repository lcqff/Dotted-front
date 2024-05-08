import 'package:dotted/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:dotted/login/utils/login_platform.dart';
import 'package:flutter/cupertino.dart';
import '../widget/login_button.dart';
import '../widget/logout_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;
  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    print("로그인 화면");

    return Scaffold(
      body: Center(
        child: _loginPlatform != LoginPlatform.none
            ? LogoutButton(
          loginPlatform: _loginPlatform,
          onLogout: _loginService.handleLogout,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginButton(
                imagePath: 'kakao_login', onTap: _loginService.signInWithKakao),
          ],
        ),
      ),
    );
  }

  void setLoginPlatform(LoginPlatform platform) {
    setState(() {
      _loginPlatform = platform;
    });
  }
}
