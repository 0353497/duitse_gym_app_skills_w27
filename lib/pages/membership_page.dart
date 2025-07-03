import 'package:duitse_gym_app/data/users.dart';
import 'package:flutter/material.dart';

class MembershipPage extends StatelessWidget {
  const MembershipPage({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: 60,
          child: Image.asset("assets/Icon.png"),
        ),
        title: Text("Membership", style: TextStyle(color: Colors.green),),
      ),
    );
  }
}