import 'package:flutter/material.dart';
import 'package:trialing/data/models.dart';

@immutable
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: Text(project.name+ ' ('+project.web+')'),
                  subtitle: Text(
                    'Total amount: ' + project.budget.toString() + '€',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    project.description,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton( child: Text('Update'),
                      style: ButtonStyle(
      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      elevation: MaterialStateProperty.all(8),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.onSurface),
    ),
                      
                      onPressed: () {},
                    ),
                    TextButton( child: Text('Delete'),                     
                      onPressed: () {},
                    ),
                  ],
                ),
                // replace with project.image
                // Image.asset('assets/card-sample-image.jpg'),
              ],
            ),
          );
  }
}
