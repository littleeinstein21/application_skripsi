import 'package:flutter/material.dart';

class BorrowBookScreen extends StatefulWidget {
  const BorrowBookScreen({super.key});

  @override
  State<BorrowBookScreen> createState() => _BorrowBookScreenState();
}

class _BorrowBookScreenState extends State<BorrowBookScreen> {
  final TextEditingController searchController = TextEditingController();
  DateTime? selectedDate;

  final List<Map<String, dynamic>> books = List.generate(20, (index) {
    return {
      "title": "Buku ${index + 1}",
      "status": index % 3 == 0 ? "Not Available" : "Available"
    };
  });

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBooks = books
        .where((book) =>
            book["title"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C54),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Peminjaman Baru'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  return Card(
                    color: book['status'] == 'Available'
                        ? Colors.green[300]
                        : Colors.red[300],
                    child: ListTile(
                      title: Text(
                        book['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(book['status']),
                      trailing: book['status'] == 'Available'
                          ? ElevatedButton(
                              onPressed: () => _selectDateAndConfirm(book),
                              child: const Text('Booking'),
                            )
                          : null,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDateAndConfirm(Map<String, dynamic> book) async {
    DateTime now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
      helpText: "Pilih Tanggal Pengambilan",
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Konfirmasi Peminjaman"),
          content: Text(
              "Anda akan meminjam \"${book['title']}\" pada ${picked.day}/${picked.month}/${picked.year}."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Peminjaman berhasil!")),
                );
              },
              child: const Text("Konfirmasi"),
            )
          ],
        ),
      );
    }
  }
}
