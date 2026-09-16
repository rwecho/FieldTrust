import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FieldTrustApp extends StatelessWidget {
  const FieldTrustApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      title: 'FieldTrust',
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadGreenColorScheme.light(),
      ),
      home: const _FoundationScreen(),
    );
  }
}

class _FoundationScreen extends StatelessWidget {
  const _FoundationScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Center(
                child: SvgPicture.asset(
                  'assets/branding/fieldtrust-icon.svg',
                  width: 116,
                  height: 116,
                  semanticsLabel: 'FieldTrust logo',
                ),
              ),
              const SizedBox(height: 28),
              Center(
                child: SvgPicture.asset(
                  'assets/branding/fieldtrust-wordmark.svg',
                  width: 228,
                  semanticsLabel: 'FieldTrust',
                ),
              ),
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  'Trusted proof from the field.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF61706A),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ShadButton(
                width: double.infinity,
                onPressed: () {},
                child: const Text('Create first project'),
              ),
              const SizedBox(height: 14),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, size: 16, color: Color(0xFF61706A)),
                  SizedBox(width: 6),
                  Text(
                    'Local-first · Offline-ready',
                    style: TextStyle(color: Color(0xFF61706A)),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
