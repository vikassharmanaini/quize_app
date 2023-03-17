import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quize_app/bottomSelection.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  double value = 5;
  List _category = [
    {'name': 'Arts & Literature', 'url': 'arts_and_literature'},
    {'name': 'Film & TV', 'url': 'film_and_tv'},
    {'name': 'Food & Drink', 'url': 'food_and_drink'},
    {'name': 'Genral Knowledge', 'url': 'genral_kowladge'},
    {'name': 'Geography', 'url': 'geography'},
    {'name': 'History', 'url': 'history'},
    {'name': 'Music', 'url': 'music'},
    {'name': 'Science', 'url': 'science'},
    {'name': 'Society and Culture', 'url': 'society_and_culture'},
    {'name': 'Sport', 'url': 'sport'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Your Quiz Category")),
      body: ListView.builder(
        itemCount: _category.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3, spreadRadius: 2, blurStyle: BlurStyle.outer)
              ]),
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              "${index + 1} ) ${_category[index]['name']}",
            ),
            onTap: () => showBottomSheet(
                context: context,
                builder: (context) => BottomSelection(
                      title: _category[index]['name'],
                      uri: _category[index]['url'],
                    )),
          ),
        ),
      ),
    );
  }
}
