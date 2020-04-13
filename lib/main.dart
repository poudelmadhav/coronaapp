import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  title: 'Corona App',
  debugShowCheckedModeBanner: false,
  home: MadhavCovid(),
));

class MadhavCovid extends StatefulWidget {
  @override
  _MadhavCovidState createState() => _MadhavCovidState();
}

class _MadhavCovidState extends State<MadhavCovid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App')
      ),
    );
  }
}
