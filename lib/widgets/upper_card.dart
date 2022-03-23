import 'package:flutter/material.dart';

@immutable
class UpperCard extends StatelessWidget {
  const UpperCard({
    Key? key,
    required this.amount,

  }) : super(key: key);

  final double amount;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text('Total money raised: ' + amount.toString() + '€')),
        ],
      ),
    );
  }
}

