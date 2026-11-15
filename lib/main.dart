import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// WARNA APLIKASI
const Color kBackground = Color(0xFF101A14);
const Color kCard = Color(0xFF1C2B20);
const Color kGreen = Color(0xFF2E7D32);
const Color kOrange = Color(0xFFFFA726);
const Color kGrey = Color(0xFFB0B8B1);

// DATA KULINER
final List<Map<String, String>> foodData = [
  {
    'nama': 'Nasi Goreng',
    'asal': 'Jakarta',
    'rating': '4.9',
    'harga': 'Rp15.000',
    'image':
        'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800',
    'deskripsi':
        'Nasi goreng merupakan salah satu makanan khas Indonesia yang dibuat dari nasi putih yang digoreng bersama bumbu rempah, kecap manis, telur, dan berbagai pelengkap.',
  },
  {
    'nama': 'Rendang',
    'asal': 'Sumatera Barat',
    'rating': '4.9',
    'harga': 'Rp25.000',
    'image':
        'https://images.unsplash.com/photo-1545247181-516773cae754?w=800',
    'deskripsi':
        'Rendang adalah makanan khas Minangkabau yang menggunakan daging sapi dan dimasak dengan santan serta berbagai rempah hingga bumbunya meresap.',
  },
  {
    'nama': 'Sate Ayam',
    'asal': 'Madura',
    'rating': '4.8',
    'harga': 'Rp20.000',
    'image':
        'https://images.unsplash.com/photo-1529563021893-cc83c992d75f?w=800',
    'deskripsi':
        'Sate ayam dibuat dari potongan daging ayam yang ditusuk dan dibakar. Biasanya disajikan dengan saus kacang dan kecap manis.',
  },
  {
    'nama': 'Pempek',
    'asal': 'Palembang',
    'rating': '4.7',
    'harga': 'Rp18.000',
    'image':
        'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=800',
    'deskripsi':
        'Pempek merupakan makanan khas Palembang yang terbuat dari ikan dan tepung sagu. Hidangan ini disajikan dengan kuah cuko bercita rasa asam, manis, dan pedas.',
  },
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuliner Nusantara',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackground,
        colorScheme: const ColorScheme.dark(
          primary: kGreen,
          surface: kCard,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// HALAMAN UTAMA
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackground,
          centerTitle: true,
          title: const Text(
            'Kuliner Nusantara',
            style: TextStyle(
              color: kOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: kOrange,
            labelColor: kOrange,
            unselectedLabelColor: kGrey,
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: 'List View',
              ),
              Tab(
                icon: Icon(Icons.grid_view),
                text: 'Grid View',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildListView(context),
            buildGridView(context),
          ],
        ),
      ),
    );
  }
}

// WIDGET GAMBAR
Widget foodImage(
  String url, {
  double? width,
  double? height,
}) {
  return Image.network(
    url,
    width: width,
    height: height,
    fit: BoxFit.cover,
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;

      return Container(
        width: width,
        height: height,
        color: kCard,
        child: const Center(
          child: CircularProgressIndicator(
            color: kOrange,
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: width,
        height: height,
        color: kCard,
        child: const Icon(
          Icons.restaurant,
          color: kOrange,
          size: 45,
        ),
      );
    },
  );
}

// NAVIGASI KE HALAMAN DETAIL
void openDetail(
  BuildContext context,
  Map<String, String> item,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailPage(item: item),
    ),
  );
}

// LIST VIEW
Widget buildListView(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: foodData.length,
    itemBuilder: (context, index) {
      final item = foodData[index];

      return Card(
        color: kCard,
        margin: const EdgeInsets.only(bottom: 12),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(10),

          // GAMBAR MAKANAN
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: foodImage(
              item['image']!,
              width: 90,
              height: 75,
            ),
          ),

          // NAMA MAKANAN
          title: Text(
            item['nama']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          // ASAL DAN HARGA
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                item['asal']!,
                style: const TextStyle(color: kGrey),
              ),
              const SizedBox(height: 4),
              Text(
                item['harga']!,
                style: const TextStyle(
                  color: kOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: kOrange,
                size: 17,
              ),
              const SizedBox(width: 4),
              Text(
                item['rating']!,
                style: const TextStyle(
                  color: kOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // KLIK ITEM MENUJU DETAIL
          onTap: () {
            openDetail(context, item);
          },
        ),
      );
    },
  );
}

// GRID VIEW
Widget buildGridView(BuildContext context) {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: foodData.length,
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
    ),
    itemBuilder: (context, index) {
      final item = foodData[index];

      return Card(
        color: kCard,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        // KLIK ITEM GRID MENUJU DETAIL
        child: InkWell(
          onTap: () {
            openDetail(context, item);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: foodImage(item['image']!),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['nama']!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['asal']!,
                      style: const TextStyle(
                        color: kGrey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['harga']!,
                          style: const TextStyle(
                            color: kOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: kOrange,
                              size: 15,
                            ),
                            Text(
                              item['rating']!,
                              style: const TextStyle(
                                color: kOrange,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

// HALAMAN DETAIL
class DetailPage extends StatelessWidget {
  final Map<String, String> item;

  const DetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        title: Text(
          item['nama']!,
          style: const TextStyle(
            color: kOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO MAKANAN
            foodImage(
              item['image']!,
              width: double.infinity,
              height: 280,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NAMA MAKANAN
                  Text(
                    item['nama']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // LOKASI DAN RATING
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: kGrey,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          item['asal']!,
                          style: const TextStyle(
                            color: kGrey,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        color: kOrange,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item['rating']!,
                        style: const TextStyle(
                          color: kOrange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // HARGA
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: kCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Harga Makanan',
                          style: TextStyle(color: kGrey),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['harga']!,
                          style: const TextStyle(
                            color: kOrange,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    color: Colors.white24,
                    height: 35,
                  ),

                  // DESKRIPSI
                  const Text(
                    'Tentang Makanan',
                    style: TextStyle(
                      color: kOrange,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    item['deskripsi']!,
                    style: const TextStyle(
                      color: kGrey,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // TOMBOL KEMBALI
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text(
                        'Kembali ke Daftar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}