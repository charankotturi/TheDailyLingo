import 'package:flutter/material.dart';

class VerificationPage extends StatelessWidget {
  final String emailId;

  const VerificationPage({super.key, required this.emailId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
                "Click on verify link sent to your email id: $emailId!"),
            const SizedBox(height: 100,),
            const SizedBox(
              width: 250,
              height: 250,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
