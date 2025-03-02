import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/crypto.dart';
import '../widgets/crypto_list_item.dart';
import 'custom_icon_button.dart';
import 'menu_page.dart'; // Import your custom widget

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            "Top Picks",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEDF1E8),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
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

      //LOGO icon
      leading: CustomIconButton(
        onPressed: () {
          // Handle back action
        },
        assetPath: 'assets/logo.png',
        customColor: const Color(0xFF420128),
        size: 30,
        isSvgFile: false,
        offset: const Offset(15, 0),
      ),
      actions: [
        CustomIconButton(

          //Menu page
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

List<Crypto> cryptoList = [
  Crypto(
    name: "Bitcoin",
    symbol: "BTC",
    price: 87500.0,
    changePercent: -2.5,
    imageUrl: "https://cryptologos.cc/logos/bitcoin-btc-logo.png",
  ),
  Crypto(
    name: "Ethereum",
    symbol: "ETH",
    price: 2500.5,
    changePercent: -1.8,
    imageUrl: "https://cryptologos.cc/logos/ethereum-eth-logo.png",
  ),

  Crypto(
    name: "XRP",
    symbol: "XRP",
    price: 2.35,
    changePercent: 2.69,
    imageUrl: "https://cryptologos.cc/logos/xrp-xrp-logo.png",
  ),

  Crypto(
    name: "Binance Coin",
    symbol: "BNB",
    price: 610.0,
    changePercent: 3.2,
    imageUrl: "https://cryptologos.cc/logos/binance-coin-bnb-logo.png",
  ),
  Crypto(
    name: "Dogecoin",
    symbol: "DOGE",
    price: .20523,
    changePercent: 1.22,
    imageUrl: "https://cryptologos.cc/logos/dogecoin-doge-logo.png?v=040",
  ),
  Crypto(
    name: "Cardano",
    symbol: "ADA",
    price: 0.68,
    changePercent: -0.5,
    imageUrl: "https://cryptologos.cc/logos/cardano-ada-logo.png",
  ),
  Crypto(
    name: "Pepe",
    symbol: "PEPE",
    price: .00086331,
    changePercent: 12.4,
    imageUrl: "https://cryptologos.cc/logos/pepe-pepe-logo.png",
  ),

  Crypto(
    name: "OFFICIAL TRUMP",
    symbol: "TRUMP",
    price: 12.5,
    changePercent: -9.2,
    imageUrl: "https://img.etimg.com/thumb/msid-117357571,width-300,height-225,imgsize-54730,resizemode-75/trump-coin.jpg",
  ),
  Crypto(
    name: "Apple Inc.",
    symbol: "AAPL",
    price: 175.30,
    changePercent: 1.2,
    imageUrl: "https://logo.clearbit.com/apple.com",
  ),
  Crypto(
    name: "NVIDIA Corporation",
    symbol: "NVDA",
    price: 950.75,
    changePercent: -0.5,
    imageUrl: "https://logo.clearbit.com/nvidia.com",
  ),


  Crypto(
    name: "Gold",
    symbol: "XAU",
    price: 1850.0,
    changePercent: 0.5,
    imageUrl: "https://cdn-icons-png.flaticon.com/512/8107/8107835.png",
  ),
  Crypto(
    name: "Crude Oil",
    symbol: "WTI",
    price: 75.30,
    changePercent: -2.1,
    imageUrl: "https://www.vhv.rs/dpng/d/432-4322411_oil-clipart-crude-oil-oil-crude-oil-transparent.png",
  ),

];
