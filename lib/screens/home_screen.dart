import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCipher;
  final _ciphers = ["Caesar", "Atbash", "Modified Atbash"];

  String? _selectedOperation;
  final _operations = ["Encrypt", "Decrypt", "Find Key"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cipher Solver"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
        child: Column(
          children: [
            // First Dropdown with styling
            Theme(
              data: Theme.of(context).copyWith(
                hoverColor: const Color.fromARGB(255, 206, 250, 229),
                highlightColor: const Color.fromARGB(255, 206, 250, 229),
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 255, 242),
                ),
                child: DropdownButton<String>(
                  hint: Text("Select cipher"),
                  isExpanded: true,
                  value: selectedCipher,
                  dropdownColor: const Color.fromARGB(255, 228, 255, 242),
                  underline: Container(),
                  items:
                      _ciphers.map((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCipher = val;
                    });
                  },
                ),
              ),
            ),

            // Spacer that won't inherit styling
            const SizedBox(height: 20),

            // Second Dropdown with styling
            Theme(
              data: Theme.of(context).copyWith(
                hoverColor: const Color.fromARGB(255, 206, 250, 229),
                highlightColor: const Color.fromARGB(255, 206, 250, 229),
              ),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 255, 242),
                ),
                child: DropdownButton<String>(
                  hint: Text("Select operation"),
                  isExpanded: true,
                  value: selectedCipher,
                  dropdownColor: const Color.fromARGB(255, 228, 255, 242),
                  underline: Container(),
                  items:
                      _ciphers.map((value) {
                        return DropdownMenuItem<String>(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                  onChanged: (val) {
                    setState(() {
                      selectedCipher = val;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
