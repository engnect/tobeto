import 'package:flutter/material.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClubsPageState createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  final TextEditingController _clubNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  @override
  void dispose() {
    _clubNameController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Text('Kulüp veya Topluluk Adı', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Örn.Kızılay',
                    contentPadding:
                        EdgeInsets.all(8), 
                    border: InputBorder.none, 
                  ),
                ),
              ),
              const SizedBox(height: 16),
            Text('Ünvan veya Görev', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Örn.Proje Yöneticisi',
                    contentPadding:
                        EdgeInsets.all(8), 
                    border: InputBorder.none, 
                  ),
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                
              },
               style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(153, 51, 255, 1),
                ),
                child: const Text("Kaydet",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
