import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading . . .');
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          final documents = snapshot.data!.docs;
          final userList = documents
              .map((doc) => ListTile(
                    title: Text(doc['name'] ?? 'No Value Found'),
                    subtitle: Text(doc['email'] ?? 'No Value Found'),
                    leading: Column(
                      children: <Widget>[
                        Text(doc['age'].toString()),
                        const Text('Years Old'),
                      ],
                    ),
                  ))
              .toList();

          return ListView(
            children: userList,
          );
        },
      ),
    );
  }
}
