import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  developer.log('=== GGs BOOT TEST: WidgetsBinding initialized ===', name: 'GGsBoot');

  FlutterError.onError = (FlutterErrorDetails details) {
    developer.log('=== GGs BOOT TEST FLUTTER ERROR: ${details.exception} ===', name: 'GGsBoot');
    FlutterError.presentError(details);
  };

  WidgetsBinding.instance.addPostFrameCallback((_) {
    developer.log('=== GGs BOOT TEST: First frame rendered successfully! ===', name: 'GGsBoot');
  });

  runApp(const GGsBootTestApp());
}

class GGsBootTestApp extends StatefulWidget {
  const GGsBootTestApp({super.key});

  @override
  State<GGsBootTestApp> createState() => _GGsBootTestAppState();
}

class _GGsBootTestAppState extends State<GGsBootTestApp> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GGs Boot Test',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B0000),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'GGs DIAGNOSTIC BOOT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'GGs BOOT TEST',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'If you see this screen, the Flutter Android engine,\nSurfaceView, and GPU renderer are working correctly.',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B0000),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _counter++;
                      });
                      developer.log('=== GGs BOOT TEST: Button tapped! Counter: $_counter ===', name: 'GGsBoot');
                    },
                    child: Text(
                      _counter == 0 ? 'TAP TO TEST INTERACTION' : 'TAPPED $_counter TIMES (OK!)',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

