import 'package:duitse_gym_app/data/users.dart';
import 'package:duitse_gym_app/pages/loginpage.dart';
import 'package:duitse_gym_app/pages/mappage.dart';
import 'package:duitse_gym_app/pages/membership_page.dart';
import 'package:duitse_gym_app/pages/newspage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 60,
          child: Image.asset(
            "assets/Icon.png",
            width: 60,
          ),
        ),
        centerTitle: false,
        title: Text("VierToreGym",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hi, ${user.first_name}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Loginpage()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.green),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(32),
                      side: BorderSide(
                        color: Colors.green,
                        width: 4
                      )
                      ))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Sign out"),
                  ),
                )
              ],
            ),
            HomePageCard(
              icon: "assets/Icons/User attributes.png",
              text: "MemberShip", ontap: () { 
                Navigator.push(context, MaterialPageRoute(builder: (_) => MembershipPage(user: user)));
              },
            ),
             HomePageCard(
               icon: "assets/Icons/Location on.png",
               text: "Studios", ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MapPage()));
               },
             ),
             HomePageCard(
               icon: "assets/Icons/Today.png",
               text: "News", ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => Newspage()));
               },
             )
          ],
        ),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  const HomePageCard({
    super.key, required this.icon, required this.text, required this.ontap,
  });
  final String icon;
  final String text;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: InkWell(
        onTap: ontap,
        child: Card(
          color: Colors.white,
          child: Stack(
            children: [
               Positioned(
                      top: -320,
                      left: 130,
                      child: Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(200)
                      ),
                    )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          child: Image.asset(icon),
                        ),
                        Text(text, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 28),)
                      ],
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