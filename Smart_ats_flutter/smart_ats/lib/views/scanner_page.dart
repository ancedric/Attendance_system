import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../storage/local_storage.dart';
import 'session_details_page.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart'; // Import the library

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? _scannedData; // Store the scanned data
  bool _isScanning = false; // Track scanning state

  Future<void> _startScan() async {
    setState(() {
      _isScanning = true;
      _scannedData = null; // Clear previous scan
    });
    try {
      final result = await SimpleBarcodeScanner.scanBarcode( // Use scanBarcode
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle:'Scanner le QR Code',
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 2000,
        cameraFace: CameraFace.front,
      );

      if (result == null || result == '-1' || result.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Scan annulé ou code non détecté.")),
          );
        }
        setState(() {
          _isScanning = false;
        });
        return;
      }

      setState(() {
        _scannedData = result;
        _isScanning = false;
      });
      _processScannedData(result);
    } catch (e) {
       if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors du scan: ${e.toString()}")),
        );
      }
      setState(() {
        _isScanning = false;
      });
    }
  }

  Future<void> _processScannedData(String rawData) async {
  if (_scannedData == null) return;

  print('Scanned Data: $rawData'); // Affiche TOUTES les données scannées

  try {
    final parts = rawData.split('|');
    if (parts.length != 3) {  // Vérifie le nombre de parties
      throw Exception("Invalid QR Code format: Expected 3 parts.");
    }
    final pcIpAddress = parts[0];
    // *** Décode les données de l'URL ***
    final sessionRef = Uri.decodeFull(parts[1]);
    final sessionName = Uri.decodeFull(parts[2]);

    // Set the PC IP Address for API calls
    ApiService.setPcIpAddress(pcIpAddress);

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final formattedTime = DateFormat('HH:mm:ss').format(now);

    final user = await LocalStorage.getUser();
    final userRef = user["userRef"] ?? "unknown";

    try {
      await ApiService.addParticipant(
        userRef: userRef,
        sessionRef: sessionRef,
        date: formattedDate,
        arrivalTime: formattedTime,
      );
    } catch (apiError) { // Catch the error from ApiService
       if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Erreur de l'API : ${apiError.toString()}")),
          );
        }
        setState(() {
          _scannedData = null;
        });
        return; // Important:  Exit the function after showing the error
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SessionDetailsPage(
            sessionName: sessionName,
            sessionRef: sessionRef,
            arrivalTime: formattedTime,
          ),
        ),
      );
    }
  } catch (e) {
    if (mounted) {
      String errorMessage = "QR code non valide: ${e.toString()}";
      if (e is FormatException) {
        errorMessage = "QR code non valide: ${e.message}";
      } 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
    setState(() {
      _scannedData = null;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner une session")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _isScanning ? null : _startScan,
              child: Text(_isScanning ? "Scanning..." : "Scanner QR Code"),
            ),
            if (_scannedData != null) ...[
              const SizedBox(height: 20),
              Text(
                "Scanned Data: $_scannedData",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}








/*import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import '../storage/local_storage.dart';
import 'session_details_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool _scanned = false;

  void _onDetect(BarcodeCapture capture) async {
    if (_scanned || capture.barcodes.isEmpty) return;

    final barcode = capture.barcodes.first;
    final rawData = barcode.rawValue;
    if (rawData == null) return;

    setState(() => _scanned = true);

    try {
      final parts = rawData.split('|');
      final sessionRef = parts[0];
      final sessionName = parts[1];

      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      final formattedTime = DateFormat('HH:mm:ss').format(now);

      final user = await LocalStorage.getUser();
      final userRef = user["userRef"] ?? "unknown";

      await ApiService.addParticipant(
        userRef: userRef,
        sessionRef: sessionRef,
        date: formattedDate,
        arrivalTime: formattedTime,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SessionDetailsPage(
            sessionName: sessionName,
            sessionRef: sessionRef,
            arrivalTime: formattedTime,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("QR code non valide.")),
      );
      setState(() => _scanned = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner une session")),
      body: MobileScanner(
        controller: MobileScannerController(),
        onDetect: _onDetect,
      ),
    );
  }
}*/
