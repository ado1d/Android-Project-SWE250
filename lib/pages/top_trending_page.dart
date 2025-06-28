import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/crypto.dart';
import '../widgets/crypto_list_item.dart';
import 'custom_icon_button.dart';
import 'menu_page.dart';

import 'top_gainers_page.dart';
import 'top_losers_page.dart';
import 'top_trending_page.dart';

class TopTrendingPage extends StatefulWidget {
  const TopTrendingPage({super.key});

  @override
  _TopTrendingPageState createState() => _TopTrendingPageState();
}

class _TopTrendingPageState extends State<TopTrendingPage> {
  List<Crypto> cryptoList = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchCryptoPrices();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      fetchCryptoPrices();
    });
  }

  Future<void> fetchCryptoPrices() async {
    final url = Uri.parse("https://api.coingecko.com/api/v3/search/trending");

    try {
      final response = await http.get(url);
      print("Response status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        final List<dynamic> coins = decodedData['coins'];
        setState(() {
          cryptoList = coins.map((coin) {
            final Map<String, dynamic> item = coin['item'];
            return Crypto(
              id: item['id'],
              name: item['name'],
              symbol: item['symbol'].toUpperCase(),
              price: (item['data']['price'] as num).toDouble(),
              changePercent: (item['data']['price_change_percentage_24h']['usd'] as num).toDouble(),
              imageUrl: item['thumb'],
              marketCapRank: item['market_cap_rank'],
              volume: item['volume'],
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load crypto prices, status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching crypto prices: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: _buildAppBar(context),
      body: _buildCryptoList(),
      // bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildCryptoList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hot Picks 🔥",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEDF1E8),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: cryptoList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: cryptoList.length,
                    itemBuilder: (context, index) {
                      return CryptoListItem(crypto: cryptoList[index]);
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
        customColor: const Color(0xFF121010),
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
