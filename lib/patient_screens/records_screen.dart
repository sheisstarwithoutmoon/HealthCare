import 'package:flutter/material.dart';
// import 'package:health/widgets/custom_app_bar.dart';

class HealthRecordScreen extends StatefulWidget {
  const HealthRecordScreen({super.key});

  @override
  State<HealthRecordScreen> createState() => _HealthRecordScreenState();
}

class _HealthRecordScreenState extends State<HealthRecordScreen> {
  List<Map<String, String>> records = [
    {
      "title": "Blood Test Report",
      "date": "22-02-2025",
      "description": "Hemoglobin: 14.5, WBC: 6000, Platelets: 250,000"
    },
    {
      "title": "Doctor's Prescription",
      "date": "10-02-2025",
      "description": "Prescribed antibiotics for throat infection."
    },
  ];

  void _addRecord() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController titleController = TextEditingController();
        TextEditingController descriptionController = TextEditingController();
        
        return AlertDialog(
          title: const Text("Add Record"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                  setState(() {
                    records.add({
                      "title": titleController.text,
                      "date": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                      "description": descriptionController.text,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Past Records",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        centerTitle: true,
        elevation: 5,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Medical Records",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: records.isEmpty
                  ? const Center(
                      child: Text(
                        "No records found. Add one now!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final record = records[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: const Icon(Icons.description, color: Colors.blue),
                            title: Text(
                              record["title"]!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Date: ${record["date"]}\n${record["description"]}"),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _addRecord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 65, 97, 102),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text("Add New Record", 
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}