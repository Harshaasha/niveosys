import 'package:flutter/material.dart';
import '../service.dart';
import 'AddUsers.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> users;

  @override
  void initState() {
    super.initState();
    users = apiService.fetchAllUsers();
  }

  void refreshUsers() {
    setState(() {
      users = apiService.fetchAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "𝓦𝓮𝓵𝓬𝓸𝓶𝓮",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,color: Colors.white
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No users found."));
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(color: Colors.black),
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(2),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          children: [
                            tableHeader("Name"),
                            tableHeader("Email"),
                            tableHeader("Action"),
                          ],
                        ),
                        ...snapshot.data!.map((user) {
                          return TableRow(
                            children: [
                              tableCell(user['name']),
                              tableCell(user['email']),
                              actionButtons(user),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addUser').then((_) => refreshUsers());
        },
      ),
    );
  }

  Widget tableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget actionButtons(dynamic user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.visibility, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("User Details"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: [
                          Text("Name: ${user['name']}"),
                          Text("Email: ${user['email']}"),
                          Text("Phone: ${user['phone']}"),
                          Text("Address: ${user['address']}"),
                          Text("Gender: ${user['gender']}"),
                          Text("Description: ${user['description']}"),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              apiService.deleteUser(user['id'].toString()).then((_) {
                refreshUsers();
              });
            },
          ),
          IconButton(
              icon: Icon(Icons.edit,color: Colors.black,),
              onPressed: (){
               
              }, )
        ],
      ),
    );
  }
}

