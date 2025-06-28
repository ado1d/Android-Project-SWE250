import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ExchangesPage extends StatefulWidget {
  const ExchangesPage({super.key});

  @override
  _ExchangesPageState createState() => _ExchangesPageState();
}

class _ExchangesPageState extends State<ExchangesPage> {
  List<dynamic> exchanges = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchanges();
  }

  Future<void> fetchExchanges() async {
    const url = 'https://api.coingecko.com/api/v3/exchanges?page=1&per_page=15';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          exchanges = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load exchanges');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B232A),
        title: const Text(
          'Exchanges',
          style: TextStyle(
            color: Color(0xFF37FB83),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF37FB83),
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.greenAccent))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: exchanges.length,
              itemBuilder: (context, index) {
                final exchange = exchanges[index];
                return _buildExchangeCard(exchange);
              },
            ),
    );
  }

  Widget _buildExchangeCard(dynamic exchange) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Logo + Name + Trust score
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    exchange['image'] ?? '',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    exchange['name'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.greenAccent, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        exchange['trust_score'].toString(),
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            // Country and Year
            Row(
              children: [
                if (exchange['country'] != null)
                  Text(
                    '${exchange['country']}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                if (exchange['year_established'] != null) ...[
                  const SizedBox(width: 10),
                  Text(
                    'Since ${exchange['year_established']}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              exchange['description'] ?? '',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 10),
            // Volume
            Text(
              '24h Volume: ${exchange['trade_volume_24h_btc'].toStringAsFixed(2)} BTC',
              style: const TextStyle(color: Colors.lightBlueAccent, fontSize: 13),
            ),
            const SizedBox(height: 8),
            // Visit Website Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse(exchange['url']);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.open_in_new, size: 18),
                label: const Text('Visit Website'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37FB83),
                  foregroundColor: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
