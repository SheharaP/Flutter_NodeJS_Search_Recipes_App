
class Item {
  final String name;
  int? id;
  final List<String> categories;

  Item(
      {
      this.id,
      required this.name,
      required this.categories});

static Item fromJson(Map<String, dynamic> json) => Item (
  name : json['name'],
  categories : json['category'],
);

static String formatCase(String text) {
    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }


  // Userlist.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  // }

  Map<String, dynamic> toJson(e) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = categories;

    return data;
  }
}