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
  final IdolkoreanRepository _itemRepository = IdolkoreanRepository();
  List<Idolkorean> idolKoreans = [];
  String _groupFilter = 'All';
  String _searchQuery = '';
  bool _isSearchVisible = false;
  @override
  void initState() {
    super.initState();
    idolKoreans = _itemRepository.getItems();
    _loadFilters();
  }

  _loadFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _groupFilter = prefs.getString('groupFilter') ?? 'All';
    });
  }

  void _showFilterScreen() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FilterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

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
        title: Text('Idol Korean'),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  suffixIcon: IconButton(
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
          SizedBox(height: 16),
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