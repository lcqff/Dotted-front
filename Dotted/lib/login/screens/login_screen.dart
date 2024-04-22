import 'package:dotted/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:dotted/login/utils/login_platform.dart';
import 'package:flutter/cupertino.dart';

import '../widget/login_button.dart';
import '../widget/logout_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  printlog() {
    print("로그인화면");
  }

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginPlatform _loginPlatform = LoginPlatform.none;

  final LoginService _loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loginPlatform != LoginPlatform.none
            ? LogoutButton(
                loginPlatform: _loginPlatform,
                onLogout: _handleLogout,
               )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoginButton(
              imagePath: 'kakao_login',
              onTap: _signInWithKakao
            ),
          ],
        ),
      ),
    );
  }

  void _signInWithKakao() {
    _loginService.signInWithKakao(_loginPlatform, _setLoginPlatform);
  }

  void _handleLogout(LoginPlatform platform) {
    _loginService.signOut(platform, _setLoginPlatform);
  }


  void _setLoginPlatform(LoginPlatform platform) {
    setState(() {
      _loginPlatform = platform;
    });
  }
}