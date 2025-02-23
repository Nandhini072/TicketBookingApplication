import 'package:flutter/material.dart';
import 'Ticketpage.dart';

class SeatSelectionPage extends StatefulWidget {
  final String eventType;
  final String name;
  final String location;
  final DateTime date;
  final TimeOfDay time;
  final String ticketType;

  SeatSelectionPage({
    required this.eventType,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.ticketType,
  });

  @override
  _SeatSelectionPageState createState() => _SeatSelectionPageState();
}

class _SeatSelectionPageState extends State<SeatSelectionPage> {
  List<int> selectedSeats = [];
  final int rows = 5;
  final int cols = 8;

  int getSeatPrice() {
    return widget.ticketType == "VIP" ? 300 : 150;
  }

  void toggleSeat(int index) {
    setState(() {
      if (selectedSeats.contains(index)) {
        selectedSeats.remove(index);
      } else {
        selectedSeats.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      appBar: AppBar(
        title: Text("Select Your Seat"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 16),

          // 🖥 Screen Indicator
          Container(
            width: 250,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "SCREEN",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          SizedBox(height: 20),

          // 🎟 Seat Layout
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: 1.2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: rows * cols,
              itemBuilder: (context, index) {
                bool isSelected = selectedSeats.contains(index);
                bool isBooked = index % 10 == 0;

                return GestureDetector(
                  onTap: () {
                    if (!isBooked) toggleSeat(index);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isBooked
                          ? Colors.red
                          : isSelected
                          ? Colors.green
                          : Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? [BoxShadow(color: Colors.greenAccent, blurRadius: 5)]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        "S${index + 1}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 10),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _seatLegend(Colors.grey.shade700, "Available"),
              SizedBox(width: 10),
              _seatLegend(Colors.green, "Selected"),
              SizedBox(width: 10),
              _seatLegend(Colors.red, "Booked"),
            ],
          ),

          SizedBox(height: 20),


          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Total Price: ₹${selectedSeats.length * getSeatPrice()}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: selectedSeats.isEmpty
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketPage(
                          eventType: widget.eventType,
                          name: widget.name,
                          location: widget.location,
                          date: widget.date,
                          time: widget.time,
                          ticketType: widget.ticketType,
                          seats: selectedSeats,
                          totalPrice: selectedSeats.length * getSeatPrice(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                  ),
                  child: Text("Generate Ticket",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _seatLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 20, height: 20, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5))),
        SizedBox(width: 5),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
