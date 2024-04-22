import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dotted/login/utils/login_platform.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';


class LoginService {
  Future<void> signInWithKakao(LoginPlatform _loginPlatform, Function(LoginPlatform) setLoginPlatform) async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();

      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final url = Uri.https('kapi.kakao.com', '/v2/user/me');

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
        },
      );
      final profileInfo = json.decode(response.body);
      print(profileInfo.toString());

      setLoginPlatform(LoginPlatform.kakao);

    } catch (error) {
      print('카카오톡 로그인 실패 $error');
    }
  }

  Future<void> signOut(LoginPlatform _loginPlatform, Function(LoginPlatform) setLoginPlatform) async {
    switch (_loginPlatform) {
      case LoginPlatform.google:
        break;
      case LoginPlatform.kakao:
        await UserApi.instance.logout();
      case LoginPlatform.none:
        break;
    }

    setLoginPlatform(LoginPlatform.none);
  }
}