import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pswdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  DateTime? dob;
  String gender = '';
  final TextEditingController chronicConditionController =
      TextEditingController();
  final TextEditingController surgeriesController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController familyHistoryController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController alcoholController = TextEditingController();
  final TextEditingController currentHealthController = TextEditingController();
  final TextEditingController dietController = TextEditingController();
  final TextEditingController exerciseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Personal Information',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: pswdController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 20.h),
            Text(
              'Date of Birth',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              onPressed: () {
                _selectDateOfBirth(context);
              },
              child: dob != null
                  ? Text('${dob!.day}/${dob!.month}/${dob!.year}')
                  : const Text('Select Date of Birth'),
            ),
            SizedBox(height: 20.h),
            Text(
              'Gender',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Column(
              children: <Widget>[
                RadioListTile<String>(
                  title: const Text('Male'),
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Female'),
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Other'),
                  value: 'Other',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              'Medical History',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            TextFormField(
              controller: chronicConditionController,
              decoration:
                  const InputDecoration(labelText: 'Chronic Conditions'),
            ),
            TextFormField(
              controller: surgeriesController,
              decoration: const InputDecoration(
                  labelText: 'Surgeries/ Hospitalizations'),
            ),
            TextFormField(
              controller: medicationsController,
              decoration:
                  const InputDecoration(labelText: 'Current Medications'),
            ),
            TextFormField(
              controller: allergiesController,
              decoration: const InputDecoration(labelText: 'Allergies'),
            ),
            TextFormField(
              controller: familyHistoryController,
              decoration:
                  const InputDecoration(labelText: 'Family Medical History'),
            ),
            TextFormField(
              controller: smokingController,
              decoration: const InputDecoration(labelText: 'Smoking History'),
            ),
            TextFormField(
              controller: alcoholController,
              decoration:
                  const InputDecoration(labelText: 'Alcohol Consumption'),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                Map<String, String> m = {
                  'usrname': usernameController.text,
                  'pswd': pswdController.text,
                  'name': nameController.text,
                  'dob': dob != null
                      ? '${dob!.day}/${dob!.month}/${dob!.year}'
                      : '',
                  'gender': gender,
                  'chronic-conditions': chronicConditionController.text,
                  'medications': medicationsController.text,
                  'surgeries': surgeriesController.text,
                  'allergies': allergiesController.text,
                  'family-history': familyHistoryController.text,
                  'smoking': smokingController.text,
                  'alcohol': alcoholController.text,
                };

                signup(m);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Submitted'),
                      content: const Text('Signup successfull!'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateOfBirth(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != dob) {
      setState(() {
        dob = pickedDate;
      });
    }
  }
}
