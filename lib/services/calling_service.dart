import 'package:http/http.dart' as http;

import '../../index.dart';


class CallingProvider with ChangeNotifier {
  final ApiServices apiServices = ApiServices();
  final List<Map> _audioQueue = [];
  final AudioPlayer _audioPlayer = AudioPlayer();

  Timer? _pollingTimer;
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;

  // Start polling every 2 seconds
  void startPolling() {
    _pollingTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      debugPrint("Roaming For Calling");
      if (!_isPlaying) {
        await getOldestInProcessTickets();
        if (_audioQueue.isNotEmpty) {
          debugPrint("Data to Call: $_audioQueue");
          _playAudioQueue();
        }
      }
    });
  }

  // Stop polling and dispose audio
  void stopPolling() {
    _pollingTimer?.cancel();
    _audioPlayer.dispose();
  }

  // Fetch new ticket/counter data
  Future<void> getOldestInProcessTickets() async {
    final baseURL = await apiServices.getIP();
    final Box box = Hive.box('CounterBox');

    try {
      final url = Uri.parse('$baseURL/api/get-oldest-in-process-tickets');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = json.encode({"branchId": 7});


      final response = await http.post(url, headers: headers, body: body);


      if (response.statusCode == 200) {
        final res = response.body;
        try {
          final data = jsonDecode(res);
          box.put("countersData", data);
          debugPrint(data);
          for (var item in data) {
            if (item['CalledFlag'] == 'N' && item['TicketNumber'] != "0000") {
              _audioQueue.add({
                'TicketNumber': item['TicketNumber'],
                'CounterID': item['CounterID'],
                'TicketID': item['TicketID']
              });
              debugPrint("Ticket Data: $_audioQueue");
            }
          }
        } catch (error) {
          debugPrint('Error: $error');
        }
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> getCategoryCounter() async {
    final baseURL = await apiServices.getIP();
    final Box box = Hive.box('CounterCategoryBox');

    try {
      final url = Uri.parse('$baseURL/api/get-category-counters');

      final headers = {
        'Content-Type': 'application/json',
      };

      final body = json.encode({"branchId": 7});


      final response = await http.post(url, headers: headers, body: body);


      if (response.statusCode == 200) {
        final res = response.body;
        try {
          final data = jsonDecode(res);
          box.put("countersCateData", data);
        } catch (error) {
          debugPrint('Error: $error');
        }
      } else {
        debugPrint('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }



  // Play all audios in the queue
  Future<void> _playAudioQueue() async {
    if (_audioQueue.isEmpty) return;
    _isPlaying = true;
    notifyListeners();

    while (_audioQueue.isNotEmpty) {
      final current = _audioQueue.removeAt(0);
      debugPrint("Playing: $current");
      await _playAudio(
        current['TicketNumber'],
        current['CounterID'],
        current['TicketID'],
      );
      if (_audioQueue.isNotEmpty) {
        _audioQueue.removeAt(0);
      }
    }

    _isPlaying = false;
    notifyListeners();
  }

  // Play single ticket + counter audio
  Future<void> _playAudio(var ticketNumber, var counterID, int ticketID) async {
    final tokenNumber = ticketNumber.toString();
    final counterNumber = counterID.toString();

    final tokenPath = 'tokens/token_$tokenNumber.mp3';
    final counterPath = 'counters/counter_$counterNumber.mp3';

    await _audioPlayer.play(AssetSource(tokenPath));

    await Future.delayed(Duration(
      milliseconds: tokenNumber.length == 3
          ? 2400
          : tokenNumber.length == 4
          ? 2800
          : 2000,
    ));

    await _audioPlayer.play(AssetSource(counterPath));

    await Future.delayed(Duration(
      milliseconds: counterNumber.length == 1 ? 2500 : 3500,
    ));

    await _audioPlayer.onPlayerComplete.first;
    await apiServices.markTicketAsCalled(ticketID);
    await Future.delayed(const Duration(seconds: 2));
  }

}
