import 'package:flutter/material.dart';

@immutable
class MiddleCard extends StatelessWidget {
  const MiddleCard({
    Key? key,
    required this.title,
    required this.amount,
  }) : super(key: key);

  final String title;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [          
          ListTile(
            title: Text(title)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              amount.toString(),
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}