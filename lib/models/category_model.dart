class CategoryResponse {
  final ExploreCred exploreCred;
  final List<Section> sections;

  CategoryResponse({required this.exploreCred, required this.sections});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      exploreCred: ExploreCred.fromJson(json['explore_cred']['template_properties']),
      sections: (json['sections'] as List).map((section) => Section.fromJson(section['template_properties'])).toList(),
    );
  }
}

class ExploreCred {
  final String title;
  final String subtitle;

  ExploreCred({required this.title, required this.subtitle});

  factory ExploreCred.fromJson(Map<String, dynamic> json) {
    return ExploreCred(
      title: json['header']['title'],
      subtitle: json['header']['subtitle_title'],
    );
  }
}

class Section {
  final String title;
  final List<Item> items;

  Section({required this.title, required this.items});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['header']['title'],
      items: (json['items'] as List).map((item) => Item.fromJson(item)).toList(),
    );
  }
}

class Item {
  final String name;
  final String description;
  final String iconUrl;

  Item({required this.name, required this.description, required this.iconUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['display_data']['name'],
      description: json['display_data']['description'],
      iconUrl: json['display_data']['icon_url'],
    );
  }
}
