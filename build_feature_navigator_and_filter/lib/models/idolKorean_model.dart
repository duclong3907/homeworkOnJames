class Idolkorean{
  final String name;
  final String image;
  final String group;
  final String link;
  final String description;

  Idolkorean({required this.name, required this.image, required this.group, required this.link, required this.description});

  factory Idolkorean.fromMap(Map<String, String> map) {// factory constructor dung de tao ra doi tuong ma khong can phai khoi tao doi tuong moi
    return Idolkorean(
      name: map['name']?? 'No title',
      image: map['image']?? 'No image',
      group: map['group']?? 'No group',
      link: map['link']?? 'No link',
      description: map['description'] ?? 'No description available',
    );
  }
}