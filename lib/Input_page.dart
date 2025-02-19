import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'decoder.dart';
import 'result_page.dart';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController nicController = TextEditingController();
  
  String? errorMessage;

  void validateAndDecode() {
    String nic = nicController.text.trim(); //get input

    //validate NIC format (9 digits + V or 12 digits)
    if (!RegExp(r'^[0-9]{9}[vV]?$|^[0-9]{12}$').hasMatch(nic)) {
      setState(() {
        errorMessage = 'Invalid NIC format! Use 9 digits + V or 12 digits.';
      });
      return;
    }

    //decode the NIC
    var decodedData = decodeNIC(nic);
    if (decodedData != null) {
      setState(() {
        errorMessage = null;
      });

      //add NIC number to the decoded data before passing it
      decodedData['NIC Number'] = nic;

      //navigate to the ResultPage and pass the decoded data using GetX navigation
      Get.to(() => ResultPage(decodedData: decodedData));
    } else {
      setState(() {
        errorMessage = 'Decoding failed! Please check the NIC.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: const Text('NIC Decoder'),
        backgroundColor: const Color.fromARGB(255, 9, 60, 79),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const Text(
              'Enter Your Sri Lankan NIC Number',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            //NIC Input
            TextField(
              controller: nicController, //assign to get user input
              decoration: InputDecoration(
                labelText: 'NIC Number',
                hintText: 'e.g. 853400937V or 200134025937',
                prefixIcon: const Icon(Icons.badge),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                errorText: errorMessage,
              ),
              keyboardType: TextInputType.text,
            ),

            const SizedBox(height: 20),

            //decode NIC Button
            ElevatedButton(
              onPressed: validateAndDecode,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 9, 60, 79),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Decode NIC', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
