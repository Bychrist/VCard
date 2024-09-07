import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard_project/models/contact_model.dart';
import 'package:vcard_project/pages/scan_page.dart';
import 'package:vcard_project/providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contactList = [];
  @override
  void didChangeDependencies() {
    Provider.of<ContactProvider>(context, listen: false).getAllContacts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact List',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(ScanPage.routeName);
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          currentIndex: selectedIndex,
          backgroundColor: Colors.blue[100],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, // Bold for the selected item
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal, // Normal for unselected items
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'All',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.contactList.length,
          itemBuilder: (context, index) {
            final contact = provider.contactList[index];
            print(provider.contactList.length);
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(contact.name),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                    contact.favorite ? Icons.favorite : Icons.favorite_border),
              ),
            );
          },
        ),
      ),
    );
  }
}
