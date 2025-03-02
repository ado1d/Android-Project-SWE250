import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/crypto.dart';
import '../pages/crypto_detail_page.dart';
import 'animated_text_widget.dart'; // Import the detail page

class CryptoListItem extends StatelessWidget {
  final Crypto crypto;

  const CryptoListItem({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CryptoDetailPage(crypto: crypto)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B232A),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xE1047597),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            _buildCryptoIcon(crypto.imageUrl),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFCBF1CC)),
                ),
                Text(
                  crypto.symbol.toUpperCase(),
                  style: const TextStyle(fontSize: 11, color: Colors.white54),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text(
                //   "\$${crypto.price.toString()}",
                //   style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                // ),

                AnimatedTextWidget(
                  text: "\$${crypto.price.toString()}",
                  startSize: 14,
                  endSize: 14.3,
                  startColor: Color(0xFFE7727B),
                  endColor: Color(0xFFF4DDDD),
                ),
                Text(
                  "${crypto.changePercent >= 0 ? "+" : ""}${crypto.changePercent.toStringAsFixed(2)}%",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: crypto.changePercent >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoIcon(String imageUrl) {
    if (imageUrl.endsWith('.svg')) {
      return SvgPicture.network(
        imageUrl,
        width: 30,
        height: 30,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 30,
        height: 30,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
  }
}
