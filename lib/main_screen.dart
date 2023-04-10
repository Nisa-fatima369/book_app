import 'package:book_app/sign_in.dart';
import 'package:book_app/sign_up.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.93,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset('assets/images/main.png'),
                    ),
                    Positioned(
                      left: 100,
                      right: 100,
                      top: 190,
                      child: Text(
                        'Book Basket',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 46,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      height: 55,
                      top: 350,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) {
                                return const SignIn();
                              }),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.teal,
                          ),
                        ),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      right: 50,
                      top: 420,
                      height: 55,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => SignUp()),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.teal,
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
