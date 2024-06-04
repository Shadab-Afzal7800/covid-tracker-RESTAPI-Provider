import 'dart:convert';
import 'dart:io';

import 'package:covid_tracker/models/world_states.dart';
import 'package:covid_tracker/services/utilities/app_urls.dart';
import 'package:http/io_client.dart';

class StatesServices {
  Future<WorldStatesModel> fetchWorldsStatesRecord() async {
    // Bypass SSL verification (for debugging purposes only)
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    IOClient ioClient = IOClient(httpClient);

    try {
      final response = await ioClient.get(Uri.parse(AppUrls.worldStates));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load world states: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
