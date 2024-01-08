// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import '../data/firestor.dart';
import '../models/plan.dart';

class EditPlan extends StatefulWidget {
  Plan _plan;
  EditPlan(this._plan, {super.key});

  @override
  State<EditPlan> createState() => _EditPlanState();
}

class _EditPlanState extends State<EditPlan> {
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController(text: widget._plan.title);
    subtitle = TextEditingController(text: widget._plan.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: ListView(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: title,
                    focusNode: _focusNode1,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        hintText: 'title',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xffc5c5c5),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 2.0,
                          ),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    maxLines: 4,
                    controller: subtitle,
                    focusNode: _focusNode2,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      hintText: 'subtitle',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffc5c5c5),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          indexx = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color:
                                  indexx == index ? Colors.green : Colors.grey,
                            ),
                          ),
                          width: 140,
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Image.asset('assets/images/${index}.png'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: const Size(170, 48),
                    ),
                    onPressed: () {
                      Firestore_Datasource().UpdatePlan(
                          widget._plan.id, indexx, title!.text, subtitle!.text);
                      Navigator.pop(context);
                    },
                    child: Text('Edit plan'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      minimumSize: Size(170, 48),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
