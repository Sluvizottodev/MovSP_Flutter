import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movspflutter/componentes/CustomAppBar.dart';
import '../componentes/BottomAppBar.dart';
import '../utils/OlhoVivoServ.dart';

class OlhoVivoScreen extends StatefulWidget {
  @override
  _OlhoVivoScreenState createState() => _OlhoVivoScreenState();
}

class _OlhoVivoScreenState extends State<OlhoVivoScreen> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchBusLocations();
  }

  Future<void> _fetchBusLocations() async {
    try {
      List<dynamic> busLines = await OlhoVivoService.fetchBusLines();
      setState(() {
        _markers = busLines.map((bus) {
          return Marker(
            markerId: MarkerId(bus['CodigoLinha'].toString()),
            position: LatLng(bus['Latitude'], bus['Longitude']),
            infoWindow: InfoWindow(
              title: 'Linha: ${bus['Letreiro']}',
              snippet: 'Sentido: ${bus['Sentido'] == 1 ? 'Ida' : 'Volta'}',
            ),
          );
        }).toSet();
      });
    } catch (e) {
      // Handle the error appropriately
      print('Erro ao buscar localizações de ônibus: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(-23.5505, -46.6333),
                // Central point of São Paulo
                zoom: 12,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),

          ],
        ),
        appBar: CustomAppBar(),
        bottomNavigationBar: BottomAppBarComponent()
    );
  }
}
