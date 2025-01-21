import 'package:flutter/material.dart';
import 'package:modaapp/HomePage.dart';
import 'constraints.dart';
import 'package:google_fonts/google_fonts.dart';

class AdvPage extends StatefulWidget {
  const AdvPage({super.key});

  @override
  State<AdvPage> createState() => _AdvPageState();
}

class _AdvPageState extends State<AdvPage> {
  Color bckgrd = Color.fromARGB(255, 235, 235, 235);
  @override
  Widget build(BuildContext context) {
    double sc_height = (MediaQuery.of(context).size.height);
    double sc_width = (MediaQuery.of(context).size.width);
    return Scaffold(
      //backgroundColor: bckgrd,
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: sc_height / 12,
            ),
            Text(
          "Clotho",
          style: GoogleFonts.dancingScript(color: Color.fromARGB(255, 218, 214, 27), fontSize: 90), textAlign: TextAlign.center,
          
        ),
            SizedBox(
              height: sc_height / 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Find everything \nabout fashion",
                style: GoogleFonts.dancingScript(
                    color: Colors.black, fontSize: 40), textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Clotho, is a mobile app you can follow \nnew fashion trends, icons.",
                style: GoogleFonts.zillaSlab(fontSize: 20), textAlign:TextAlign.center,
              ),
            ),
            SizedBox(
              height: sc_height / 12,
            ),
            Row(
              children: [
                SizedBox(
                  width: sc_width/8,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                  },
                  child: Text(
                    "Get started",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(Color.fromARGB(255, 218, 214, 27)),
                    side: MaterialStateProperty.all(BorderSide(
                      color: Color.fromARGB(255, 218, 214, 27),
                      width: 5.0,
                      style: BorderStyle.solid)),
                    
                    shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                    foregroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 218, 214, 27)),
                    fixedSize: MaterialStatePropertyAll(
                        Size(sc_width/2, sc_height / 10)),
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.white),
                  ),
                ),
                SizedBox(
                  width: sc_width/16,
                ),
                IconButton(icon:Icon(Icons.arrow_circle_right), color:Color.fromARGB(255, 218, 214, 27), 
                iconSize: 80, onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: Text(
                "Follow, create, inspire. Just fashion.",
                style: GoogleFonts.zillaSlab(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
