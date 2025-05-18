import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoVotingScreen extends StatelessWidget {
  const NoVotingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                size: 200,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                "No Voting Event",
                style: GoogleFonts.nunito(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
