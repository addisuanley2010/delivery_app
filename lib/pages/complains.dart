import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/constants/constants.dart';
import 'package:delivery/models/user.dart';
import 'package:delivery/ui/client/component/text_custom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _complaintController = TextEditingController();

  String name = '';
  String email = '';
  String uId = '';
  String role = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Save the complaint to Firebase Firestore
      print('name = $name');
      FirebaseFirestore.instance.collection('complaints').add({
        'complaint': _complaintController.text,
        'ownerName': name,
        'ownerId': uId,
        'ownerEmail': email,
        'ownerRole': role,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        // Reset the form after successful submission
        _formKey.currentState!.reset();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Your complaint has been submitted.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to submit your complaint.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    }
  }

  Stream<void> getPersonalInformationStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    String a = currentUser!.uid;
    print('current user = $a');

    final customerRef =
        FirebaseFirestore.instance.collection('customers').doc(currentUser.uid);
    customerRef.snapshots().map((customerSnapshot) {
      final customerData = customerSnapshot.data() as Map<String, dynamic>;
      print('name= $name');
      name = customerData['name'];
      name = customerData['name'];
      email = customerData['email'];
      role = customerData['role'];
      uId = currentUser.uid;
    });

    return Stream.empty(); // Return an empty stream if currentUser is null
  }

  void clearForm() {
    _complaintController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    getPersonalInformationStream();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            clearForm();
          },
          child: Container(
              alignment: Alignment.center,
              child: const TextCustom(
                  text: 'Cancel',
                  color: ColorsFrave.primaryColor,
                  fontSize: 15)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 70,
        title: const TextCustom(
          text: 'write your complaint',
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _complaintController,
                decoration: const InputDecoration(
                  labelText: 'Complaint',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your complaint.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
