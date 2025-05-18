import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Terms and Conditions'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'EBEFA PRIVACY POLICY',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '1. INTRODUCTION',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Ebefa (hereinafter referred to as ‘The Company’) is a corporation established under the laws of the Republic of Ghana, specializing in organizing various marketing campaigns and events. As part of our business operations, we may collect your personal data, and safeguarding this data's privacy is our utmost concern.This Privacy Policy (hereinafter referred to as ‘The Policy’) is designed to elucidate the data we may gather, the rationale behind collecting it, the methods employed for collecting, using, or sharing it, the precautions we take to protect your personal data, and the choices you have regarding this information's utilization.",
                ),
                SizedBox(height: 16.0),
                Text(
                  '2. GOVERNING LAW',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'This policy shall be subject to and governed by the laws of the Republic of Ghana.',
                ),
                Text(
                  "Ebefa may periodically update this policy, and any such updates will be posted on Ebefa's website(s), with the 'Last Updated' date being modified accordingly. Any substantial changes to this Policy that could significantly impact Ebefa's data practices concerning previously collected information will be communicated to you via the email address provided at the time of collection.",
                ),
                SizedBox(height: 16.0),
                Text(
                  '3. CONTACT US',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'You can reach Ebefa through the following contact details: Official Contact Person – Opoku Claudious Samuel Mensah Telephone Number – 0552515809 Email Address – 3b3faapp@gmail.com',
                ),
                SizedBox(height: 16.0),
                Text(
                  '4. TICKET PURCHASE AND OTHER PRODUCTS',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tickets can be acquired through the Ebefa website.Tickets are typically available in the following categories: Depending on organisers choice',
                ),
                SizedBox(height: 16.0),
                Text(
                  '5. EVENT ATTENDANCE',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Attendees/Participants are granted entry to any event organized by the Organizer by presenting a valid, undamaged Ticket or the required entry tag. Upon presenting a valid, undamaged Ticket, the Organizer will collect the Ticket and provide the Attendee with the appropriate identification for event entry.Tickets are and shall remain the property of the Organizer.The Ticket grants the holder the right to attend the event and access the venue. Access is granted exclusively to the initial Ticket holder upon inspection at the events entrance. The Organizer assumes that the Ticket holder is also the rightful owner. As the Ticket holder, the Participant/Attendee assumes responsibility for any loss, theft, damage, or misuse of the Ticket. Tickets are issued only once, and a replacement requires repurchase.The responsibility to prove the Tickets validity rests with the prospective Attendee.',
                ),
                SizedBox(height: 16.0),
                Text(
                  '6. Changes to Terms and Conditions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'The app owner reserves the right to modify or replace these terms and conditions at any time. It is your responsibility to review these terms periodically.',
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
