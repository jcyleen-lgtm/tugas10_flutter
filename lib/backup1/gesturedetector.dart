import 'package:flutter/material.dart';

void main() => runApp(const GestureApp());

class GestureApp extends StatelessWidget {
  const GestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Gesture Detector Demo')),
        body: const Center(child: GestureDemo()),
      ),
    );
  }
}

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  State<GestureDemo> createState() => _GestureDemoState();
}

class _GestureDemoState extends State<GestureDemo> {
  String _gestureText = 'Tap, Double Tap, or Long Press';
  Color _boxColor = Colors.blue;

  void _handleTap() {
    setState(() {
      _boxColor = Colors.green;
      _gestureText = 'Tap Gesture!';
    });
  }

  void _handleDoubleTap() {
    setState(() {
      _boxColor = Colors.orange;
      _gestureText = 'Double Tap Gesture!';
    });
  }

  void _handleLongPress() {
    setState(() {
      _boxColor = Colors.purple;
      _gestureText = 'Long Press Gesture!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _handleTap,
          onDoubleTap: _handleDoubleTap,
          onLongPress: _handleLongPress,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: _boxColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                _gestureText,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Last Action: $_gestureText',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        const Text(
          'Try: Tap, Double Tap, or Long Press the box',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}