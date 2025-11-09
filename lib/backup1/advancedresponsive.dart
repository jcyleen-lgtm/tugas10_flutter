import 'package:flutter/material.dart';

void main() => runApp(const AdvancedResponsiveApp());

class AdvancedResponsiveApp extends StatelessWidget {
  const AdvancedResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Advanced Responsive Demo')),
        body: const AdvancedResponsiveLayout(),
      ),
    );
  }
}

class AdvancedResponsiveLayout extends StatelessWidget {
  const AdvancedResponsiveLayout({super.key});

  Widget _buildGridItem(int index, bool isWide) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.primaries[index % Colors.primaries.length],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: isWide ? 40 : 30,
              color: Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              'Item ${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isWide ? 18 : 14,
              ),
            ),
            if (isWide) ...[
              const SizedBox(height: 5),
              Text(
                'Additional info',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 800;
          final bool isMedium = constraints.maxWidth > 500;
          final int crossAxisCount = isWide ? 4 : (isMedium ? 3 : 2);
          final double aspectRatio = isWide ? 1.2 : (isMedium ? 1.0 : 0.8);

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      isWide ? Icons.desktop_windows :
                      isMedium ? Icons.tablet : Icons.phone_android,
                      color: Colors.blue,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isWide ? 'Desktop Layout' :
                          isMedium ? 'Tablet Layout' : 'Mobile Layout',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Max Width: ${constraints.maxWidth.toInt()}px | '
                              'Grid: ${crossAxisCount}x',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return _buildGridItem(index, isWide);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}