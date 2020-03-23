import 'package:flutter/material.dart';
import 'add_medication.dart';

class MedicationPage extends StatefulWidget {
  @override
  State createState() => new MedicationPageState();
}

class MedicationPageState extends State<MedicationPage> {
  List<String> litems = [];
  final TextEditingController eCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      //body: SingleChildScrollView(child: YourBody()),
      appBar: new AppBar(
        backgroundColor: Colors.green,
        flexibleSpace: new Container(
          alignment: Alignment.center,
          child: new Divider(
            color: Colors.white,
            thickness: 2,
          ),
        ),
        bottom: PreferredSize(
            child: new Container(), preferredSize: Size(100, 100)),
        title: new Row(
          children: <Widget>[
            new Text(
              "Medication Tracker",
              style: new TextStyle(
                  color: Colors.white, fontSize: 30, fontFamily: 'OpenSans'),
            ),
          ],
        ),
      ),
      body: new Material(
        color: Colors.white70,
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: eCtrl,
              onSubmitted: (text) {
                litems.add(text);
                eCtrl.clear();
                setState(() {});
              },
            ),
            new Expanded(
              child: new GridView.builder(
                  itemCount: litems.length,
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    return new Center(
                      child: new Container(
                        width: 400,
                        height: 150,
                        child: new Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              print('Card tapped.');
                            },
                            child: Column(
                              children:<Widget>[
                                Text("Medication Name",style: TextStyle(color:Colors.black54,fontSize:20,fontWeight: FontWeight.bold,fontFamily: "OpenSans"),
                                ),
                            Text("Medication Nickname",style: TextStyle(color:Colors.black54,fontSize:15,fontFamily: "OpenSans"),
                            ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new AddMedication())),
        tooltip: 'Increment Counter',
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
