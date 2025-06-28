import 'package:appproject/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/crypto.dart';
import '../widgets/crypto_list_item.dart';
import 'custom_icon_button.dart';
import 'menu_page.dart';

class TopGainersPage extends StatefulWidget {
  const TopGainersPage({super.key});

  @override
  _TopGainersPageState createState() => _TopGainersPageState();
}

class _TopGainersPageState extends State<TopGainersPage> {
  List<Crypto> newCryptoList = [];
  Timer? _timer;
  // bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTopGainers();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchTopGainers();
    });
  }

  void fetchTopGainers() {
    // final url = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd");

    List<Crypto> allCoins = cryptoList;

    allCoins.sort((a, b) => b.changePercent.compareTo(a.changePercent));

    List<Crypto> topGainers = allCoins.where((coin) => coin.changePercent > 0).toList();

    setState(() {
      newCryptoList = topGainers;
      // isLoading = false;
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
            "To The Moon🚀",
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
                      "No top gainers available",
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
        customColor: const Color(0xFF060505),
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
