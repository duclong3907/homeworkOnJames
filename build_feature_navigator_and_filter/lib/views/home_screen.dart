import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/idolKorean_model.dart';
import '../repositories/idolKorean_repository.dart';
import 'details_screen.dart';
import 'filter_screen.dart';
import '../widgets/custom_image_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IdolkoreanRepository _itemRepository = IdolkoreanRepository(); // tạo một đối tượng của IdolkoreanRepository
  List<Idolkorean> idolKoreans = []; // tạo một danh sách idolKoreans
  String _groupFilter = 'All'; // dung de luu tru gia tri cua groupFilter
  String _searchQuery = ''; // dung de luu tru gia tri cua search bar
  bool _isSearchVisible = false; // dung de kiem tra xem co dang hien thi search bar hay khong
  @override
  void initState() {
    super.initState();
    idolKoreans = _itemRepository.getItems(); // lay danh sach idolKoreans tu IdolkoreanRepository
    _loadFilters(); // load gia tri cua groupFilter
  }

  _loadFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // lay gia tri cua groupFilter tu SharedPreferences
    setState(() {
      _groupFilter = prefs.getString('groupFilter') ?? 'All'; // neu groupFilter khong co gia tri thi lay gia tri mac dinh la All
    });
  }

  void _showFilterScreen() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FilterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // vi tri bat dau cua FilterScreen
        const end = Offset.zero; // vi tri cuoi cua FilterScreen
        // const end = Offset(0.2, 0.0); //cach le 20%
        const curve = Curves.easeInOut; // duong cong chuyen dong cua animation khi chuyen trang FilterScreen

        //hieu ung truot khi chuyen trang
        // Tween(begin: begin, end: end): Tween (interpolation) được sử dụng để chuyển đổi từ giá trị bắt đầu Offset(1.0, 0.0) sang giá trị kết thúc Offset.zero.
        //.chain(CurveTween(curve: curve)): Áp dụng đường cong Curves.easeInOut cho quá trình tween để chuyển động mượt hơn.
        // animation.drive(tween): Sử dụng animation để điều khiển tween, tức là thực hiện quá trình chuyển đổi theo thời gian mà animation cung cấp.
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    )).then((_) => _loadFilters());
  }

  @override
  Widget build(BuildContext context) {
    List<Idolkorean> filteredItems = idolKoreans
        .where((item) => (_groupFilter == 'All' || item.group == _groupFilter) &&
        item.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Idol Korean', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterScreen,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearchVisible)
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder( // dung de tao border cho search bar
                    borderSide: BorderSide(
                      color: Colors.blueGrey, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  suffixIcon: IconButton( // dung de hien thi icon search
                    icon: Icon(Icons.search),
                    onPressed: null
                  ),
                ),

                style: TextStyle(color: Colors.grey, fontSize: 18.0),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(singer: filteredItems[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Hero(
                            tag: 'imageHero${filteredItems[index].name}',
                            child: Container(
                              width: 100, // Fixed width
                              height: 100, // Fixed height
                              color: Colors.grey, // Background color
                              child: CustomImageWidget(imagePath: filteredItems[index].image),
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(filteredItems[index].name,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height:8),
                              Text(filteredItems[index].group,
                                  style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>  setState(() {
          _isSearchVisible = !_isSearchVisible;
        }),
        child: Icon(Icons.search),
      ),
    );
  }
}