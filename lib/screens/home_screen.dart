import 'package:flutter/material.dart';
import 'package:practica_final_2/models/persona.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Persona persona = Persona();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DevProfile M3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            Card.outlined(
              color: Colors.white,
              shadowColor: Colors.green,
              elevation: 8,
              margin: EdgeInsetsGeometry.all(8),
              child: Center(
                widthFactor: 2,
                heightFactor: 2,
                child: Text(
                  "Name: ${persona.fullName}\nEmail: ${persona.email}\nBirth date: ${persona.birthDate.day}/${persona.birthDate.month}/${persona.birthDate.year}",
                  textAlign: .center,
                )
              ),
            ),
            SizedBox(height: 15,),
            TextButton(
              onPressed: () async{
                Object? result = await Navigator.pushNamed(context, "/personal", arguments: persona);
                if(result != null) {
                  setState(() {
                    persona = result as Persona;
                  });
                }
              },
              child: Text("Edit Profile"),
            ),
            SizedBox(height: 3,),
            TextButton(
              onPressed: () {
                print("Test 2");
              },
              child: Text("Explore Widget Showcase")
            )
          ],
        ),
      )
    );
  }
}