import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/crypto.dart';
import '../pages/crypto_detail_page.dart';
import 'animated_text_widget.dart';

class CryptoListItem extends StatelessWidget {
  final Crypto crypto;

  const CryptoListItem({super.key, required this.crypto});

  String _formatPrice(double price) {
    String str = price.toStringAsFixed(5);
    return str.replaceAll(RegExp(r'([.]*0+)(?!.*\d)'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CryptoDetailPage(crypto: crypto)),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1B232A), Color(0xFF26323F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Color(0xE1047597),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              if (crypto.marketCapRank != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '#${crypto.marketCapRank}',
                    style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(width: 2),
              ],
              Hero(
                tag: crypto.id,
                child: _buildCryptoIcon(crypto.imageUrl),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name.length > 17 ? '${crypto.name.substring(0, 17)}…' : crypto.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF1F2F6),
                      ),
                    ),
                    Text(
                      crypto.symbol.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF9EA9B8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedTextWidget(
                    text: "\$${_formatPrice(crypto.price)}",
                    startSize: 14,
                    endSize: 14.3,
                    startColor: const Color(0xFFE7727B),
                    endColor: const Color(0xFFF4DDDD),
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
              // const SizedBox(width: 6),
              // const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
            ],
          ),
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
        placeholderBuilder: (context) => const CircularProgressIndicator(strokeWidth: 1.5),
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
