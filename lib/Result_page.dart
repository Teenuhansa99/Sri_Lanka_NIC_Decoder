import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Map<String, String> decodedData;

  const ResultPage({required this.decodedData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: const Text('NIC Details'),
        backgroundColor: Color.fromARGB(255, 9, 60, 79),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Icon(Icons.assignment_ind, size: 60, color: Color.fromARGB(255, 9, 60, 79)),
                ),
                const SizedBox(height: 10),

                //displays the NIC Number
                Center(
                  child: Text(
                    'NIC:  ${decodedData['NIC Number'] ?? 'Not Available'}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(thickness: 1.5),

                // Displays the decoded NIC details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: decodedData.entries
                      .where((entry) => entry.key != 'NIC Number')
                      .map((entry) => InfoRow(label: entry.key, value: entry.value))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({required this.label, required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          const Text(
            " : ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

