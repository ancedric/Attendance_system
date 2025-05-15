import 'package:http/http.dart' as http;
//import '../constants/api_config.dart'; // Vous pouvez supprimer cet import

class ApiService {
  static String? _pcIpAddress;

  static String get apiBaseUrl {
    if (_pcIpAddress == null || _pcIpAddress!.isEmpty) {
      // Fournir une URL par défaut ou gérer le cas où l'IP n'a pas été scannée
      return 'http://default_or_error_url:port';
    }
    return 'http://$_pcIpAddress:8082'; // Remplacez VOTRE_PORT_API
  }

  static void setPcIpAddress(String ipAddress) {
    _pcIpAddress = ipAddress;
  }

  static Future<http.Response> addParticipant({
    required String userRef,
    required String sessionRef,
    required String date,
    required String arrivalTime,
  }) async {
    return await http.post(
      Uri.parse('${ApiService.apiBaseUrl}/participants/add-participant'),
      body: {
        "userRef": userRef,
        "sessionRef": sessionRef,
        "date": date,
        "arrivalTime": arrivalTime,
      },
    );
  }

  static Future<http.Response> updateDeparture({
    required String userRef,
    required String sessionRef,
    required String departureTime,
  }) async {
    return await http.post(
      Uri.parse('${ApiService.apiBaseUrl}/participants/update-departure'),
      body: {
        "userRef": userRef,
        "sessionRef": sessionRef,
        "departureTime": departureTime,
      },
    );
  }
}