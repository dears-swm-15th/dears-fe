import 'dart:io';

import 'package:dears/providers/auth_state_provider.dart';
import 'package:dears/utils/theme.dart';
import 'package:dears/widgets/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("assets/logo.png", width: 100),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    color: blue500,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "투명",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: "하고 "),
                    TextSpan(
                      text: "합리",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: "적인\n웨딩 준비 "),
                    TextSpan(
                      text: "Dears",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              if (Platform.isIOS) ...[
                SignInButton(
                  provider: const AppleOAuth2Provider(),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefix: const CustomPaint(
                    size: Size(18, 18 * (31 / 25)),
                    painter: AppleLogoPainter(color: Colors.white),
                  ),
                  title: const Text(
                    "Apple로 로그인",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: ".SF Pro Text",
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
              SignInButton(
                provider: const GoogleOAuth2Provider(),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: gray600),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefix: Image.asset(
                  "assets/g-logo.png",
                  width: 18,
                ),
                title: const Text("Google로 로그인"),
              ),
              const SizedBox(height: 10),
              SignInButton(
                provider: const KakaoOAuth2Provider(),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE500),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefix: Image.asset(
                  "assets/kakao_symbol.png",
                  width: 18,
                ),
                title: const Text("카카오로 로그인"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
