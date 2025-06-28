import 'package:appproject/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../models/crypto.dart';
import '../widgets/crypto_list_item.dart';
import 'custom_icon_button.dart';
import 'menu_page.dart';

class TopLosersPage extends StatefulWidget {
  const TopLosersPage({super.key});

  @override
  _TopLosersPageState createState() => _TopLosersPageState();
}

class _TopLosersPageState extends State<TopLosersPage> {
  List<Crypto> newCryptoList = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchTopLosers();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchTopLosers();
    });
  }

  void fetchTopLosers() {
    List<Crypto> allCoins = List.from(cryptoList);
    allCoins.sort((a, b) => a.changePercent.compareTo(b.changePercent));
    List<Crypto> topLosers = allCoins.where((coin) => coin.changePercent < 0).toList();

    setState(() {
      newCryptoList = topLosers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: _buildAppBar(context),
      body: _buildCryptoList(),
    );
  }

  Widget _buildCryptoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sinking Ships 🚢",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEDF1E8),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: newCryptoList.isEmpty
                ? const Center(
                    child: Text(
                      "No top losers available",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: newCryptoList.length,
                    itemBuilder: (context, index) {
                      return CryptoListItem(crypto: newCryptoList[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "MarketPlace",
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
      leading: CustomIconButton(
        onPressed: () {},
        assetPath: 'assets/logo.png',
        customColor: const Color(0xFF0A090A),
        size: 30,
        isSvgFile: false,
        offset: const Offset(15, 0),
      ),
      actions: [
        CustomIconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuPage()),
            );
          },
          assetPath: 'assets/icons/Light/More Square.svg',
          isSvgFile: true,
          size: 45,
          iconColor: const Color(0xFF5ED5A8),
          offset: const Offset(-15, 3),
        ),
      ],
    );
  }
}
