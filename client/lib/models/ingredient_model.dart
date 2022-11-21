
class ItemList {
  final String name;
  int? id;
  final List category;

  ItemList(
      {
      this.id,
      required this.name,
      required this.category});

static ItemList fromJson(Map<String, dynamic> json) => ItemList (
  name : json['name'],
  category : json['category'],
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;

    return data;
  }
}