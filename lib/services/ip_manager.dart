
import 'package:http/http.dart' as http;
import '../../index.dart';

class IPManager extends ChangeNotifier{

  bool isPasswordCorrect = false;
  String? message;

  void validatePassword(){
    isPasswordCorrect = true;
    notifyListeners();
  }

  void setMessage(String value){
    message = value;
    notifyListeners();
  }

  setBothIP(String ip, String web, BuildContext context)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('webIP', web);
    sp.setString('ip', ip);
    message = "IP Registered: $ip, $web";
    notifyListeners();
    if(!context.mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => CounterScreenApp(),));
  }

  Future<void> testConnection(String value)async{
    try{
      message = "Connecting...";
      notifyListeners();
      var request = http.Request('POST', Uri.parse('$value/api/get-categories'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        final data = jsonDecode(res);
        message = "Status 200: $data";
      }
      else {
        message = response.reasonPhrase.toString();
      }
    } catch(e){
      message = e.toString();
    } finally{
      notifyListeners();
    }
  }

}