// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cipher_solver/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool select1 = false, select2 = false;
  bool isLoading = false;
  String? selectedCipher;
  final ciphers = [
    "Caesar",
    "Atbash",
    "Modified Atbash",
    "Beaufort",
    "Vigenere",
  ];

  String? selectedOperation;
  final operations = ["Encrypt", "Decrypt", "Find Key"];

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  Future<void> _performCipherOperation() async {
    if (selectedCipher == null ||
        selectedOperation == null ||
        _textController.text.isEmpty) {
      setState(() => _resultController.text = "Please fill all fields!");
      return;
    }

    setState(() {
      isLoading = true;
      _resultController.text = "Processing...";
    });

    try {
      final result = await ApiService.performCipher(
        cipher: selectedCipher!,
        operation: selectedOperation!,
        text: _textController.text,
        key: _keyController.text.isEmpty ? null : _keyController.text,
      );

      setState(() => _resultController.text = result);
    } catch (e) {
      setState(() => _resultController.text = "Error: ${e.toString()}");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _keyController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cipher Solver"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 250, vertical: 50),
          child: Column(
            children: [
              // Cipher Dropdown
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
                    hint: const Text("Select cipher"),
                    isExpanded: true,
                    value: selectedCipher,
                    dropdownColor: const Color.fromARGB(255, 228, 255, 242),
                    underline: Container(),
                    items:
                        ciphers.map((value) {
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

              const SizedBox(height: 20),

              // Operation Dropdown
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
                    hint: const Text("Select operation"),
                    isExpanded: true,
                    value: selectedOperation,
                    dropdownColor: const Color.fromARGB(255, 228, 255, 242),
                    underline: Container(),
                    items:
                        operations.map((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedOperation = val;
                        select2 = true;
                      });
                    },
                  ),
                ),
              ),

              if (select1 && select2) ...[
                const SizedBox(height: 40),

                // Text Input
                Container(
                  width: 1000,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText:
                            selectedOperation == 'Encrypt'
                                ? "Enter your plain text here which you want to encrypt"
                                : selectedOperation == 'Decrypt'
                                ? "Enter your cipher here which you want to decrypt"
                                : selectedOperation == 'Find Key'
                                ? "Enter your plain text here to find the key"
                                : "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Key Input
                Container(
                  width: 1000,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _keyController,
                      decoration: InputDecoration(
                        hintText:
                            selectedOperation == 'Encrypt'
                                ? "Enter your key"
                                : selectedOperation == 'Decrypt'
                                ? "Enter your key"
                                : selectedOperation == 'Find Key'
                                ? "Enter your cipher here to find the key"
                                : "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Operation Button
                ElevatedButton(
                  onPressed: isLoading ? null : _performCipherOperation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[300],
                    foregroundColor: Colors.black,
                  ),
                  child:
                      isLoading
                          ? const CircularProgressIndicator()
                          : const Text("Start Operation"),
                ),

                const SizedBox(height: 30),

                // Result Box
                if (_resultController.text.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Output"),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 1000,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: SingleChildScrollView(
                      child: TextField(
                        controller: _resultController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
