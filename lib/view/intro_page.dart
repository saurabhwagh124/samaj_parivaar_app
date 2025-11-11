import 'package:flutter/material.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/auth/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 330,
                width: 360,
                child: Image.asset("assets/images/community_people.png"),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Text(
                    "Social Community",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.lavender,
                    ),
                  ),
                  Text(
                    "Team",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.lavender,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
                textDirection: TextDirection.ltr,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 70,
              width: 360,
              decoration: BoxDecoration(
                color: appTheme().colorScheme.iceBlue,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 180,
                      decoration: BoxDecoration(
                        color: appTheme().colorScheme.lavender,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: appTheme().colorScheme.lavender,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
