import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatelessWidget {
  final String eventType;
  final String name;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final String ticketType;
  final List<int> seats;
  final int totalPrice;

  TicketPage({
    required this.eventType,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.ticketType,
    required this.seats,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.deepPurple[100],
      appBar: AppBar(title: Text("Your Ticket")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ClipPath(
            clipper: TicketClipper(),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("🎫 $eventType", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("👤 Name: $name"),
                  Text("📍 Location: $location"),
                  Text("📅 Date: ${"${date.day}-${date.month}-${date.year}"}"),

                  Text("⏰ Time: ${time.format(context)}"),
                  Text("🎟 Ticket Type: $ticketType"),
                  Text("💺 Seats: ${seats.join(', ')}"),
                  Text("💰 Total Price: INR $totalPrice"),
                  SizedBox(height: 16),


                  Center(
                    child: QrImageView(
                      data: "$eventType | $name | $location | $date | $time | $ticketType | Seats: ${seats.join(', ')} | INR $totalPrice",
                      version: QrVersions.auto,
                      size: 150.0,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 20.0;
    Path path = Path();


    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.addOval(Rect.fromCircle(center: Offset(0, size.height / 3), radius: 10));
    path.addOval(Rect.fromCircle(center: Offset(size.width, size.height / 1.5), radius: 10));

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TicketClipper oldClipper) => false;
}
