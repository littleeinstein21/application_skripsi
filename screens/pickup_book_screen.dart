import 'package:flutter/material.dart';

class PickupBookScreen extends StatelessWidget {
  const PickupBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list buku yang sudah dibooking user dan siap diambil
    final List<Map<String, String>> bookedBooks = [
      {
        'title': 'Buku 2',
        'pickupDate': '2025-09-14',
      },
      {
        'title': 'Buku 5',
        'pickupDate': '2025-09-15',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C54),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Pengambilan di Loker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: bookedBooks.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ada buku yang siap diambil.',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              )
            : ListView.builder(
                itemCount: bookedBooks.length,
                itemBuilder: (context, index) {
                  final book = bookedBooks[index];
                  return Card(
                    color: Colors.blueGrey[300],
                    child: ListTile(
                      leading: const Icon(Icons.library_books),
                      title: Text(
                        book['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Tanggal Ambil: ${book['pickupDate']}"),
                      trailing: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Buku "${book['title']}" telah diambil.'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.lock_open),
                        label: const Text("Ambil"),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
