import 'package:flutter/material.dart';

class MaharajasInviteScreen extends StatelessWidget {
  const MaharajasInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          image: DecorationImage(
            image: AssetImage('assets/icons/old_latter.png'),
            fit: BoxFit.values[5],
          ),
        ),
        // child: Center(
        //   child: Image(image: AssetImage('assets/icons/old_latter.png'), fit: BoxFit.cover,),
        // ),
      ),
    );
  }
}
