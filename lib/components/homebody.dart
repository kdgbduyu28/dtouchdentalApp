import 'package:flutter/material.dart';
import 'package:dtouchdental/constants/constants.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
                "Appointments",
                style: Constant.kPageNavStyle
            ),
            Constant.kToggleSwitch,
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        FractionallySizedBox(
          widthFactor: 0.8,
          child: Card(
            child: Column(
              children: const [
                SizedBox(
                  height: 10,
                ),
                Text("10:00 AM | July 28, 2022", style: TextStyle(
                    fontSize: 25
                ),),
                ListTile(
                  leading: Text("Dentist: "),
                  title: Text("Dra. Djayan S. Pichay"),
                ),
                ListTile(
                  leading: Text("Comments: "),
                  title: Text("OP + LC"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}