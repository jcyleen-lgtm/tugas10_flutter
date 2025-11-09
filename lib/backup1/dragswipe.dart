import 'package:flutter/material.dart';

void main() => runApp(const DragApp());

class DragApp extends StatelessWidget {
  const DragApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Drag & Swipe Demo')),
        body: const DragDemo(),
      ),
    );
  }
}

class DragDemo extends StatefulWidget {
  const DragDemo({super.key});

  @override
  State<DragDemo> createState() => _DragDemoState();
}

class _DragDemoState extends State<DragDemo> {
  double _positionX = 0;
  double _positionY = 0;
  String _dragInfo = 'Drag the box!';
  double _startX = 0;
  double _startY = 0;

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _startX = _positionX;
      _startY = _positionY;
      _dragInfo = 'Drag started!';
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _positionX = _startX + details.delta.dx;
      _positionY = _startY + details.delta.dy;
      _dragInfo = 'Dragging... X: ${_positionX.toInt()}, Y: ${_positionY.toInt()}';
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _dragInfo = 'Drag ended! Velocity: ${details.velocity.pixelsPerSecond}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: _positionX,
          top: _positionY,
          child: GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.touch_app, color: Colors.white, size: 40),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              _dragInfo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}