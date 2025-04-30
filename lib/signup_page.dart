import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();

  String _message = '';
  bool _isLoading = false;
  bool _emailVerified = false;

  final String baseUrl = 'https://aidoctorgreen.com';

  Future<void> _sendVerificationCode() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _message = '이메일을 입력해주세요.');
      return;
    }

    final url = Uri.parse('$baseUrl/api/m/send-verification');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      final data = jsonDecode(response.body);
      setState(() => _message = data['message'] ?? '전송 실패');
    } catch (e) {
      setState(() => _message = '전송 오류: $e');
    }
  }

  Future<void> _verifyCode() async {
    final email = _emailController.text.trim();
    final code = _codeController.text.trim();

    final url = Uri.parse('$baseUrl/api/m/verify-code');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'code': code}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          _message = '인증 성공';
          _emailVerified = true;
        });
      } else {
        setState(() {
          _message = data['message'] ?? '인증 실패';
        });
      }
    } catch (e) {
      setState(() => _message = '인증 오류: $e');
    }
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (!_emailVerified) {
      setState(() => _message = "이메일 인증을 먼저 완료해주세요.");
      return;
    }

    if (email.isEmpty || password.isEmpty) {
      setState(() => _message = "이메일과 비밀번호를 입력해주세요.");
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    final url = Uri.parse('$baseUrl/api/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final res = jsonDecode(response.body);

      if (response.statusCode == 201) {
        setState(() => _message = "회원가입 성공!");
        Navigator.pop(context);
      } else {
        setState(() => _message = res['message'] ?? '회원가입 실패');
      }
    } catch (e) {
      setState(() => _message = '회원가입 오류: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 32,
            left: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: Container(
              width: 400,
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: '이메일',
                      labelStyle: textStyle,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _sendVerificationCode,
                    child: Text('인증 코드 발송'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      labelText: '인증 코드',
                      labelStyle: textStyle,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _verifyCode,
                    child: Text('인증 코드 확인'),
                  ),
                  Divider(height: 32),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: textStyle,
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child:
                          _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text('회원가입'),
                    ),
                  ),
                  if (_message.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        _message,
                        style: TextStyle(
                          color: _emailVerified ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
