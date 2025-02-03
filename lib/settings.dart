import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stethoscope/HomePage.dart';
import 'utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

void signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();  // Déconnecte l'utilisateur
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => HomePage()), // Navigue vers la page de login
    (route) => false,  // Efface toute la pile de navigation
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(leading: const CircleAvatar(child: Icon(Icons.bluetooth),),
          title: const Text("Bluetooth Permission"),
          subtitle: const Text("Allow Bluetooth to connect to the device"),
          onTap: () => requestPermission(permission: Permission.bluetooth),
          ),
          ListTile(leading: const CircleAvatar(child: Icon(Icons.logout),),
          title: const Text("Sign out"),
          subtitle: const Text("disconect from your account"),
          onTap: () => signOut(context)
          ),
        ],
      ),
    );
  }
}
