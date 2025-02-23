import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/eventDetails');
              },
              child: Text('Go to Event Details'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/scanner');
              },
              child: Text('Go to Scanner'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ticket');
              },
              child: Text('Go to Ticket Page'),
            ),
          ],
        ),
      ),
    );
  }
}
