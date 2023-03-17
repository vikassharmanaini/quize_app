import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quize_app/Success.dart';

class Question extends StatefulWidget {
  Question({super.key, required this.url});
  String url;

  @override
  State<Question> createState() => _QuestionState(url);
}

class _QuestionState extends State<Question> {
  _QuestionState(this._url);
  final String _url;
  List<dynamic>? response;
  int? optionindex = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getQuestion();
  }

  int index = 0;
  List<dynamic> options = [];
  int correct = 0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (response != null && options.length < 4) {
      options = response![index]['incorrectAnswers'];
      options.add(response![index]['correctAnswer']);
      options.shuffle();
    }
    return Scaffold(
        body: SafeArea(
            child: (response == null)
                ? Center(child: CircularProgressIndicator())
                : Column(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time:  $_time',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('Question Number :  ${index + 1}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 78, 60, 109),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.elliptical(60, 40),
                              bottomLeft: Radius.elliptical(60, 40),
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15, blurStyle: BlurStyle.outer),
                              BoxShadow(
                                  blurRadius: 50, blurStyle: BlurStyle.inner),
                            ]),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: Center(
                            child: Text(
                          'Question ${index + 1} :   ${response![index]['question']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ))),
                    Expanded(
                        child: ListView.builder(
                            // itemExtent: 50,
                            itemCount: options.length,
                            itemBuilder: (context, index) => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: (optionindex != null &&
                                              optionindex == index)
                                          ? Color.fromARGB(255, 202, 202, 202)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 3,
                                            spreadRadius: 2,
                                            blurStyle: BlurStyle.outer)
                                      ]),
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    title: Text(options[index].toString()),
                                    onTap: () => setState(() {
                                      optionindex = index;
                                    }),
                                  ),
                                ))),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Success : ${(correct / response!.length * 100).toInt()}%',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        FloatingActionButton.extended(
                            onPressed: submit, label: Text('Submit')),
                      ],
                    )
                  ])));
  }

  List choosen = [];
  submit() {
    if (optionindex != null) {
      _time = 30;
      choosen.add(options[optionindex!]);
      (options[optionindex!] == response![index]['correctAnswer'])
          ? correct++
          : null;
      // print(correct);
      (index < response!.length - 1)
          ? setState(() {
              index++;
              options = [];
              optionindex = null;
            })
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                        response: response!,
                        choosen: choosen,
                        result: correct,
                      )));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please Select the option')));
    }
  }

  int _time = 30;
  a() async {
    Timer.periodic(Duration(seconds: 1), (t) {
      if (_time == 0) {
        choosen.add('N/A');
        (index < response!.length - 1)
            ? setState(() {
                index++;
                options = [];
                optionindex = null;
                _time = 30;
              })
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Result(
                          response: response!,
                          choosen: choosen,
                          result: correct,
                        )));
      } else if (index == choosen.length) {
        setState(() {
          _time--;
        });
      }
    });
  }

  Future getQuestion() async {
    try {
      var response = await http
          .get(Uri.parse(_url), headers: {'Content-Type': 'application/json'});
      print(response.body);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        setState(() {
          this.response = json.decode(response.body);
        });
      }
      a();
    } catch (e) {
      log(e.toString());
    }
  }
}
