import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Hospital location coordinates
  static const double _latitude = 21.764423;
  static const double _longitude = 72.153957;

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'nicechildrenhospital69@gmail.com',
        queryParameters: {
          'subject': 'Contact Form Submission',
          'body': 'Name: ${_nameController.text}\n'
              'Email: ${_emailController.text}\n'
              'Message: ${_messageController.text}'
        });
    await _launchURL(emailLaunchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Contact Us'),
      //   backgroundColor: Colors.orange,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        title: Text(
          "Contact Us",
          style: GoogleFonts.inter(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Map Button Section

            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://maps.googleapis.com/maps/api/staticmap?center=21.764423,72.153957&zoom=15&size=600x400&markers=color:red%7C21.764423,72.153957&key=AIzaSyBrO4YmLsMb1vFBLKUuAHBJgWijXgmdySk'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    MapsLauncher.launchCoordinates(
                        _latitude, _longitude, 'Nice Children Hospital');
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      // child: Row(
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: const [
                      //     Icon(Icons.map, color: Colors.orange),
                      //     SizedBox(width: 8),
                      //     Text(
                      //       'Open in Maps',
                      //       style: TextStyle(
                      //         color: Colors.black87,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Contact Information Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                      color: Colors.orange,
                      size: 30,
                    ),
                    title: Text(
                      '1st Floor, Sameep Complex, Bus Stop, '
                      ' Kalubha Rd, Opposite Kalubha, Kalanala,\n'
                      'Vidhyanagar, Bhavnagar, Gujarat 364001',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                    onTap: () {
                      MapsLauncher.launchCoordinates(
                          _latitude, _longitude, 'Nice Children Hospital');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.phone,
                      color: Colors.orange,
                      size: 28,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () => _launchURL('tel:+912782436969'),
                          child: Text(
                            '(0278) 2436969',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchURL('tel:+912782516969'),
                          child: Text(
                            '(0278) 2516969',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => _launchURL('tel:+919714506969'),
                          child: Text(
                            '+91 9714506969',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.email,
                      color: Colors.orange,
                      size: 29,
                    ),
                    title: TextButton(
                      onPressed: () =>
                          _launchURL('mailto:nicechildrenhospital69@gmail.com'),
                      child: Text(
                        'nicechildrenhospital69@gmail.com',
                        style: GoogleFonts.lato(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Get in Touch Form
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Get in Touch',
                      style: GoogleFonts.cabin(
                        color: Colors.brown.shade800,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your message';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _launchEmail();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Send Message',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
