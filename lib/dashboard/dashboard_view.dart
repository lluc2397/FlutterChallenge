import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:trialing/widgets/menu_button.dart';
import 'package:trialing/widgets/upper_card.dart';
import 'package:trialing/widgets/middle_card.dart';
import 'package:trialing/widgets/project_card.dart';
import 'package:trialing/forms/add_project.dart';
import 'package:trialing/forms/add_stackeholder.dart';
import 'package:trialing/data/dummy_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);
  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  Client client = Client();

  // user dynamic value for all of them. Retreiving the info from the API and pass it in each field
  final int totalProjects = projects.length;

  final double totalMoneyRaised = 5;
  final int totalStackeholders = 5;
  
  final int totalProjectsFounded = 5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Dashboard'),),
      body:Column(
        children: [

          UpperCard(amount: totalMoneyRaised),
          Row(
            children: [
              Expanded(
                child: MiddleCard(title: 'Number of projects funded:', amount: totalProjectsFounded),
              ),
              Expanded(
                child: MiddleCard(title: 'Number of Stakeholders:', amount: totalStackeholders),
              ),
            ]
          ),
          Expanded(
            child: ListView.builder(
            
          // Let the ListView know how many items it needs to build.
          itemCount: totalProjects,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = projects[index];
            if (item.isOpened == false){
              return ProjectCard (project:item);
            }
            
          return SizedBox();},
          
          ),)
          
        ],),
      floatingActionButton: ExpandableFab(
        distance: 60.0,
        children: [
          ActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProjectsView()),
              )},
            icon: const Icon(Icons.add_business),
            tooltip: 'Add projects',
          ),
          ActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddStackeholdersView()),
              )},
            icon: const Icon(Icons.add_card),
            tooltip: 'Add stackeholders',
          ),
        ],
      ),
    );
  }
}


