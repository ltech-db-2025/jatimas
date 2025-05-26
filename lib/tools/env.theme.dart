part of 'env.dart';

const Color warnaMenu = Colors.white;
const Color warnaMenuLabel = Colors.black;
//dipakai
const Color mainColor = Color(0xFF00b3b0);
const Color mainColor1 = Color.fromARGB(255, 2, 177, 174);

const Color background = Colors.white;
const Color background1 = Color(0xFFB0BEC5);

const Color warnaTombol0 = mainColor;
const Color warnaTombol1 = Colors.green;
const Color warnaTombol2 = Colors.red;
const Color warnaTombol3 = Colors.white;
const TextStyle warnaTS1 = TextStyle(color: Colors.black);
const TextStyle warnaTS2 = TextStyle(color: Colors.grey);

const Color warnaTextPutih = Colors.white;
const Color warnaLabel = Colors.grey;

const double skala = 0.8;
const double skala_judul = 1.2;

const TextStyle defst = TextStyle();
ButtonStyle ebWhite = ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: mainColor, textStyle: const TextStyle(color: mainColor));
const Color maroon = Color.fromARGB(255, 186, 27, 27);
const TextStyle stwarning = TextStyle(color: Colors.red);
const TextStyle st12 = TextStyle(fontSize: 12);
const TextStyle st10 = TextStyle(fontSize: 10);
const TextStyle st8 = TextStyle(fontSize: 8);

const TextStyle style1 = TextStyle(color: Colors.white);
const TextStyle style2 = TextStyle(color: Colors.yellow);
const TextStyle textTitle = TextStyle(color: Colors.white);
const TextStyle totalStyle = TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
const TextStyle tssubtitle = TextStyle(color: Colors.black38);
const TextStyle tstebal = TextStyle(fontWeight: FontWeight.bold);
const TextStyle tstebalPutih = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
const TextStyle wrnText = TextStyle(fontSize: 12);
TextStyle tstebalbiru = TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold);
const TextStyle tstebalhijau = TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
const TextStyle tstebalmerah = TextStyle(color: maroon, fontWeight: FontWeight.bold);
TextStyle tstebalgrey = TextStyle(color: Colors.grey[400], fontWeight: FontWeight.bold);
const TextStyle tstebalhitam = TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

class Tema {
  Color utama = Color(0xFF00b3b0);
  Color background = Color(0xFF00b3b0);
  var bkgText = Colors.yellowAccent[100];
  var tombol = Colors.orangeAccent;
}

ThemeData customTema = ThemeData(
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.red, // Mengatur warna teks default untuk TextButton
    ),
  ),
  // Warna dasar aplikasi
  primaryColor: mainColor,
  scaffoldBackgroundColor: background,
  canvasColor: background, // Sama dengan scaffold background untuk konsistensi
  colorScheme: ColorScheme.light(
    primary: background, // Soft turquoise
    surface: background,
    onPrimary: background, // Teks di atas warna primer
  ),

  // AppBar theme
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: background),
    backgroundColor: mainColor,
    titleTextStyle: GoogleFonts.poppins(
      color: background,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),

    elevation: 0, // Menghilangkan shadow di bawah AppBar
  ),
  // wawrna cursor
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: const Color.fromARGB(255, 8, 223, 219),
    cursorColor: mainColor, // Customize the cursor color
  ),
  // ElevatedButton theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    ),
  ),

  // Text theme menggunakan Google Fonts Poppins
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    // Text Body
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.black54,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      color: Colors.black54,
    ),
    labelLarge: GoogleFonts.poppins(fontSize: 11, color: Colors.black54),
    labelMedium: GoogleFonts.poppins(fontSize: 10, color: Colors.black54),
    labelSmall: GoogleFonts.poppins(fontSize: 9, color: Colors.black54),
  ),

  // Input decoration theme for form fields
  inputDecorationTheme: InputDecorationTheme(
    // filled: true,
    // fillColor: Color(0xFFFFF9C4), // Light pastel yellow

    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: mainColor, // Warna border saat tidak focus
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: mainColor, // Warna border saat focus
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    hintStyle: GoogleFonts.poppins(
      color: Colors.black38, // Warna placeholder
    ),
  ),

  // Icon theme
  iconTheme: IconThemeData(
    color: Color(0xFFB2DFDB), // Ikon dengan warna soft turquoise
  ),

  // Divider theme
  dividerTheme: DividerThemeData(
    color: background1, // Warna divider abu-abu terang
    thickness: 1,
  ),

  // FloatingActionButton theme
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
    foregroundColor: background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  ),
  // BottomNavigationBar theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: background,
    selectedItemColor: mainColor,
    unselectedItemColor: background1,
    selectedLabelStyle: warnaTS1,
    unselectedLabelStyle: warnaTS2,
  ),
);
