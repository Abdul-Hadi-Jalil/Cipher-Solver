// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool select1 = false, select2 = false;
  bool is_pressed =
      false; // used when the user presses the start operation button.
  String? selectedCipher;
  final _ciphers = ["Caesar", "Atbash", "Modified Atbash"];

  String? _selectedOperation;
  final _operations = ["Encrypt", "Decrypt", "Find Key"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cipher Solver"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
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
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedCipher = val;
                        select1 = true;
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
                    value: _selectedOperation,
                    dropdownColor: const Color.fromARGB(255, 228, 255, 242),
                    underline: Container(),
                    items:
                        _operations.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() {
                        select2 = true;
                        _selectedOperation = val;
                      });
                    },
                  ),
                ),
              ),
              if (select1 && select2) ...[
                SizedBox(height: 40),
                Container(
                  width: 1000,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ), // Add border to create a box
                  ),
                  child: SingleChildScrollView(
                    child: TextField(
                      maxLines: null, // Allows multiple lines
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText:
                            _selectedOperation == 'Encrypt'
                                ? "Enter your plain text here which you want to encrypt"
                                : _selectedOperation == 'Decrypt'
                                ? "Enter your cipher here which you want to decrypt"
                                : _selectedOperation == 'Find Key'
                                ? "Enter your plain text here to find the key"
                                : "",
                        border:
                            InputBorder
                                .none, // Removes default border for custom styling
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // start: The space where user can write the key
                Container(
                  width: 1000,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: SingleChildScrollView(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            _selectedOperation == 'Encrypt'
                                ? "Enter your key"
                                : _selectedOperation == 'Decrypt'
                                ? "Enter your key"
                                : _selectedOperation == 'Find Key'
                                ? "Enter your cipher here to find the key"
                                : "",
                      ),
                    ),
                  ),
                ),
                // end: The space where user can write the key

                // adds a space between widgets
                SizedBox(height: 30),

                // Start: the button to start performing operation
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      is_pressed = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    foregroundColor: Colors.black,
                  ),
                  child: Text("Start Operation"),
                ),
                // End: the button to start performing operation

                // adds a space between widgets
                SizedBox(height: 30),

                // start: The result screen
                if (is_pressed) ...[
                  Align(alignment: Alignment.centerLeft, child: Text("Output")),
                  SizedBox(height: 3),
                  Container(
                    width: 1000,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: SingleChildScrollView(child: Text('')),
                  ),
                  // end: The result screen
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
