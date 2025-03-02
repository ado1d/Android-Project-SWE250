// TODO Implement this library.
import 'package:flutter/material.dart';
import '../models/crypto.dart';
import 'custom_icon_button.dart';
import 'homepage.dart';

class CryptoDetailPage extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailPage({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          crypto.name,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF37FB83)),
        ),
        backgroundColor: const Color(0xFF1B232A),
        centerTitle: true,
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
      ),
      backgroundColor: const Color(0xFF1B232A),




      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            crypto.imageUrl.endsWith('.svg')
                ? Image.network(crypto.imageUrl, width: 80, height: 80)
                : Image.network(crypto.imageUrl, width: 80, height: 80),

            const SizedBox(height: 10),
            Text(
              "${crypto.name} (${crypto.symbol})",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),

            const SizedBox(height: 10),
            Text(
              "Price: \$${crypto.price.toString()}",
              style: const TextStyle(fontSize: 18, color: Colors.greenAccent, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),


            Text(
              "24h Change: ${crypto.changePercent > 0 ? "+" : ""}${crypto.changePercent.toStringAsFixed(2)}%",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: crypto.changePercent >= 0 ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            _buildTradingSignals(),
          ],
        ),
      ),
    );
  }

  Widget _buildTradingSignals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Trading Signals",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),

        _buildSignalItem("Buy", crypto.changePercent > 0 ? "Strong Buy" : "Hold", Colors.green),
        _buildSignalItem("Sell", crypto.changePercent < 0 ? "Strong Sell" : "Hold", Colors.red),
        _buildSignalItem("Neutral", "Wait & Watch", Colors.yellow),
      ],
    );
  }

  Widget _buildSignalItem(String type, String recommendation, Color color) {
    return Card(
      color: const Color(0xFF2E3A45),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(
          Icons.trending_up,
          color: color,
        ),
        title: Text(
          type,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          recommendation,
          style: TextStyle(fontSize: 14, color: color),
        ),
      ),
    );
  }
}
