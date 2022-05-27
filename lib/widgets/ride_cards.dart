import 'package:flutter/material.dart';
import 'package:capex_mobile/widgets/ride_card.dart';

class RideCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RideCard(),
        RideCard(),
        RideCard(),
      ],
    );
  }
}
