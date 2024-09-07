import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard_project/models/contact_model.dart';
import 'package:vcard_project/pages/home_page.dart';
import 'package:vcard_project/providers/contact_provider.dart';
import 'package:vcard_project/utils/constants.dart';
import 'package:vcard_project/utils/helper_functions.dart';

class FormPage extends StatefulWidget {
  static const String routeName = 'form';
  final ContactModel contactModel;
  const FormPage({super.key, required this.contactModel});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final companyController = TextEditingController();
  final designationController = TextEditingController();
  final addressController = TextEditingController();
  final webController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contactModel.name;
    mobileController.text = widget.contactModel.mobile;
    emailController.text = widget.contactModel.email;
    addressController.text = widget.contactModel.address;
    companyController.text = widget.contactModel.company;
    designationController.text = widget.contactModel.designation;
    webController.text = widget.contactModel.website;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
        actions: [
          IconButton(
            onPressed: saveContact,
            icon: const Icon(Icons.save),
            color: const Color.fromARGB(255, 114, 109, 109),
            iconSize: 20,
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(12.0),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter full name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg; // Ensure this is defined in `constants.dart`
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: mobileController,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter phone',
                labelText: 'Mobile',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return emptyFieldErrMsg;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Enter email',
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                icon: Icon(Icons.location_city),
                hintText: 'Enter address',
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(
                icon: Icon(Icons.corporate_fare),
                hintText: 'Enter company name',
                labelText: 'Company',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: designationController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter designation', // Fixed the hintText
                labelText: 'Designation', // Fixed the labelText
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: webController,
              decoration: const InputDecoration(
                icon: Icon(Icons.web),
                hintText: 'Enter website',
                labelText: 'Website',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    companyController.dispose();
    designationController.dispose();
    addressController.dispose();
    webController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void saveContact() async {
    if (_formKey.currentState!.validate()) {
      widget.contactModel.name = nameController.text;
      widget.contactModel.mobile = mobileController.text;
      widget.contactModel.email = emailController.text;
      widget.contactModel.address = addressController.text;
      widget.contactModel.designation = designationController.text;
      widget.contactModel.company = companyController.text;
      widget.contactModel.website = webController.text;

      Provider.of<ContactProvider>(context, listen: false)
          .insertContact(widget.contactModel)
          .then((value) {
        if (value > 0) {
          showMsg(context, 'Saved');
          context.goNamed(HomePage.routeName);
        }
      }).catchError((error) {
        showMsg(context, 'Failed to save');
      });
    }
  }
}
