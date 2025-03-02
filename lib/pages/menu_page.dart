import 'package:appproject/pages/homepage.dart';
import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: _buildAppBar(context),
      body: _buildMenu(),
    );
  }

  Widget _buildMenu() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildMenuItem(
          icon: Icons.dashboard,
          text: "Dashboard",
          onTap: () {

          },
        ),
        _buildMenuItem(
          icon: Icons.pie_chart,
          text: "Market Overview",
          onTap: () {

          },
        ),
        _buildMenuItem(
          icon: Icons.person_4_rounded,
          text: "My Profile",
          onTap: () {

          },
        ),
        _buildMenuItem(
          icon: Icons.settings,
          text: "Settings",
          onTap: () {

          },
        ),
        _buildMenuItem(
          icon: Icons.logout,
          text: "Logout",
          onTap: () {

          },
        ),
      ],
    );
  }


  Widget _buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return Card(
      elevation: 3,
      color: Color(0xF6633F3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF37FB83)),
        title: Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEDF1E8),)),
        tileColor: Color(0xFF1B232A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
      ),
    );
  }
}

AppBar _buildAppBar (BuildContext context) {
  return AppBar(
    title: const Text(
      "Menu",
      style: TextStyle(
        color: Color(0xFF37FB83),
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: const Color(0xFF1B232A),
    centerTitle: true,
    elevation: 3.0,
    shadowColor: Colors.black26,

    //back icon
    leading: CustomIconButton(
      onPressed: () {
        // Handle back action
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      assetPath: '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
  <path fill-rule="evenodd" d="M9.53 2.47a.75.75 0 0 1 0 1.06L4.81 8.25H15a6.75 6.75 0 0 1 0 13.5h-3a.75.75 0 0 1 0-1.5h3a5.25 5.25 0 1 0 0-10.5H4.81l4.72 4.72a.75.75 0 1 1-1.06 1.06l-6-6a.75.75 0 0 1 0-1.06l6-6a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd" />
</svg>
  ''',
      isSvgCode: true,
      iconColor: const Color(0xFF5ED5A8),
      size: 30,
      offset: const Offset(15, 0),
    ),
    //question icon
    actions: [
      CustomIconButton(


        onPressed: () {
          // Handle more action

        },


        assetPath: ''' <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="size-6">
  <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm11.378-3.917c-.89-.777-2.366-.777-3.255 0a.75.75 0 0 1-.988-1.129c1.454-1.272 3.776-1.272 5.23 0 1.513 1.324 1.513 3.518 0 4.842a3.75 3.75 0 0 1-.837.552c-.676.328-1.028.774-1.028 1.152v.75a.75.75 0 0 1-1.5 0v-.75c0-1.279 1.06-2.107 1.875-2.502.182-.088.351-.199.503-.331.83-.727.83-1.857 0-2.584ZM12 18a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z" clip-rule="evenodd" />
</svg>
''',
        isSvgCode: true,
        size: 45,
        iconColor: const Color(0xFF5ED5A8),
        offset: const Offset(-15, 3),
      ),
    ],
    );
}
