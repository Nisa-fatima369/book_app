// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Book {
  String? title;
  String? author;
  String? description;
  String? imageUrl;
  String? year;
  String? purpose;
  String? category;
 
  Book({
    this.title,
    this.author,
    this.description,
    this.imageUrl,
    this.year,
    this.purpose,
    this.category,
  });
 
  Book copyWith({
    String? title,
    String? author,
    String? description,
    String? imageUrl,
    String? year,
    String? purpose,
    String? category,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      year: year ?? this.year,
      purpose: purpose ?? this.purpose,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'author': author,
      'description': description,
      'imageUrl': imageUrl,
      'year': year,
      'purpose': purpose,
      'category': category,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] != null ? map['title'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(title: $title, author: $author, description: $description, imageUrl: $imageUrl, year: $year, purpose: $purpose, category: $category)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.author == author &&
      other.description == description &&
      other.imageUrl == imageUrl &&
      other.year == year &&
      other.purpose == purpose &&
      other.category == category;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      author.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      year.hashCode ^
      purpose.hashCode ^
      category.hashCode;
  }
}
