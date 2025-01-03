import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_children_hospital/contactUs.dart';
import 'package:url_launcher/url_launcher.dart';

class NiceHospital extends StatefulWidget {
  const NiceHospital({super.key});

  @override
  State<NiceHospital> createState() => _NiceHospitalState();
}

class _NiceHospitalState extends State<NiceHospital> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late InAppWebViewController _webViewController;

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _loadUrlWithInjection(String url) {
    _webViewController
        .loadUrl(urlRequest: URLRequest(url: WebUri(url)))
        .then((_) {
      // Wait for page to load before injecting
      Future.delayed(const Duration(milliseconds: 500), _injectJavaScript);
    });
  }

  void _injectJavaScript() {
    String jsScript = """
    let navbar = document.getElementById('ftco-navbar');
    navbar.style.display = "none";
    let footer = document.querySelector("footer");
    footer.style.display = "none";
    let img = document.querySelector('.img-fluid');
    let wrap = document.querySelector('.wrap');
    img.style.display = "none";
    wrap.style.display = "none";
    """;
    _webViewController.evaluateJavascript(source: jsScript);
  }

  void _showAppointmentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Take an Appointment',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey.shade600),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPhoneButton(context, '+91 9714506969', 'Mobile'),
                const SizedBox(height: 12),
                _buildPhoneButton(context, '0278-2436969', 'Landline 1'),
                const SizedBox(height: 12),
                _buildPhoneButton(context, '0278-2516969', 'Landline 2'),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneButton(
      BuildContext context, String phoneNumber, String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // Format the phone number
          final cleanNumber = phoneNumber.replaceAll(RegExp(r'[\s-]'), '');

          // Create the tel URI
          _launchURL('tel:$cleanNumber');
        },
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.white,
          foregroundColor: Colors.orange.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.orange.shade200),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone, size: 20, color: Colors.orange.shade400),
            const SizedBox(width: 10),
            Text(
              phoneNumber,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
        title: Text(
          "NICE CHILDREN HOSPITAL",
          style:
              GoogleFonts.aboreto(fontSize: 20.5, fontWeight: FontWeight.bold),
        ),
      ),
      key: _key,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_filled),
              title: Text("HOME"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/index.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.adobe_outlined),
              title: Text("ABOUT"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/about.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.group),
              title: Text("OUR TEAM"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/team.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.horizontal_split_sharp),
              title: Text("SERVICES"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/services.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.table_bar_rounded),
              title: Text("ACHIEVEMENT"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/achi.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.paragliding),
              title: Text("PRAISE"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/testi.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.dew_point),
              title: Text("WHAT WE DO"),
              onTap: () {
                _loadUrlWithInjection(
                    "https://nicechildrenhospital.com/department.php");
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.contact_emergency),
              title: Text("CONTACT"),
              onTap: () {
                Future.delayed(const Duration(milliseconds: 500), () {
                  _injectJavaScript();
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactPage(),
                    ));
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.6,
                right: 30.6,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the drawer first
                  _showAppointmentModal(context); // Show the appointment modal
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Take an Appointment",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            onLoadStop: (controller, url) {
              _injectJavaScript();
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                _injectJavaScript();
              }
            },
            initialUrlRequest:
                URLRequest(url: WebUri("https://nicechildrenhospital.com")),
            initialSettings: InAppWebViewSettings(
                allowsLinkPreview: true,
                javaScriptEnabled: true,
                verticalScrollBarEnabled: false),
            onWebViewCreated: (controller) {
              _webViewController = controller;
              Future.delayed(Duration(milliseconds: 500), () {
                _injectJavaScript();
              });
            },
          ),
        ],
      ),
    );
  }
}
