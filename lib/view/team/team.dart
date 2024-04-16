import 'package:flutter/material.dart';
import 'widgets/member_card.dart';

class TeamInfo extends StatefulWidget {
  const TeamInfo({super.key});

  @override
  State<TeamInfo> createState() => _TeamInfoState();
}

class _TeamInfoState extends State<TeamInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          children: [
            MemberCard(
              name: "Khalid Alyami",
              workDescription:
                  "Worked On Grid Implementation and Home Page Design. Also, implement key related processes.",
              image: 'assets/team/img1.png',
              imageBackground: Colors.indigo[100]!,
              badgeText: "Developer",
              badgeColor: Colors.indigo[300]!,
            ),
            MemberCard(
              name: "Azzam Al-Kulaib",
              workDescription:
                  "Worked On Encryption Implementation and Handle Encryption Related Components.",
              image: 'assets/team/img2.png',
              imageBackground: Colors.lightGreen[200]!,
              badgeText: "Developer",
              badgeColor: Colors.lightGreenAccent[100]!,
            ),
            MemberCard(
              name: "Mahdi Al-Zakari",
              workDescription:
                  "Worked On Decryption Implementation and Handle Decryption Related Components.",
              image: 'assets/team/img3.png',
              imageBackground: Colors.deepOrangeAccent[200]!,
              badgeText: "Developer",
              badgeColor: Colors.deepOrangeAccent[100]!,
            ),
            MemberCard(
              name: "Abdullah Al-Modayris",
              workDescription:
                  "Worked On Page Designs and Team Page. Also, Implemented Design Components",
              image: 'assets/team/img4.png',
              imageBackground: Colors.deepPurpleAccent[100]!,
              badgeText: "Designer",
              badgeColor: Colors.deepPurpleAccent[100]!,
            ),
          ],
        ),
      ),
    );
  }
}
