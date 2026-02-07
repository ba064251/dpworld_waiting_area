

import '../../index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    // Delay to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {

      apiServices.getIP().then((val){
        if(val==null){
          Timer(
            const Duration(seconds: 5),
                () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const PasswordScreen()),
            ),
          );
        } else{
          apiServices.getWebIP().then((val){
            // Timer(
            //   const Duration(seconds: 5),
            //       () => Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (_) =>  CounterScreenWebView(url: val,)),
            //   ),
            // );

            Timer(
              const Duration(seconds: 5),
                  () => Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) =>  CounterScreenApp()),
              // ),
                    context,
                    MaterialPageRoute(builder: (_) =>  CounterScreenApp
                      ()),
                  ),
            );
          });
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/dp_world_logo.png')),
    );
  }
}
