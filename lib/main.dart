import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  // For loading Icon
  bool loading = true;
  List lstCountry;

  // Taking data from api
  Future <String> _getWorldData() async {
    var response = await http.get('https://brp.com.np/covid/country.php');
    var getData = json.decode(response.body);

    if (this.mounted) {
      setState(() {
        loading = false;
        lstCountry = [getData];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
      _getWorldData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona App'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            _getWorldData();
          })
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          loading ? Center(child: CircularProgressIndicator()) : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: lstCountry == null ? 1 : lstCountry[0]['countries_stat'].length,
            itemBuilder: (context, i) {
              return listItem(i);
            })
        ],
      )
    );
  }
  
  Widget listItem(int i) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(lstCountry[0]['countries_stat'][i]['country_name']),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['cases'], style: TextStyle(color: Colors.white, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('संक्रमित', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['deaths'], style: TextStyle(color: Colors.white, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('मृत्यु', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['total_recovered'], style: TextStyle(color: Colors.white, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('निको भको', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.yellow,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['new_cases'], style: TextStyle(color: Colors.purple, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('नयाँ संक्रमित', style: TextStyle(color: Colors.purple),)
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Expanded(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['new_deaths'], style: TextStyle(color: Colors.white, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('नयाँ मृत्यु', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10),),
            Expanded(
              child: Container(
                color: Colors.green,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(lstCountry[0]['countries_stat'][i]['active_cases'], style: TextStyle(color: Colors.white, fontSize: 18),),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                    Text('सक्रिय', style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            )
          ],
        )
      ]
    );
  }
}
