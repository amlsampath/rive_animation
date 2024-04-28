import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                   SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: RiveAnimation.asset(
                      'images/animated_login_character.riv',
                      stateMachines: const ['Login Machine'],
                      onInit: (artboard) {
                          controller =  StateMachineController.fromArtboard(artboard, 'Login Machine');

                          if(controller == null) return;

                          artboard.addController(controller!);

                          isChecking = controller!.findInput('isChecking');
                          isHandsUp = controller!.findInput('isHandsUp');
                          trigSuccess = controller!.findInput('trigSuccess');
                          trigFail = controller!.findInput('trigFail');
                      },
                      ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    onChanged: (value) {
                      if(isHandsUp != null){
                            isHandsUp!.change(false);
                      }

                      if(isChecking != null){
                            isChecking!.change(true);
                      }

                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "E mail",
                      prefixIcon: const Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) {

                      if(isChecking != null){
                            isChecking!.change(false);
                      }

                      if(isHandsUp != null){
                            isHandsUp!.change(true);
                      }

          
                    },
                    obscureText: true, // to hide password
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
              
                  SizedBox(
                    width: size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
              
                        },
                        child: const Text(
                          "Forgot your password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MaterialButton(
                    minWidth: size.width,
                    height: 50,
                    color: const Color.fromARGB(159, 152, 22, 100),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    onPressed: () {


                     if(isChecking != null){
                            isChecking!.change(false);
                      }

                      if(isHandsUp != null){
                            isHandsUp!.change(false);
                      }

                    print(usernameController.text);

                      if(usernameController.text=="admin" && passwordController.text =="12345"){
 
                        if ( trigFail != null) {
                          trigFail!.change(false);
                        }
        
                        trigSuccess!.change(true);
                     
                      }else{
                          if ( trigSuccess != null) {
                          trigSuccess!.change(false);
                        }

                        trigFail!.change(true);
                      }

                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white,fontSize: 25.0,),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't you have an account?"),
                        TextButton(
                          onPressed: () {
                            // todo register
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
