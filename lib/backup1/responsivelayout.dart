import 'package:flutter/material.dart';

void main() => runApp(const ResponsiveApp());

class ResponsiveApp extends StatelessWidget {
  const ResponsiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Responsive Layout Demo')),
        body: const ResponsiveLayout(),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  Widget _buildPhoneLayout() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length],
              child: Text('${index + 1}', style: const TextStyle(color:
              Colors.white)),
            ),
            title: Text('Phone Item ${index + 1}'),
            subtitle: const Text('This is optimized for mobile devices'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }

  Widget _buildTabletLayout() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.tablet_mac,
                size: 50,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              const SizedBox(height: 10),
              Text(
                'Tablet Item ${index + 1}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text('Optimized for tablets'),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width > 600;
    final bool isLandscape = size.width > size.height;

    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          // Device Info Panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Screen Size: ${size.width.toInt()} x ${size.height.toInt()}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Chip(
                      backgroundColor: isTablet ? Colors.green[100] :
                      Colors.blue[100],
                      label: Text(
                        'Device: ${isTablet ? 'Tablet' : 'Phone'}',
                        style: TextStyle(
                          color: isTablet ? Colors.green[800] : Colors.blue[800],
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: isLandscape ? Colors.orange[100] :
                      Colors.purple[100],
                      label: Text(
                        'Orientation: ${isLandscape ? 'Landscape' : 'Portrait'}',
                        style: TextStyle(
                          color: isLandscape ? Colors.orange[800] :
                          Colors.purple[800],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: isTablet ? _buildTabletLayout() : _buildPhoneLayout(),
          ),
        ],
      ),
    );
  }
}