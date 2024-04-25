import 'dart:convert';

import 'package:dotted/login/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:dotted/login/utils/login_platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import '../../home/screens/home_screen.dart';
import '../widget/login_button.dart';
import '../widget/logout_button.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

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
                onLogout: _handleLogout,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginButton(
                      imagePath: 'kakao_login', onTap: _signInWithKakao),
                ],
              ),
      ),
    );
  }

  Future<void> _signInWithKakao() async {
    try {
      final clientState = Uuid().v4();
      final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
        'response_type': 'code',
        'client_id': dotenv.env['KAKAO_NATIVE_APP_KEY'],
        'redirect_uri': dotenv.env['REDIRECT_URL'],
        'state': clientState,
      });

      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: "webauthcallback");

      final body = Uri.parse(result).queryParameters;

      final Map<String, dynamic> responseBody = json.decode(body as String);
      final userId = responseBody['userId'];
      final token = responseBody['token'];

    } catch (error) {
      print('카카오톡 로그인 실패 $error');
    }
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

void _handleLoginResponse(BuildContext context) {
  Navigator.pop(context);
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}
