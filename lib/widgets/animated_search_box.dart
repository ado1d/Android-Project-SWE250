import 'package:flutter/material.dart';

class AnimatedSearchBox extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const AnimatedSearchBox({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      autofocus: true,
      style: const TextStyle(color: Color(0xFF37FB83), fontFamily: 'Poppins'),
      decoration: InputDecoration(
        hintText: 'Search Crypto...',
        hintStyle: const TextStyle(color: Color(0xFF37FB83), fontFamily: 'Poppins', fontSize: 12),
        prefixIcon: const Icon(Icons.search, color: Color(0xFF37FB83), size: 15,),
        filled: true,
        fillColor: const Color(0xFF2E3A45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
