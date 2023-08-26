import 'package:eaziline/screens/user/attendance_screen.dart';
import 'package:eaziline/screens/user/leave_request.dart';
import 'package:eaziline/screens/user/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? currentUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final auth = FirebaseAuth.instance;
    currentUser = auth.currentUser;
  }

  void navigateToLeaveRequestScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeaveRequestScreen(userId: currentUser!.uid),
      ),
    );
  }

  void navigateToAttendanceScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AttendanceScreen(userId: currentUser!.uid),
      ),
    );
  }

  void navigateToProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userId: currentUser!.uid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: navigateToProfileScreen,
            icon: Icon(
              Icons.person,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            // Add padding to move "Welcome" down
            child: Center(
              child: Text(
                'Welcome',
                style: TextStyle(
                  fontSize: screenHeight * 0.035, // Responsive font size
                  fontFamily: GoogleFonts.abrilFatface().fontFamily,
                ),
              ),
            ),
          ),
          const SizedBox(height: 0.01),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Add horizontal padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Add padding to the card
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Mark Attendance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Container(
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/images/attendance.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            ElevatedButton(
                              onPressed: navigateToAttendanceScreen,
                              child: Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // Add padding to the card
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'Leave Request',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: screenHeight * 0.015,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            Container(
                              height: screenHeight * 0.1,
                              width: screenHeight * 0.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('lib/assets/images/leave.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.01,
                            ),
                            ElevatedButton(
                              onPressed: navigateToLeaveRequestScreen,
                              child: Icon(
                                Icons.request_quote_outlined,
                                color: Colors.white,
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(0),
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 0.01),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text('View Grades'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
