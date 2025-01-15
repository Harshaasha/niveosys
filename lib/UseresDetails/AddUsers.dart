import 'package:flutter/material.dart';
import '../service.dart';


class UserForm extends StatefulWidget {
  final Map<String, dynamic>? user;

  UserForm({this.user});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  Map<String, String> userData = {
    'name': '',
    'phone': '',
    'email': '',
    'address': '',
    'gender': '',
    'description': '',
  };

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      userData = {
        'name': widget.user!['name'],
        'phone': widget.user!['phone'],
        'email': widget.user!['email'],
        'address': widget.user!['address'],
        'gender': widget.user!['gender'],
        'description': widget.user!['description'],
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Users'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                initialValue: userData['name'],
                onSaved: (value) => userData['name'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone"),
                initialValue: userData['phone'],
                onSaved: (value) => userData['phone'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                initialValue: userData['email'],
                onSaved: (value) => userData['email'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Address"),
                initialValue: userData['address'],
                onSaved: (value) => userData['address'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Gender"),
                initialValue: userData['gender'],
                onSaved: (value) => userData['gender'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                initialValue: userData['description'],
                onSaved: (value) => userData['description'] = value!,
                validator: (value) => value!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(widget.user == null ? "Add User" : "Update User"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.user == null) {
                      apiService.createUser(userData).then((_) {
                        Navigator.pop(context);
                      });
                    } else {
                      apiService
                          .updateUser(widget.user!['id'].toString(), userData)
                          .then((_) {
                         Navigator.pop(context);


                      });
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
