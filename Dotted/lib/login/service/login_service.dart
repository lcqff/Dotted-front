import 'dart:convert';

import 'package:dotted/login/utils/login_platform.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';

import '../../home/screens/home_screen.dart';

class LoginService {
  Future<void> signInWithKakao() async {
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

  void handleLogout(LoginPlatform platform) {}

  void handleLoginResponse(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
