import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  Result({super.key, required this.response, required this.choosen,required this.result});
  List<dynamic> response;
  int result;
  List choosen;
  @override
  State<Result> createState() => _ResultState(response, choosen,result);
}

class _ResultState extends State<Result> {
  List<dynamic> _choosen;
  List<dynamic> _res;
  int _result;
  _ResultState(this._res, this._choosen,this._result);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result : $_result/${_choosen.length}'),
      ),
      body: ListView.builder(
          itemCount: _res.length,
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: Text(
                    _res[index]['question'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (_choosen[index] == _res[index]['correctAnswer'])
                            ? Colors.green
                            : Colors.red),
                  ),
                  subtitle: Text(
                    'Correct Answer : ${_res[index]['correctAnswer']}\nChoosen by You : ${_choosen[index]}',
                    style: TextStyle(
                        color: (_choosen[index] == _res[index]['correctAnswer'])
                            ? Colors.green
                            : Colors.red),
                  ),
                ),
              )),
    );
  }
}
