import 'package:appproject/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'custom_icon_button.dart';
import '../services/auth_service.dart';
import 'developer_info_page.dart';
import 'login_page.dart';
import 'exchanges_page.dart';

import 'pro_tips_page.dart';

const Color kPrimaryBackgroundColor = Color(0xFF1B232A);
const Color kAccentGreenColor = Color(0xFF37FB83);
const Color kIconGreenColor = Color(0xFF5ED5A8);
const Color kMenuTextColor = Color(0xFFEDF1E8);
const Color kCardBackgroundColor = Color(0x1A6633F3);

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBackgroundColor,
      appBar: _buildAppBar(context),
      body: _buildMenu(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "Menu",
        style: TextStyle(
          color: kAccentGreenColor,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: kPrimaryBackgroundColor,
      centerTitle: true,
      elevation: 3.0,
      shadowColor: Colors.black26,
      leading: CustomIconButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.leftToRightWithFade,
              child: const MainPage(),
            ),
          );
        },
        assetPath: '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
  <path fill-rule="evenodd" d="M9.53 2.47a.75.75 0 0 1 0 1.06L4.81 8.25H15a6.75 6.75 0 0 1 0 13.5h-3a.75.75 0 0 1 0-1.5h3a5.25 5.25 0 1 0 0-10.5H4.81l4.72 4.72a.75.75 0 1 1-1.06 1.06l-6-6a.75.75 0 0 1 0-1.06l6-6a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd"/>
</svg>
        ''',
        isSvgCode: true,
        iconColor: kIconGreenColor,
        size: 30,
        offset: const Offset(15, 0),
      ),
//       actions: [
//         CustomIconButton(
//           onPressed: () {
//
//           },
//           assetPath: '''
// <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
//   <path fill-rule="evenodd" d="M2.25 12c0-5.385 4.365-9.75 9.75-9.75s9.75 4.365 9.75 9.75-4.365 9.75-9.75 9.75S2.25 17.385 2.25 12Zm11.378-3.917c-.89-.777-2.366-.777-3.255 0a.75.75 0 0 1-.988-1.129c1.454-1.272 3.776-1.272 5.23 0 1.513 1.324 1.513 3.518 0 4.842a3.75 3.75 0 0 1-.837.552c-.676.328-1.028.774-1.028 1.152v.75a.75.75 0 0 1-1.5 0v-.75c0-1.279 1.06-2.107 1.875-2.502.182-.088.351-.199.503-.331.83-.727.83-1.857 0-2.584ZM12 18a.75.75 0 1 0 0-1.5.75.75 0 0 0 0 1.5Z" clip-rule="evenodd"/>
// </svg>
//           ''',
//           isSvgCode: true,
//           size: 45,
//           iconColor: kIconGreenColor,
//           offset: const Offset(-15, 3),
//         ),
//       ],
    );
  }

  Widget _buildMenu(BuildContext context) {
    final menuItems = [
      {"icon": Icons.swap_vert_circle, "text": "Exchanges"},
      {"icon": Icons.lightbulb_outline, "text": "Pro Tips"},
      {"icon": Icons.developer_mode, "text": "Developer Info"},
      {"icon": Icons.logout, "text": "Logout"},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: menuItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return _buildMenuItem(
          index: index,
          icon: item["icon"] as IconData,
          text: item["text"] as String,
          onTap: () async {
            if (item["text"] == "Logout") {
              await _handleLogout(context);
            } else {
              setState(() {
                selectedIndex = index;
              });

              Widget targetPage;
              switch (item["text"]) {
                case "Exchanges":
                  targetPage = const ExchangesPage();
                  break;
                case "Pro Tips":
                  targetPage = ProTipsPage();
                  break;
                case "Developer Info":
                  targetPage = DeveloperInfoPage();
                  break;
                default:
                  targetPage = const ExchangesPage();
              }

              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: targetPage,
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildMenuItem({
    required int index,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? kAccentGreenColor.withOpacity(0.15) : kCardBackgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: isSelected ? Border.all(color: kAccentGreenColor, width: 2) : null,
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? kAccentGreenColor : kAccentGreenColor.withOpacity(0.85),
              size: 28,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isSelected ? kAccentGreenColor : kMenuTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );

    if (confirmed) {
      try {
        await AuthService().signOut();
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(type: PageTransitionType.fade, child: const LoginPage()),
            (route) => false,
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Logout failed: $e")),
          );
        }
      }
    }
  }
}
