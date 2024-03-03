import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Name Matcher',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 244, 187, 183)),
      ),
      home: MatchPage(),
    );
  }
}

class MatchPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  late TextEditingController name1Controller;
  late TextEditingController name2Controller;
  String result = '';

  @override
  void initState() {
    super.initState();
    name1Controller = TextEditingController();
    name2Controller = TextEditingController();
  }

  @override
  void dispose() {
    name1Controller.dispose();
    name2Controller.dispose();
    super.dispose();
  }

  void calculateMatch() {
    String name1 = name1Controller.text;
    String name2 = name2Controller.text;

    if (name1.isNotEmpty && name2.isNotEmpty) {
      int matchPercentage = generateMatchPercentage(name1, name2);
      setState(() {
        result = 'Match percentage: $matchPercentage%';
      });
    } else {
      setState(() {
        result = 'Please enter both names';
      });
    }
  }

  int generateMatchPercentage(String name1, String name2) {
    int hash1 = name1.hashCode;
    int hash2 = name2.hashCode;
    return (hash1 ^ hash2) % 101; // Modulo 101 untuk dapet presentasenya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 224, 227),
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                'Match Calculator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Color.fromARGB(255, 133, 51, 70),
                ),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Container(
            color: Color.fromARGB(255, 177, 99, 124),
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 12.0, top: 12.0),
            child: Text(
              'Discover the compatibility between two names by using this match calculator!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 500.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: name1Controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Name 1',
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Color.fromARGB(255, 178, 35, 68),
                    size: 40.0,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: name2Controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Name 2',
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () {
                  calculateMatch();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                ),
                child: Text('Calculate Match',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    )),
              ),
              SizedBox(height: 16.0),
              Text(
                result,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
