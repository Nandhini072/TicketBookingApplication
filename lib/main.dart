import 'package:flutter/material.dart';
import 'Ticketpage.dart';
import 'eventpage.dart';
import 'splash_screen.dart';
import 'home_page.dart';
import 'event_details_page.dart';


void main() {
  runApp(TicketBookingApp());
}

class TicketBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ticket Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/event': (context) => EventPage(),
        '/eventDetails': (context) => EventDetailsPage(eventType: "Movie"),
        '/ticket': (context) => TicketPage(
          eventType: "Movie",
          name: "User",
          location: "Default Location",
          date: DateTime.now(),
          time: TimeOfDay.now(),
          ticketType: "Regular",
          seats: [1, 2],
          totalPrice: 500,
        ),
      },
    );
  }
}
