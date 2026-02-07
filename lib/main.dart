import 'package:dp_world_waiting_area/views/ticket_screen_app.dart';

import '../index.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Force landscape mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await Hive.initFlutter();
  await Hive.openBox("CounterBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> CallingProvider()),
        ChangeNotifierProvider(create: (context)=> IPManager()),
      ],
      child: MaterialApp(
        // home: SplashScreen(),
        home: TicketScreenApp(),
        debugShowCheckedModeBanner: false
      ),
    );
  }
}


