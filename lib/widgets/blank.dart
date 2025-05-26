import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final String keterangan;
  const BlankPage([this.keterangan = 'Dalam Pengembangan', Key? key]) : super(key: key);

  get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(centerTitle: true, title: const Text("Lucky Jaya Motorindo"), elevation: 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(keterangan),
            ElevatedButton(child: const Text('Kembali'), onPressed: () => Navigator.of(context).pop()),
            ElevatedButton(
                child: const Text('Material Banner'),
                onPressed: () => {
                      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                        padding: const EdgeInsets.all(20),
                        content: const Text('MaterialBanner'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                            child: const Text('Dismiss'),
                          )
                        ],
                      )),
                    }),
          ],
        ),
      ),
    );
  }
}
