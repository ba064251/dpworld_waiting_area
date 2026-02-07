import '../../index.dart';


class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  final key = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController(text: 'admin911');
  final TextEditingController ipController = TextEditingController(text: 'http://192.168.1.80:7000');
  final TextEditingController webController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: key,
          child: Consumer<IPManager>(builder: (context, value, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('assets/dp_world_logo.png'),

                SizedBox(height: SizeConfig.textMultiplier * 4,),

                value.isPasswordCorrect ? SizedBox(
                  height: SizeConfig.screenHeight * 0.25,
                  child: Column(
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.6,
                        child: CustomField(
                          passwordController: ipController,
                          errorMessage: 'IP is required',
                          hintText: 'Enter IP with API Port',
                        ),
                      ),

                      // SizedBox(height: SizeConfig.heightMultiplier * 2),
                      //
                      // SizedBox(
                      //   width: SizeConfig.screenWidth * 0.6,
                      //   child: CustomField(
                      //     passwordController: webController,
                      //     errorMessage: 'Web IP is required',
                      //     hintText: 'Enter Web IP with APP Port',
                      //   ),
                      // ),

                    ],
                  ),
                ): SizedBox(
                  width: SizeConfig.screenWidth * 0.6,
                  child: CustomField(
                    passwordController: passwordController,
                    errorMessage: 'Password is required',
                    hintText: 'Enter Password',
                  ),
                ),

                SizedBox(height: SizeConfig.textMultiplier * 2,),

                value.isPasswordCorrect ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(secondaryColor)
                        ),
                        onPressed: ()async{
                          await LaunchApp.openApp(androidPackageName: 'com.android.settings');
                    }, child: Text("Open Settings", style: TextStyle(color: bgColor),)),

                    SizedBox(width: SizeConfig.widthMultiplier * 2,),

                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(secondaryColor)
                        ),
                        onPressed: ()async{
                          if(key.currentState!.validate()){
                            Provider.of<IPManager>(context, listen: false).testConnection(ipController.text);
                          }
                        }, child: Text("Test IP Connection", style: TextStyle(color: bgColor),)),


                    SizedBox(width: SizeConfig.widthMultiplier * 2,),

                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(secondaryColor)
                        ),
                        onPressed: (){
                          if(key.currentState!.validate()){
                            Provider.of<IPManager>(context, listen: false).setBothIP(ipController.text,webController.text, context);
                          }
                        }, child: Text("Register IP", style: TextStyle(color: bgColor),))
                  ],
                ): ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(secondaryColor)
                  ),
                    onPressed: (){
                  if(key.currentState!.validate()){
                    if(passwordController.text == "admin911") {
                      Provider.of<IPManager>(context, listen: false).validatePassword();
                      Provider.of<IPManager>(context, listen: false).setMessage("");
                    } else{
                      Provider.of<IPManager>(context, listen: false).setMessage("Typed Password is Incorrect: ${passwordController.text}");
                    }
                  }
                }, child: Text("Validate Password", style: TextStyle(color: bgColor),)),

                SizedBox(width: SizeConfig.widthMultiplier * 1,),

                Text(value.message ?? '')

              ],
            );
          },)
        ),
      ),
    );
  }
}
