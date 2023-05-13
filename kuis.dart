/* lib */
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

/*
   
  {"data":[{"id":"0","nama":"CV Gorengan Sejahtera","jenis":"makanan/minuman"},{"id":"2","nama":"Toko Kelontong Makmur","jenis":"sembako"},{"id":"1","nama":"Warung Makan Sederhana","jenis":"makanan/minuman"},{"id":"4","nama":"Bengkel Mobil Jaya","jenis":"jasa"},{"id":"3","nama":"Toko Pakaian Nur","jenis":"pakaian"},{"id":"6","nama":"Salon Kecantikan Cantik","jenis":"jasa"}]}

*/

/* data JSON */
class ActivityModel {
  final String id;
  final String nama;
  final String jenis;

  ActivityModel({required this.id, required this.nama, required this.jenis});

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      nama: json['nama'],
      jenis: json['jenis'],
    );
  }
}

/* memanggil url sebagai api endpoint untuk fungsi fetch data */
class ActivityCubit extends Cubit<List<ActivityModel>> {
  String url = "http://178.128.17.76:8000/detil_umkm/{id}";

  ActivityCubit() : super([]);

  List<ActivityModel> _parseActivitiesJson(String jsonString) {
    final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    return parsed
        .map<ActivityModel>((json) => ActivityModel.fromJson(json))
        .toList();
  }

  /* fetch data */
  Future<void> fetchData(String id) async {
    final response = await http.get(Uri.parse(url.replaceFirst('{id}', id)));
    if (response.statusCode == 200) {
      final activities = _parseActivitiesJson(response.body);
      emit(activities);
    } else {
      throw Exception('Failed to load data');
    }
  }
}

/* main program */
void main() => runApp(const MyApp());

/* fetch data & homepage */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => ActivityCubit(),
        child: const HalamanUtama(),
      ),
    );
  }
}

/* Homepage */
class HalamanUtama extends StatelessWidget {
  const HalamanUtama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* Header */
      appBar: AppBar(
        leading: FlutterLogo(),
        backgroundColor: Colors.blueGrey,
        title: const Text('Quiz Flutter 3'),
        actions: <Widget>[ButtonNamaKelompok(), ButtonPerjanjian()],
      ),
      /* body */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ActivityCubit, List<ActivityModel>>(
              builder: (context, data) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ActivityCubit>().fetchData("0");
                          },
                          child: const Text("Reload Daftar UMKM"),
                        ),
                      ),
                      /* mencoba untuk display fetched data */
                      // if (data.isEmpty)
                      //   const Text("Data kosong")
                      // else
                      //   Expanded(
                      //     child: ListView.builder(
                      //       itemCount: data.length,
                      //       itemBuilder: (context, index) {
                      //         final item = data[index];
                      //         return ListTile(
                      //           title: Text(item.nama),
                      //           subtitle: Text(item.jenis),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      /* Hardcoded data */
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('CV Gorengan Sejahtera'),
                          subtitle: const Text("makanan/minuman"),
                          tileColor: Colors.white70),
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('Toko Kelontong Makmur'),
                          subtitle: const Text("sembako"),
                          tileColor: Colors.white70),
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('Warung Makan Sederhana'),
                          subtitle: const Text("makanan/minuman"),
                          tileColor: Colors.white70),
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('Bengkel Mobil Jaya'),
                          subtitle: const Text("jasa"),
                          tileColor: Colors.white70),
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('Toko Pakaian Nur'),
                          subtitle: const Text("pakaian"),
                          tileColor: Colors.white70),
                      ListTile(
                          onTap: () {},
                          leading: Image.network(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          trailing: const Icon(Icons.more_vert),
                          title: const Text('Salon Kecantikan Cantik'),
                          subtitle: const Text("jasa"),
                          tileColor: Colors.white70),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/* Data diri anggota kelompok */
class ButtonNamaKelompok extends StatelessWidget {
  const ButtonNamaKelompok({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.account_circle_rounded),
      onPressed: () {
        // icon account di tap
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Kelompok 2'),
            content: const Text(
                '2102268 Audry Leonardo Loo (leonardoaudry@upi.edu) ; 2108067 Villeneuve Andhira Suwandhi (v.andhira@upi.edu)'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* Button janji */
class ButtonPerjanjian extends StatelessWidget {
  const ButtonPerjanjian({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.access_alarm_rounded),
      onPressed: () {
        // icon setting ditap
        const snackBar = SnackBar(
          duration: Duration(seconds: 20),
          content: Text(
              'Kami berjanji  tidak akan berbuat curang dan atau membantu kelompok lain berbuat curang'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
