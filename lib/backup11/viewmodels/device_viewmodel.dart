import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/device_model.dart';

class DeviceViewModel extends ChangeNotifier {
  List<DeviceModel> _devices = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<DeviceModel> get devices => _devices;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // API endpoint
  static const String apiUrl = 'https://api.restful-api.dev/objects';

  // ===== READ (GET) =====
  Future<void> fetchDevices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
        convert.jsonDecode(response.body) as List<dynamic>;
        _devices = jsonList
            .map((e) => DeviceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        _errorMessage =
        'Failed to load devices. Status code: ${response.statusCode}';
        _devices = [];
      }
    } catch (e) {
      _errorMessage = 'Error fetching devices: $e';
      _devices = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshDevices() async => fetchDevices();

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ===== CREATE (POST) =====
  Future<bool> addDevice({
    required String name,
    required int year,
    required double price,
    required String cpuModel,
    required String hddSize,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final uri = Uri.https('api.restful-api.dev', '/objects');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'DeviceStore/1.0 (+flutter)'
    };
    final body = convert.jsonEncode({
      "name": name,
      "data": {
        "year": year,
        "price": price,
        "CPU model": cpuModel,
        "Hard disk size": hddSize
      }
    });

    try {
      final res = await http
          .post(uri, headers: headers, body: body)
          .timeout(const Duration(seconds: 12));

      if (res.statusCode == 200 || res.statusCode == 201) {
        final map = convert.jsonDecode(res.body) as Map<String, dynamic>;
        _devices.insert(0, DeviceModel.fromJson(map));
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'POST failed: ${res.statusCode}';
        return false;
      }
    } catch (e) {
      _errorMessage = 'POST error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // ===== UPDATE (PUT) =====
  Future<void> updateDevice(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(data),
      );

      if (res.statusCode == 200) {
        final Map<String, dynamic> body =
        convert.jsonDecode(res.body) as Map<String, dynamic>;
        final updated = DeviceModel.fromJson(body);
        final idx = _devices.indexWhere((d) => d.id == id);
        if (idx != -1) _devices[idx] = updated;
      } else {
        _errorMessage = 'PUT failed: ${res.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'PUT error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ===== DELETE =====
  Future<void> deleteDevice(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final res = await http.delete(Uri.parse('$apiUrl/$id'));
      if (res.statusCode == 200) {
        _devices.removeWhere((d) => d.id == id);
      } else {
        _errorMessage = 'DELETE failed: ${res.statusCode}';
      }
    } catch (e) {
      _errorMessage = 'DELETE error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
