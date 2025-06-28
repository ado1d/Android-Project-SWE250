import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../main.dart';
import '../models/crypto.dart';
import '../widgets/crypto_list_item.dart';
import '../widgets/animated_search_box.dart';
import 'custom_icon_button.dart';
import 'menu_page.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  bool isSearching = false;
  String searchQuery = "";
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchCryptoPrices();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) => fetchCryptoPrices());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> fetchCryptoPrices() async {
    final url = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd");
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body) as List<dynamic>;
        setState(() {
          cryptoList = data
              .map((coin) => Crypto(
                    id: coin['id'],
                    name: coin['name'],
                    symbol: coin['symbol'].toUpperCase(),
                    price: (coin['current_price'] as num).toDouble(),
                    changePercent: (coin['price_change_percentage_24h'] as num?)?.toDouble() ?? 0,
                    imageUrl: coin['image'],
                    volume: (coin['total_volume'] as num?)?.toDouble(),
                    marketCapRank: coin['market_cap_rank'] as int?,
                  ))
              .toList();
        });
      }
    } catch (e) {
      print("Error fetching crypto: $e");
    }
  }

  void _logout() async {
    await _authService.signOut();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = cryptoList.where((c) => c.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B232A),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black26,
        leading: CustomIconButton(
          onPressed: () {},
          assetPath: 'assets/logo.png',
          customColor: const Color(0xFF060505),
          size: 30,
          isSvgFile: false,
          offset: const Offset(15, 0),
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSearching
              ? AnimatedSearchBox(
                  key: const ValueKey('searchBox'),
                  onChanged: (q) => setState(() => searchQuery = q),
                )
              : const Text(
                  "MarketPlace",
                  key: ValueKey('titleText'),
                  style: TextStyle(
                    color: Color(0xFF37FB83),
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 8.0),
            child: IconButton(
              icon: Icon(
                isSearching ? Icons.close : Icons.search,
                color: const Color(0xFF37FB83),
              ),
              onPressed: () {
                setState(() {
                  if (isSearching) searchQuery = "";
                  isSearching = !isSearching;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 1.0),
            child: CustomIconButton(
              onPressed: () {
                setState(() => isSearching = false);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    child: const MenuPage(),
                  ),
                );
              },
              assetPath: 'assets/icons/Light/More Square.svg',
              isSvgFile: true,
              size: 45,
              iconColor: const Color(0xFF5ED5A8),
              offset: const Offset(-15, 3),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Picks",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEDF1E8),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filtered.isEmpty && searchQuery.isNotEmpty
                  ? const Center(child: Text("No results found", style: TextStyle(color: Colors.white70)))
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (_, i) => CryptoListItem(crypto: filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
