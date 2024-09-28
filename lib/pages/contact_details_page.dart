import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vcard_project/models/contact_model.dart';
import 'package:vcard_project/providers/contact_provider.dart';
import 'package:vcard_project/utils/helper_functions.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = 'details';
  final int id;
  const ContactDetailsPage({super.key, required this.id});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late int id;
  @override
  void initState() {
    id = widget.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) =>
            FutureBuilder<Map<String, dynamic>>(
                future: provider.getContactDetail(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final contact = snapshot.data!;
                    print(contact);
                    final file = File(contact['image']);

                    return ListView(
                      padding: const EdgeInsets.all(12.0),
                      children: [
                        Image.file(
                          file,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        ListTile(
                          title: Text(
                            contact['mobile'],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  callContact(contact['mobile']);
                                },
                                icon: const Icon(Icons.call),
                              ),
                              IconButton(
                                onPressed: () {
                                  smsContact(contact['mobile']);
                                },
                                icon: const Icon(Icons.sms),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('failed to load data'),
                    );
                  }

                  return const Center(
                    child: Text('Please wait'),
                  );
                }),
      ),
    );
  }

  void callContact(contact) async {
    final url = 'tel:$contact';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'can not perform this task');
    }
  }

  void smsContact(contact) async {
    final url = 'sms:$contact';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'can not perform this task');
    }
  }
}
