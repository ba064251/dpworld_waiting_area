

import 'package:http/http.dart' as http;

import '../../index.dart';

class ApiServices{

  Future getIP()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var ip = sp.getString('ip');
    return ip;
  }

  Future getWebIP()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    var webIP = sp.getString('webIP');
    return webIP;
  }

  Future markTicketAsCalled(int tokenID)async{
    final baseURL = await getIP();
    try{
      final url = Uri.parse('$baseURL/api/mark-ticket-as-called');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = json.encode({"TicketID": tokenID});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final res = response.body;
        try {
          final data = jsonDecode(res);
          debugPrint('Token Called: $data');
        } catch (error) {
          debugPrint('Error: $error');
        }
      }
      else {
        debugPrint(response.reasonPhrase);
      }
    } catch(e){
      debugPrint(e.toString());
    }
  }

}