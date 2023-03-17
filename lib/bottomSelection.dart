import 'package:flutter/material.dart';
import 'package:quize_app/question.dart';

class BottomSelection extends StatefulWidget {
  BottomSelection({super.key, required this.title, required this.uri});
  String title;
  String uri;
  @override
  State<BottomSelection> createState() => _BottomSelectionState(title, uri);
}

class _BottomSelectionState extends State<BottomSelection> {
  _BottomSelectionState(this._title, this._uri);
  String _uri;
  String difficult = 'easy';
  String _title;
  double value = 5;
  var difficulties = ['easy', 'medium', 'hard'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(),
          boxShadow: [
            BoxShadow(
              spreadRadius: 5,
              blurRadius: 15,
            )
          ],
          color: Colors.white),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(18),
            child: Text(
              _title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Divider(
              thickness: 2,
            ),
          ),
          Text('Select Number of Questions: ${value.toInt()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Slider(
            label: 'Number of Questions',
            min: 5.0,
            max: 20.0,
            autofocus: true,
            value: value,
            onChanged: (value) => setState(() {
              this.value = value;
            }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: Text("Select Difficult Level : ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                )),
                Padding(
                  padding: EdgeInsets.all(18),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    value: difficult,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: difficulties.map((String e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ));
                    }).toList(),
                    onChanged: (String? newvalue) {
                      setState(() {
                        difficult = newvalue!;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Question(url: makeUrl())));
              },
              label: Text(
                'Start',
                style: TextStyle(fontSize: 20),
              ),
              icon: Icon(Icons.start_outlined),
            ),
          )
        ],
      ),
    );
  }

  makeUrl() {
    int v = value.toInt();
    final String url =
        'https://the-trivia-api.com/api/questions?categories=$_uri&limit=$v&region=IN&difficulty=$difficult';
    return url;
  }
}
