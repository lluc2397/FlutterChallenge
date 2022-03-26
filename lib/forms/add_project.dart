import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:io';
import 'package:trialing/data/database.dart';
import 'package:trialing/data/models.dart';

class AddProjectsView extends StatefulWidget {
  const AddProjectsView({Key? key}) : super(key: key);

  @override
  _AddProjectsViewState createState() => _AddProjectsViewState();
}

class _AddProjectsViewState extends State<AddProjectsView> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String web = '';
  String description = '';
  File image = File('');

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    this.image = File(image.path);

  }

  DateTime closingDate = DateTime.now();
  double budget = 0;

  Future addProject() async {
  final project = Project(
    name : name,
    web : web,
    description : description,
    img : image,
    budget : budget,
    closingDate : closingDate,
    isOpened : true,
  );

  await ONGDatabase.instance.createProject(project);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add project'),
      ),
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
                            hintText: "Enter the project's name",
                            labelText: 'Name',
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Introduce a name';
                            }},
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: "Enter the project's website",
                            labelText: 'Website',
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'Introduce a website url';
                            }
                            if (Uri.parse(value).isAbsolute == false){
                              return 'Introduce a valid url';
                            }
                            
                          },
                          onChanged: (value) {
                            setState(() {
                              web = value;
                            });
                          },
                        ),
                        
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: "Enter the project's name description",
                            labelText: 'Description',
                          ),
                          validator: (value){
                            if (value == null || value.isEmpty || value.length < 100) {
                              return 'Introduce a complete description';
                            }},
                          onChanged: (value) {
                            description = value;
                          },
                          maxLines: 5,
                        ),
                        ElevatedButton(
                            onPressed: () {pickImage();},
                            child: const Text('Add image'),
                          
                          ),
                        

                        _FormDatePicker(
                          date: closingDate,
                          onChanged: (value) {
                            setState(() {
                              closingDate = value;
                            });
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
                                addProject();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Project added')),
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



class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Closing date',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              intl.DateFormat.yMd().format(widget.date),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDate = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            // Don't change the date if the date picker returns null.
            if (newDate == null) {
              return;
            }

            widget.onChanged(newDate);
          },
        )
      ],
    );
  }
}


