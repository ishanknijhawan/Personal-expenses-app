import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double percentage;
  final double totalAmount;

  ChartBar(this.label, this.totalAmount, this.percentage);

  @override
  Widget build(BuildContext context) {
    print('Getting here percent with value $percentage');
    //var percent = totalAmount / percentage;
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text('\$${totalAmount.toStringAsFixed(0)}'),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromARGB(220, 220, 220, 1),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
