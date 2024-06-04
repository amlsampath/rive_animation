import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// Main login screen widget
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// State for the login screen
class _LoginScreenState extends State<LoginScreen> {
  // Controllers for the username and password input fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Rive animation controllers
  StateMachineController? controller;
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // Get the screen size
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA), // Set background color
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(12.0), // Add padding around the main content
          child: SizedBox(
            width: size.width, // Use full width of the screen
            height: size.height, // Use full height of the screen
            child: Column(
              children: [
                const SizedBox(
                  height: 30, // Add some space at the top
                ),
                const Text(
                  "Welcome to \nAll In One ToolKit Pro", // Welcome text
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
                SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: RiveAnimation.asset(
                    'images/animation/animation.riv', // Path to the Rive animation asset
                    stateMachines: const [
                      'Login Machine'
                    ], // Name of the state machine in the Rive file
                    onInit: (artboard) {
                      // Initialize the Rive animation controllers
                      controller = StateMachineController.fromArtboard(
                          artboard, 'Login Machine');

                      if (controller == null) return;

                      artboard.addController(controller!);

                      isChecking = controller!.findInput('isChecking');
                      isHandsUp = controller!.findInput('isHandsUp');
                      trigSuccess = controller!.findInput('trigSuccess');
                      trigFail = controller!.findInput('trigFail');
                    },
                  ),
                ),
                TextField(
                  controller:
                      usernameController, // Bind the username controller
                  onChanged: (value) {
                    // Update Rive animation state on text change
                    if (isHandsUp != null) {
                      isHandsUp!.change(false);
                    }

                    if (isChecking != null) {
                      isChecking!.change(true);
                    }
                  },
                  keyboardType:
                      TextInputType.emailAddress, // Set keyboard type to email
                  decoration: InputDecoration(
                    hintText: "E mail", // Hint text for the input field
                    prefixIcon:
                        const Icon(Icons.mail), // Icon for the input field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded border
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10, // Add space between input fields
                ),
                TextField(
                  controller:
                      passwordController, // Bind the password controller
                  onChanged: (value) {
                    // Update Rive animation state on text change
                    if (isChecking != null) {
                      isChecking!.change(false);
                    }

                    if (isHandsUp != null) {
                      isHandsUp!.change(true);
                    }
                  },
                  obscureText: true, // Hide password
                  decoration: InputDecoration(
                    hintText: "Password", // Hint text for the input field
                    prefixIcon:
                        const Icon(Icons.lock), // Icon for the input field
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded border
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () {
                    // Login button action
                    if (isChecking != null) {
                      isChecking!.change(false);
                    }

                    if (isHandsUp != null) {
                      isHandsUp!.change(false);
                    }

                    print(usernameController.text);

                    // Check login credentials
                    if (usernameController.text == "admin" &&
                        passwordController.text == "12345") {
                      if (trigFail != null) {
                        trigFail!.change(false);
                      }

                      trigSuccess!.change(true);
                    } else {
                      if (trigSuccess != null) {
                        trigSuccess!.change(false);
                      }

                      trigFail!.change(true);
                    }
                  },
                  minWidth: size.width, // Full width for the button
                  height: 50, // Set height for the button
                  color: const Color.fromARGB(159, 0, 25, 93), // Button color
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12)), // Rounded corners
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Add space
                SizedBox(
                  width: size.width, // Full width
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't you have an account?"),
                      TextButton(
                        onPressed: () {
                          // Register button action
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
    );
  }
}
