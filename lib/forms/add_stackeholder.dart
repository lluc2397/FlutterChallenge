import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:trialing/data/dummy_data.dart';
import 'package:trialing/data/models.dart';

class AddStackeholdersView extends StatelessWidget {
  const AddStackeholdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add stackeholder'),
      ),
      body: const MyStatefulWidget(),
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String fullname = '';
  String email = '';
  String web = '';
  double budget = 0;
  List<Object?> selectedProjects = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: "Enter the stackeholder's full name",
                            labelText: 'Full name',
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Introduce the stackeholder full name';
                            }},
                          onChanged: (value) {
                            setState(() {
                              fullname = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: "Enter the stackeholder's email",
                            labelText: 'Email',
                          ),
                          validator: (value){
                            
                            if (value == null) {
                              return 'Introduce a valid email';
                            } if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) == false){
                              return 'Introduce a valid email';
                            }},
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            
                            filled: true,
                            hintText: "Enter the stackeholder's website",
                            labelText: 'Website',
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Introduce a website url';
                            }
                            if (Uri.parse(value).isAbsolute == false){
                              return 'Introduce a valid url';
                            }},
                          onChanged: (value) {
                            setState(() {
                              web = value;
                            });
                          },
                        ),
                        MultiSelectDialogField(
                          items: projects.map((e) => MultiSelectItem(e, e.name)).toList(),
                          title: const Text("Projects"),
                          selectedColor: Colors.blue,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                          ),
                          buttonIcon: Icon(
                            Icons.poll_rounded,
                            color: Colors.blue,
                          ),
                          buttonText: Text(
                            "Stackholder's projects",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 16,
                            ),
                          ),
                          onConfirm: (results) {
                            selectedProjects = results;
                          },
                        ),
                                   
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Budget',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                            Text(
                              intl.NumberFormat.currency(
                                      symbol: "€", decimalDigits: 2)
                                  .format(budget),
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Slider(
                              min: 0,
                              max: 9999,
                              divisions: 9999,
                              value: budget,
                              onChanged: (value) {
                                setState(() {
                                  budget = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // Process data. Send it to the backend
                                // widget.client.post(createUrl);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Stackeholder added')),
                                );
                                Navigator.pop(context);
                                
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ].expand(
                        (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
