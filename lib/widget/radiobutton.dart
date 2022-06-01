import 'package:flutter/material.dart';

class RadioButton1 extends StatefulWidget {
  const RadioButton1({Key? key}) : super(key: key);

  @override
  _RadioButton1State createState() => _RadioButton1State();
}

class _RadioButton1State extends State<RadioButton1> {
  // The inital group value
  String _selectedGender = 'male';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Please let us know your gender:'),
        ListTile(
          leading: Radio<String>(
            value: 'male',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
          title: const Text('Male'),
        ),
        ListTile(
          leading: Radio<String>(
            value: 'female',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
          title: const Text('Female'),
        ),
        const SizedBox(height: 5),
        Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
      ],
    );
  }
}
