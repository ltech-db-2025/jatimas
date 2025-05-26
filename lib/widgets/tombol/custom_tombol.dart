import 'package:flutter/material.dart';
import 'package:ljm/tools/env.dart';

class TombolSimpan extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Teks untuk tombol
  final double borderRadius;

  const TombolSimpan({
    Key? key,
    required this.onPressed,
    this.text = 'Simpan',
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: warnaTextPutih,
        backgroundColor: warnaTombol0,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(text),
    );
  }
}

class TombolHapus extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Teks untuk tombol
  final double borderRadius;

  const TombolHapus({
    Key? key,
    required this.onPressed,
    this.text = 'Hapus',
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: warnaTextPutih,
        backgroundColor: warnaTombol2,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          // side: BorderSide(color: mainColor, width: 1),
        ),
      ),
      child: Text(text),
    );
  }
}

class TombolBatal extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Teks untuk tombol
  final double borderRadius;

  const TombolBatal({
    Key? key,
    required this.onPressed,
    this.text = 'Batal',
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: warnaTextPutih,
        backgroundColor: warnaTombol3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: mainColor, width: 1),
        ),
      ),
      child: Text(text),
    );
  }
}

class TombolBayar extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Teks untuk tombol
  final double borderRadius;

  const TombolBayar({
    Key? key,
    required this.onPressed,
    this.text = 'Bayar',
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: warnaTextPutih,
        backgroundColor: warnaTombol1,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: mainColor, width: 1),
        ),
      ),
      child: Text(text),
    );
  }
}

class TombolBelumBayar extends StatelessWidget {
  final VoidCallback onPressed;
  final String text; // Teks untuk tombol
  final double borderRadius;

  const TombolBelumBayar({
    Key? key,
    required this.onPressed,
    this.text = 'Belum Bayar',
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: warnaTextPutih,
        backgroundColor: warnaTombol3,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: mainColor, width: 1),
        ),
      ),
      child: Text(text),
    );
  }
}

// class TombolPrint extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String text; // Teks untuk tombol
//   final double borderRadius;

//   const TombolPrint({
//     Key? key,
//     required this.onPressed,
//     this.text = 'Print',
//     this.borderRadius = 8.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         foregroundColor: warnaTextPutih,
//         backgroundColor: warnaTombol3,
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           side: BorderSide(color: mainColor, width: 1),
//         ),
//       ),
//       child: Text(text),
//     );
//   }
// }

// class TombolPdf extends StatelessWidget {
//   final VoidCallback onPressed;
//   final String text; // Teks untuk tombol
//   final double borderRadius;

//   const TombolPdf({
//     Key? key,
//     required this.onPressed,
//     this.text = 'Pdf ',
//     this.borderRadius = 8.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         foregroundColor: warnaTextPutih,
//         backgroundColor: warnaTombol3,
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//           side: BorderSide(color: mainColor, width: 1),
//         ),
//       ),
//       child: Text(text),
//     );
//   }
// }
