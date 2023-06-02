import 'package:flutter/material.dart';

class MySearch extends StatefulWidget {
  const MySearch({super.key});

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        backgroundColor: Colors.black54,
        title: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white70, width: 2.0),
                borderRadius: BorderRadius.circular(6.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white70, width: 2.0),
                borderRadius: BorderRadius.circular(6.0)),
            hintText: "Search",
            hintStyle: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          "search video",
          style: TextStyle(fontSize: 30, color: Colors.white12),
        ),
      ),
    );
  }
}
