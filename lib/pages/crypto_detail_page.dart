import 'package:appproject/pages/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chart_sparkline/chart_sparkline.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:math';

import '../models/crypto.dart';
import 'custom_icon_button.dart';
import 'homepage.dart';

class CryptoDetailPage extends StatefulWidget {
  final Crypto crypto;
  const CryptoDetailPage({super.key, required this.crypto});

  @override
  _CryptoDetailPageState createState() => _CryptoDetailPageState();
}

class _CryptoDetailPageState extends State<CryptoDetailPage> {
  double? rsi;
  List<double>? macdLine;
  List<double>? signalLine;
  String tradingSignal = "Calculating...";
  bool isLoading = true;
  List<double> priceHistory = []; // price history

  int selectedDays = 30;

  @override
  void initState() {
    super.initState();
    fetchAndCalculateIndicators();
  }

  Future<void> fetchAndCalculateIndicators() async {
    setState(() {
      isLoading = true;
    });
    try {
      String coinId = widget.crypto.id;
      List<double> prices = await fetchHistoricalPrices(coinId, selectedDays);
      double calculatedRSI = calculateRSI(prices);
      Map<String, List<double>> macdData = calculateMACD(prices);
      double latestMacd = macdData['macdLine']!.last;
      double latestSignal = macdData['signalLine']!.last;

      String signal;
      if (calculatedRSI < 50 && latestMacd > latestSignal) {
        signal = "Bullish";
      } else if (calculatedRSI > 70 && latestMacd < latestSignal) {
        signal = "Bearish";
      } else if (calculatedRSI < 40) {
        signal = "Bullish";
      } else if (calculatedRSI > 60 && calculatedRSI < 70) {
        signal = "Bullish";
      } else if (calculatedRSI > 85) {
        signal = "Bearish";
      } else {
        signal = "Neutral";
      }

      setState(() {
        rsi = calculatedRSI;
        macdLine = macdData['macdLine'];
        signalLine = macdData['signalLine'];
        tradingSignal = signal;
        priceHistory = prices;
        isLoading = false;
      });
    } catch (e) {
      print("Error calculating indicators: $e");
      setState(() {
        isLoading = false;
        tradingSignal = "Api limit hit Try again plz";
      });
    }
  }

  Future<List<double>> fetchHistoricalPrices(String coinId, int days) async {
    final url = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=$days&interval=daily");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> pricesRaw = data['prices'];
      List<double> prices = pricesRaw.map<double>((entry) => (entry[1] as num).toDouble()).toList();
      return prices;
    } else {
      throw Exception("Failed to fetch historical prices");
    }
  }

  List<double> calculateEMA(List<double> prices, int period) {
    List<double> ema = [];
    double multiplier = 2 / (period + 1);
    double sma = prices.take(period).reduce((a, b) => a + b) / period;
    ema.add(sma);
    for (int i = period; i < prices.length; i++) {
      double currentEma = ((prices[i] - ema.last) * multiplier) + ema.last;
      ema.add(currentEma);
    }
    return ema;
  }

  double calculateRSI(List<double> prices, {int period = 14}) {
    if (prices.length < period + 1) {
      period = prices.length - 1;
      if (period < 1) {
        throw Exception('Not enough data to calculate RSI');
      }
    }

    List<double> changes = [];
    for (int i = 1; i < prices.length; i++) {
      changes.add(prices[i] - prices[i - 1]);
    }

    double gain = 0, loss = 0;
    for (int i = 0; i < period; i++) {
      double change = changes[i];
      if (change > 0) {
        gain += change;
      } else {
        loss += change.abs();
      }
    }
    double avgGain = gain / period;
    double avgLoss = loss / period;
    for (int i = period; i < changes.length; i++) {
      double change = changes[i];
      double currentGain = change > 0 ? change : 0;
      double currentLoss = change < 0 ? change.abs() : 0;
      avgGain = ((avgGain * (period - 1)) + currentGain) / period;
      avgLoss = ((avgLoss * (period - 1)) + currentLoss) / period;
    }
    double rs = avgLoss == 0 ? 0 : avgGain / avgLoss;
    double rsiValue = avgLoss == 0 ? 100 : 100 - (100 / (1 + rs));
    return rsiValue;
  }

  Map<String, List<double>> calculateMACD(List<double> prices) {
    List<double> ema12 = calculateEMA(prices, min(prices.length, 12));
    List<double> ema26 = calculateEMA(prices, min(prices.length, 24));
    int offset = ema12.length - ema26.length;
    List<double> macdLine = [];
    for (int i = 0; i < ema26.length; i++) {
      macdLine.add(ema12[i + offset] - ema26[i]);
    }
    List<double> signalLine = calculateEMA(macdLine, 9);
    return {'macdLine': macdLine, 'signalLine': signalLine};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.crypto.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF37FB83),
            ),
          ),
          backgroundColor: const Color(0xFF1B232A),
          centerTitle: true,
          leading: CustomIconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
            assetPath: '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
  <path fill-rule="evenodd" d="M9.53 2.47a.75.75 0 0 1 0 1.06L4.81 8.25H15a6.75 6.75 0 0 1 0 13.5h-3a.75.75 0 0 1 0-1.5h3a5.25 5.25 0 1 0 0-10.5H4.81l4.72 4.72a.75.75 0 1 1-1.06 1.06l-6-6a.75.75 0 0 1 0-1.06l6-6a.75.75 0 0 1 1.06 0Z" clip-rule="evenodd" />
</svg>
          ''',
            isSvgCode: true,
            iconColor: const Color(0xFF5ED5A8),
            size: 30,
            offset: const Offset(15, 0),
          ),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff030637),
                    Color(0xff3C0753),
                    Color(0xff720455),
                    Color(0xff910A67),
                    // Color(0xff980F5A),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
              child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            widget.crypto.imageUrl.endsWith('.svg') ? null : NetworkImage(widget.crypto.imageUrl),
                        child: widget.crypto.imageUrl.endsWith('.svg')
                            ? Image.network(
                                widget.crypto.imageUrl,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${widget.crypto.name} (${widget.crypto.symbol.toUpperCase()})",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Price: \$${widget.crypto.price.toStringAsFixed(5)}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "24h Change: ${widget.crypto.changePercent >= 0 ? '+' : ''}${widget.crypto.changePercent.toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: widget.crypto.changePercent >= 0 ? Colors.greenAccent : Colors.redAccent,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Select Period (days):",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        const SizedBox(width: 14),
                        DropdownButton<int>(
                          value: selectedDays,
                          dropdownColor: const Color(0xFF1B232A),
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                          underline: Container(
                            height: 2,
                            color: Colors.greenAccent,
                          ),
                          onChanged: (int? newValue) {
                            if (newValue != null) {
                              setState(() {
                                selectedDays = newValue;
                              });
                              fetchAndCalculateIndicators();
                            }
                          },
                          items: const [
                            DropdownMenuItem(value: 7, child: Text("7")),
                            DropdownMenuItem(value: 14, child: Text("14")),
                            DropdownMenuItem(value: 30, child: Text("30")),
                            DropdownMenuItem(value: 90, child: Text("90")),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    if (priceHistory.isNotEmpty && !isLoading)
                      Container(
                        height: 150,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Sparkline(
                          data: priceHistory,
                          lineWidth: 2.0,
                          averageLine: true,
                          averageLabel: true,
                          gridLinelabelPrefix: '\$',
                          gridLineLabelPrecision: 3,
                          gridLinesEnable: true,
                          lineColor: Colors.greenAccent,
                          fillMode: FillMode.below,
                          fillGradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.greenAccent.withOpacity(0.2),
                              Colors.greenAccent.withOpacity(0.05),
                            ],
                          ),
                          pointsMode: PointsMode.all,
                          pointSize: 4.0,
                          pointColor: Colors.greenAccent,
                        ),
                      ),
                    if (priceHistory.isNotEmpty && !isLoading) const SizedBox(height: 20),
                    isLoading ? const CircularProgressIndicator(color: Colors.greenAccent) : _buildTradingSignals(),
                  ],
                ),
              ),
            ),
          ))
        ]));
  }

  Widget _buildTradingSignals() {
    IconData icon;
    Color color;

    switch (tradingSignal) {
      case "Bullish":
        icon = Icons.trending_up;
        color = Colors.greenAccent;
        break;
      case "Bearish":
        icon = Icons.trending_down;
        color = Colors.redAccent;
        break;
      default:
        icon = Icons.remove;
        color = Colors.yellowAccent;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0x4a54a3ed),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Technical Indicators",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "RSI: ${rsi != null ? rsi!.toStringAsFixed(2) : 'N/A'}",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            "MACD: ${macdLine != null && macdLine!.isNotEmpty ? macdLine!.last.toStringAsFixed(3) : 'N/A'}",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            "Signal Line: ${signalLine != null && signalLine!.isNotEmpty ? signalLine!.last.toStringAsFixed(3) : 'N/A'}",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: [
              Icon(icon, color: color, size: 28),
              Text(
                "Trading Signal: $tradingSignal",
                style: TextStyle(
                  fontSize: (tradingSignal == "Bullish" || tradingSignal == "Bearish") ? 20 : 15,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
