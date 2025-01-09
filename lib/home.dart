import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nice_children_hospital/contactUs.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalHomePage extends StatefulWidget {
  const HospitalHomePage({super.key});

  @override
  State<HospitalHomePage> createState() => _HospitalHomePageState();
}

class _HospitalHomePageState extends State<HospitalHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late InAppWebViewController _webViewController;
  int _currentBuildingSlide = 0;
  int _currentStaffSlide = 0;
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade400,
        title: Text(
          "NICE CHILDREN HOSPITAL",
          style:
              GoogleFonts.aboreto(fontSize: 20.5, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Building Images Slider
            buildBuildingSlider(),

            // Welcome Section
            buildWelcomeSection(),

            // Staff Images Slider
            buildStaffSlider(),

            // Facilities Section in Column Layout
            buildFacilitiesSection(),
          ],
        ),
      ),
    );
  }

  Widget buildBuildingSlider() {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentBuildingSlide = index);
            },
          ),
          items: [1, 2]
              .map((i) => Image.asset(
                    'assets/images/hospital$i.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ))
              .toList(),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [0, 1]
                .map((i) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentBuildingSlide == i
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '\t\t\t\t\t\t\t\t\t\t\t\t\t Welcome \n Nice Children Hospital',
              style: GoogleFonts.lato(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF9933),
              ),
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
              children: [
                TextSpan(
                    text:
                        'Nice Children Hospital Is At The Forefront Of Dedicated Neonatal Care, Committed To Provide Specialized Treatment To Prematurely Delivered And Extremely Low-birth-weight Babies. Our State-of-the-art Facility, Also Known As "little Miracles Haven", Stands As A Testament To Our Unwavering Dedication To The Well-being Of These Tiny Neonates.\n\n'),
                TextSpan(
                    text:
                        'Our Mission Is To Create A Haven For Tiny Miracles, Where Every Child Has The Opportunity To Grow Into A Healthy, Normal Individual. '),
                TextSpan(
                  text:
                      'Our Aim Is To Have An Initial Revival Of Sick Neonates',
                  style: TextStyle(
                    color: Color(0xFFFF9933),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      ' Nice Children Hospital, Where Every Small Miracle Receives The Care And Attention They Deserve.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStaffSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _currentStaffSlide = index);
            },
          ),
          items: [
            Image.asset('assets/images/team1.jpg'),
            Image.asset('assets/images/team2.jpg'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [0, 1]
              .map((i) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentStaffSlide == i
                          ? const Color(0xFFFF9933)
                          : Colors.grey.withOpacity(0.5),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget buildFacilitiesSection() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Our Facilities',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF9933),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Facility Cards in Column Layout
          ...facilitiesData
              .map(
                (facility) => Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: FacilityCard(
                    icon: facility['icon']!,
                    title: facility['title']!,
                    description: facility['description']!,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class FacilityCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;

  const FacilityCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(icon, height: 48, width: 48),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

// Facility Data
final facilitiesData = [
  {
    'icon': 'assets/icons/v.png',
    'title': 'VENTILATOR SUPPORT',
    'description':
        'World Class Advanced Dedicated Neonatal Ventilator System Stands For Milestones In Neonatal Ventilation. NON/INVASIVE VENTILATION, NCPAP, HFNC, SNIPPV, NHFOV (Nasal High Frequency Oscillation Ventilation), nNAVA (Nasal Neurally Adjusted Ventilatory Assist) Is Gold Standard In ...',
  },
  {
    'icon': 'assets/icons/n.png',
    'title': 'NICU',
    'description':
        "Saurashtra's First NNF Level-IIB Accredited Centre For Fellowship In Neonatology For Doctors And Nurses. NICU Which Provides Advanced & Evidence Based Treatment To Neonates Having Any Kind Of Illness And Aims For Intact Survival For Bright Future Of Little Ones.",
  },
  {
    'icon': 'assets/icons/c.png',
    'title': 'ECHO CARDIOGRAPHY',
    'description':
        'Bed Side Functional Echocardiography To Evaluate The Cardiac Function Of Sick Neonates For Early Diagnosis And For Treatment Of Structural Congenital Heart Diseases.',
  },
  {
    'icon': 'assets/icons/l.png',
    'title': 'COOLING THERAPY',
    'description':
        'Advanced Servo Controlled Device For The Treatment Of Moderate And Severe Hypoxic Ischemic Encephalopathy In Case Of Severe Perinatal Asphyxia. This Has Been Proven To Be The Only Medical Intervention Which Reduces Brain Damage And Improves Their Chances Of Normal Survival.',
  },
  {
    'icon': 'assets/icons/nitra.png',
    'title': 'NITRIC OXIDE THERAPY',
    'description':
        'Inhaled Nitric Oxide (I NO), A Selective Pulmonary Vasodilator, Is Used As A Therapeutic Modality In Infants With Hypoxemic Respiratory Failure (HRF) Associated With Persistent Pulmonary Hypertension Of The Newborn (PPHN).',
  },
  {
    'icon': 'assets/icons/x.png',
    'title': 'ULTRASONOGRAPHY',
    'description':
        'Availability Of Ultrasonography Machine Eases The Diagnostic Approach For Respiratory Distress Syndrome, Necrotizing Enterocolitis, Intraventricular Hemorrhage Etc And Helps In Early Initiation Of Specific Treatment',
  },
];
