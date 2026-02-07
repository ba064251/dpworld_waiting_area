import '../../index.dart';


class CustomField extends StatelessWidget {
  const CustomField({super.key, required this.passwordController, required this.errorMessage, required this.hintText});

  final TextEditingController passwordController;
  final String errorMessage;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      validator: (val){
        if(val == null || val.isEmpty || val == " "){
          return errorMessage;
        } else{
          return null;
        }
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: bgColor,
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor),
              borderRadius: BorderRadius.circular(20)
          ),
      ),
    );
  }
}
