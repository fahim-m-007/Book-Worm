import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {

  List<String> phoneNumbers = [
    "+880 1234-567890",
    "+880 9876-543210",
    "+880 9832-420676",
  ];

  List<String> emails = [
    "support@bookworm.com",
    "help@bookworm.com",
  ];

  String address = "Dhaka, Bangladesh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            const SizedBox(height: 20),

            const Text(
              "Phone Numbers",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            ...phoneNumbers.map((number) => ListTile(
              leading: const Icon(Icons.phone),
              title: Text(number),
            )),

            const SizedBox(height: 20),

            const Text(
              "Emails",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            ...emails.map((email) => ListTile(
              leading: const Icon(Icons.email),
              title: Text(email),
            )),

            const SizedBox(height: 20),

            const Text(
              "Address",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(address),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}