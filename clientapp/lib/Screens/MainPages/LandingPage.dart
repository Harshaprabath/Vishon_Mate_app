import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:blind/Screens/MainPages/Dashboard.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}


class _LandingPageState extends State<LandingPage> {
  
  //auto call dashboard strat
  @override
  void initState() {
    super.initState();
    // Call the function to navigate after 3 seconds
    navigateToDashboardAfterDelay();
  }

  void navigateToDashboardAfterDelay() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (ctx) => const DashBoard()),
    );
  }
  //auto call dashboard end

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          color: Colors.black87,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/images/land.png"),
                width: 300,
              ),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 270,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Let us give the best Assistant",
                        style: TextStyle(
                            color: Color(0xff01ACC2),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 270,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(
                      child: Text(
                        "Get the best assistant for \n            you with us",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SpinKitThreeInOut(
                        color: Color(0xff01ACC2),
                        size: 90,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(
                                  builder: (ctx) => const DashBoard()));
                        },
                        icon: const Icon(Icons.arrow_circle_right_rounded,
                            color: Color(0xff01ACC2), size: 70),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
