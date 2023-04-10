import 'package:book_app/home.dart';
import 'package:book_app/main_screen.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late bool passwordVisible;
  bool isChecked = false;

  @override
  void initState() {
    passwordVisible = false;
    super.initState();
  }

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
                padding: EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                    TextField(
                      style: TextStyle(
                        fontSize: 20.0,
                        height: 1.0,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintText: 'Email Address',
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
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                // fillColor: MaterialStateProperty.all(
                                //   Color(0XFF9E9E9E),
                                // ),
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                }),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Forget Your Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
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
                          'Sign In',
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
