import 'package:flutter/material.dart';

import '../service/login_service.dart';
import '../utils/login_platform.dart';

class LogoutButton extends StatelessWidget {
  final LoginPlatform loginPlatform;
  final Function(LoginPlatform) onLogout;

  const LogoutButton({
    required this.loginPlatform,
    required this.onLogout,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleLogout(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          const Color(0xff0165E1),
        ),
      ),
      child: const Text('로그아웃'),
    );
  }

  void _handleLogout() {
    LoginService loginService = LoginService();
    loginService.signOut(loginPlatform, onLogout);
  }
}