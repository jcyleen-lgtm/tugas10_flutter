import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/device_viewmodel.dart';
import '../models/device_model.dart';

class DeviceGridView extends StatefulWidget {
  const DeviceGridView({super.key});

  @override
  State<DeviceGridView> createState() => _DeviceGridViewState();
}

class _DeviceGridViewState extends State<DeviceGridView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DeviceViewModel>().fetchDevices();
    });
  }

  bool _isReadOnlyId(String id) => RegExp(r'^\d+$').hasMatch(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices Store'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<DeviceViewModel>().refreshDevices(),
            tooltip: 'Refresh',
          ),
        ],
      ),

      body: Consumer<DeviceViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null && viewModel.devices.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text(
                    viewModel.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.fetchDevices(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.devices.isEmpty) {
            return const Center(child: Text('No devices available'));
          }

          return RefreshIndicator(
            onRefresh: () => viewModel.refreshDevices(),
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: viewModel.devices.length,
              itemBuilder: (context, index) {
                return _buildDeviceCard(viewModel.devices[index]);
              },
            ),
          );
        },
      ),

      // ADD (POST)
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final vm = context.read<DeviceViewModel>();
          final ok = await vm.addDevice(
            name: 'Apple MacBook Pro 16',
            year: 2019,
            price: 1849.99,
            cpuModel: 'Intel Core i9',
            hddSize: '1 TB',
          );
          _snack(ok ? 'Device added' : 'Add failed: ${vm.errorMessage ?? "network"}');
        },
      ),
    );
  }

  Widget _buildDeviceCard(DeviceModel device) {
    final readOnly = _isReadOnlyId(device.id);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showDeviceDetails(device),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getDeviceIcon(device.name),
                  size: 50,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 8),

              // Name
              Expanded(
                child: Text(
                  device.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4),

              // Color
              if (device.getColor() != null)
                Row(
                  children: [
                    const Icon(Icons.palette, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        device.getColor()!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

              // Price
              if (device.getPrice() != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    device.getPrice()!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              // Actions
              if (readOnly)
                Text('read-only', style: TextStyle(fontSize: 11, color: Colors.grey[600]))
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      tooltip: 'Edit',
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        final vm = context.read<DeviceViewModel>();
                        await vm.updateDevice(device.id, {
                          "name": device.name,
                          "data": {
                            "year": 2019,
                            "price": 2049.99,
                            "CPU model": "Intel Core i9",
                            "Hard disk size": "1 TB",
                            "color": "silver",
                          }
                        });
                        _snack(vm.errorMessage == null ? 'Updated' : 'Error ${vm.errorMessage}');
                      },
                    ),
                    IconButton(
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final ok = await _confirmDelete(device.name);
                        if (ok != true) return;
                        final vm = context.read<DeviceViewModel>();
                        await vm.deleteDevice(device.id);
                        _snack(vm.errorMessage == null ? 'Deleted' : 'Error ${vm.errorMessage}');
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String name) {
    final nameLower = name.toLowerCase();
    if (nameLower.contains('iphone') || nameLower.contains('pixel')) {
      return Icons.smartphone;
    } else if (nameLower.contains('macbook') || nameLower.contains('laptop')) {
      return Icons.laptop_mac;
    } else if (nameLower.contains('ipad') || nameLower.contains('tablet')) {
      return Icons.tablet_mac;
    } else if (nameLower.contains('watch')) {
      return Icons.watch;
    } else if (nameLower.contains('airpods') || nameLower.contains('beats')) {
      return Icons.headphones;
    } else if (nameLower.contains('fold')) {
      return Icons.phone_android;
    } else {
      return Icons.devices;
    }
  }

  void _showDeviceDetails(DeviceModel device) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(device.name),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('ID: ${device.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const Text('Details:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(device.getDetails()),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
          ],
        );
      },
    );
  }

  void _snack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<bool?> _confirmDelete(String name) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus Device?'),
        content: Text('Yakin hapus "$name"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Hapus')),
        ],
      ),
    );
  }
}
