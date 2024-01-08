import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_todo/data/auth_data.dart';
import 'package:project_todo/data/firestor.dart';
import 'package:project_todo/widgets/task_widget.dart';

import 'addPlan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _startNewAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: AddPlan(),
        );
        /*return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: const AddPlan(),
          );*/
      },
    );
  }

  bool show = true;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: ListView(children: [
          const DrawerHeader(
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/2.png"),
              radius: 50,
            ),
          ),
          ListTile(
            title: const Text(
              "LogOut",
              style: TextStyle(fontSize: 18),
            ),
            leading: const Icon(Icons.logout),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              AuthenticationRemote().logout();
            },
          )
        ]),
      ),
      appBar: AppBar(
        title: const Text("Plans"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () => {
            _startNewAddTransaction(context),
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
          child: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              show = false;
            });
          }
          return true;
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore_Datasource().stream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            final planList = Firestore_Datasource().getPlans(snapshot);
            return ListView.builder(
              itemBuilder: (context, index) {
                final plan = planList[index];
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Firestore_Datasource().deletePlan(plan.id);
                    },
                    child: TaskWidget(plan));
              },
              itemCount: planList.length,
            );
          },
        ),
      )),
    );
  }
}
