import 'package:book_app/home.dart';
import 'package:book_app/main_screen.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool passwordVisible = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.teal,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    Reuseable(hinttText: 'First & Last Name'),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Reuseable(hinttText: 'Email'),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    Reuseable(hinttText: 'Mobile Number'),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    TextField(
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.0,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        fillColor: Colors.grey.shade200,
                        focusColor: Colors.grey.shade100,
                        filled: true,
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025),
                    TextField(
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.0,
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                        fillColor: Colors.grey.shade200,
                        focusColor: Colors.grey.shade100,
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 2.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.grey.shade100,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        // style: ButtonStyle(foregroundColor:
                        //     MaterialStateProperty.resolveWith<Color>(
                        //         (Set<MaterialState> states) {
                        //   if (states.contains(MaterialState.pressed)) {
                        //     return Colors.teal;
                        //   }
                        //   return Colors.grey.shade100;
                        // }),),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
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

class Reuseable extends StatelessWidget {
  const Reuseable({
    super.key,
    required this.hinttText,
  });

  final String hinttText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 20.0,
        height: 1.0,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
        hintText: hinttText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        fillColor: Colors.grey.shade200,
        focusColor: Colors.grey.shade100,
        filled: true,
      ),
    );
  }
}
