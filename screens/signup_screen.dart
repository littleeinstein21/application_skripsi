import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController namaLengkapController = TextEditingController();
  final TextEditingController noKtpController = TextEditingController();

  String? selectedFileName;

  Future<void> selectKtpFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2C54),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // ignore: prefer_const_constructors
        leading: BackButton(color: Colors.white),
        title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildInputField("Username", usernameController),
              const SizedBox(height: 16),
              _buildInputField("Password", passwordController, obscureText: true),
              const SizedBox(height: 16),
              _buildInputField("Nama Lengkap", namaLengkapController),
              const SizedBox(height: 16),
              _buildInputField("No. KTP", noKtpController, keyboardType: TextInputType.number),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: selectKtpFile,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Foto KTP'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  backgroundColor: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(height: 8),
              if (selectedFileName != null)
                Text(
                  'File: $selectedFileName',
                  style: const TextStyle(color: Colors.white70),
                ),
              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Registration logic
                    // ignore: avoid_print
                    print("Username: ${usernameController.text}");
                    // ignore: avoid_print
                    print("Password: ${passwordController.text}");
                    // ignore: avoid_print
                    print("Nama Lengkap: ${namaLengkapController.text}");
                    // ignore: avoid_print
                    print("No. KTP: ${noKtpController.text}");
                    // ignore: avoid_print
                    print("File KTP: $selectedFileName");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('DAFTAR'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool obscureText = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: const OutlineInputBorder(),
      ),  
    );
  }
}
