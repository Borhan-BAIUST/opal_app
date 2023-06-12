import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                "Otp Screen",
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 64,width: 64,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly],
                        ),),
                    SizedBox(height: 64,width: 64,
                      child: TextFormField(),),
                    SizedBox(height: 64,width: 64,
                      child: TextFormField(),),
                    SizedBox(height: 64,width: 64,
                      child: TextFormField(),),
                  ],
                )),
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtpScreen()),
                    );
                  },
                  child: Text("Send Otp"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
