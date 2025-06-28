import 'package:flutter/material.dart';

class ProTipsPage extends StatelessWidget {
  ProTipsPage({super.key});

  final List<Map<String, String>> tips = [
    {
      'title': 'Invest in Top Market Cap Coins',
      'description':
          'Always prioritize coins with high market capitalization and strong fundamentals. They are less volatile and more reliable in the long term.'
    },
    {
      'title': 'Use Stop-Loss Orders',
      'description':
          'Protect your capital by using stop-loss orders with a proper risk-reward ratio. This helps limit losses during market corrections.'
    },
    {
      'title': 'Diversify Your Portfolio',
      'description':
          'Avoid putting all your funds into a single asset. Diversify across sectors and coins to reduce overall risk.'
    },
    {
      'title': 'Stay Informed',
      'description':
          'Regularly read credible news sources and project updates to stay ahead of the market trends and avoid surprises.'
    },
    {
      'title': 'Avoid Emotional Trading',
      'description': 'Make decisions based on data and analysis, not emotions. Have a clear strategy and stick to it.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B232A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B232A),
        title: const Text(
          'Pro Tips',
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
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final tip = tips[index];
          return _buildTipCard(tip['title']!, tip['description']!);
        },
      ),
    );
  }

  Widget _buildTipCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lightbulb, color: Color(0xFF37FB83), size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
