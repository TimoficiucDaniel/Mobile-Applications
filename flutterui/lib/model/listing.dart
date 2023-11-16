import 'dart:convert';

class Listing {
  int? id;
  String? title;
  int? cost;
  String? description;
  String? seller;

  Listing({
    this.id,
    this.title,
    this.cost,
    this.description,
    this.seller,
  });

  Listing copyWith({
    int? id,
    String? title,
    int? cost,
    String? description,
    String? seller,
  }) {
    return Listing(
      id: id ?? this.id,
      title: title ?? this.title,
      cost: cost ?? this.cost,
      description: description ?? this.description,
      seller: seller ?? this.seller,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    if (cost != null) {
      result.addAll({'cost': cost});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (seller != null) {
      result.addAll({'seller': seller});
    }

    return result;
  }

  factory Listing.fromMap(Map<String, dynamic> map) {
    return Listing(
      id: map['id']?.toInt(),
      title: map['title'],
      cost: map['cost'],
      description: map['description'],
      seller: map['seller'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Listing.fromJson(String source) => Listing.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Listing(id: $id, title: $title, cost: $cost, description: $description, seller:$seller)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Listing && other.id == id && other.title == title && other.cost == cost && other.description == description && other.seller == seller;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ cost.hashCode ^ description.hashCode ^ seller.hashCode;
  }
}
