import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // - On Windows: run `ipconfig` in CMD → look for "IPv4 Address"
  // - On Mac/Linux: run `ifconfig` → look for "inet" under Wi-Fi section
  static const String baseUrl = "http://192.168.0.158:8000";
 // 👈 change this

  // ------------------- Data -------------------
  static Future<Map<String, dynamic>> postReading(Map<String, dynamic> payload) async {
    final url = Uri.parse('$baseUrl/data/post-reading');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    return _parse(res);
  }

  static Future<Map<String, dynamic>> getReadings() async {
    final url = Uri.parse('$baseUrl/data/get-readings');
    final res = await http.get(url);
    return _parse(res);
  }

  // ------------------- Control -------------------
  static Future<Map<String, dynamic>> sendCommand(String deviceId, String action) async {
    final url = Uri.parse('$baseUrl/control/send-command');
    final body = jsonEncode({'device_id': deviceId, 'action': action});
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    return _parse(res);
  }

  // ------------------- AI -------------------
  static Future<Map<String, dynamic>> predictDustRisk(double pm25, double co2, double battery) async {
    final url = Uri.parse('$baseUrl/ai/predict-dust-risk');
    final body = jsonEncode({'pm25': pm25, 'co2': co2, 'battery': battery});
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    return _parse(res);
  }

  // ------------------- Impact / Reports -------------------
  static Future<Map<String, dynamic>> downloadWeeklyReport() async {
    // optional placeholder
    final url = Uri.parse('$baseUrl/impact/download-weekly');
    final res = await http.get(url);
    return _parse(res);
  }

  // ------------------- Helpers -------------------
  static Map<String, dynamic> _parse(http.Response res) {
    try {
      final body = res.body.isNotEmpty ? jsonDecode(res.body) : {};
      if (res.statusCode >= 200 && res.statusCode < 300) {
        return {'ok': true, 'data': body};
      } else {
        return {'ok': false, 'status': res.statusCode, 'error': body};
      }
    } catch (e) {
      return {'ok': false, 'error': 'invalid_response', 'raw': res.body};
    }
  }
}
