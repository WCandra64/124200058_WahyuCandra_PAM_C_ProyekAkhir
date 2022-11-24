import 'dart:convert';
import 'package:http/http.dart' as http;
class BaseNetwork{
  static final String baseUrl = 'https://superhero-search.p.rapidapi.com/api';

  static Future<Map<String, dynamic>> get(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        "X-RapidAPI-Key": "c3f9854666mshb0b31ab105df49dp15779ejsne810d00c6cc5",
        "X-RapidAPI-Host": "superhero-search.p.rapidapi.com"
      }
    );
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponse(response);
  }

  static Future<Map<String, dynamic>> _processResponse(http.Response response) async{
    final body = response.body;
    if (body.isNotEmpty){
      final jsonBody = json.decode(body);
      return jsonBody;
    }
    else {
      print("Process Response Error!");
      return {
        "error" : true
      };
    }
  }

  static Future<List<dynamic>> getList(String partUrl) async {
    final String fullUrl = baseUrl + "/" + partUrl;
    debugPrint("BaseNetwork - fullUrl : $fullUrl");
    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        "X-RapidAPI-Key": "c3f9854666mshb0b31ab105df49dp15779ejsne810d00c6cc5",
        "X-RapidAPI-Host": "superhero-search.p.rapidapi.com"
      }
    );
    debugPrint("BaseNetwork - response : ${response.body}");
    return _processResponseList(response);
  }

  static Future<List<dynamic>> _processResponseList(http.Response response) async{
    final body = response.body;
    if (body.isNotEmpty){
      final jsonBody = json.decode(body);
      return jsonBody;
    }
    else {
      print("Process Response Error!");
      return ["Error"];
    }
  }

  static void debugPrint(String value) {
    print("[BASE_NETWORK] - $value");
  }
}