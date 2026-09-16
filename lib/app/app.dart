import 'package:flutter/material.dart';
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
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'FieldTrust',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF111827),
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Trusted proof from the field.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF667085),
                    ),
              ),
              const SizedBox(height: 32),
              ShadButton(
                width: double.infinity,
                onPressed: () {},
                child: const Text('Create first project'),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Local-first foundation',
                  style: TextStyle(color: Color(0xFF667085)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
