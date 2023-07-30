// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Book {
  String? id;
  String? title;
  String? author;
  String? description;
  String? imageUrl;
  String? year;
  String? purpose;
  String? category;
  String? condition;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? viewAt;
  String? userId;
  List<String>? bookMarkedUsers; 

  Book({
    this.id,
    this.title,
    this.author,
    this.description,
    this.imageUrl,
    this.year,
    this.purpose,
    this.category,
    this.condition,
    this.createdAt,
    this.updatedAt,
    this.viewAt,
    this.userId,
    this.bookMarkedUsers,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? imageUrl,
    String? year,
    String? purpose,
    String? category,
    String? condition,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? viewAt,
    String? userId,
    List<String>? bookMarkedUsers,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      year: year ?? this.year,
      purpose: purpose ?? this.purpose,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewAt: viewAt ?? this.viewAt,
      userId: userId ?? this.userId,
      bookMarkedUsers: bookMarkedUsers ?? this.bookMarkedUsers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'imageUrl': imageUrl,
      'year': year,
      'purpose': purpose,
      'category': category,
      'condition': condition,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'viewAt': viewAt?.millisecondsSinceEpoch,
      'userId': userId,
      'bookMarkedUsers': bookMarkedUsers,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
      purpose: map['purpose'] != null ? map['purpose'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      condition: map['condition'] != null ? map['condition'] as String : null,
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int) : null,
      viewAt: map['viewAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['viewAt'] as int) : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      bookMarkedUsers: map['bookMarkedUsers'] != null ? List<String>.from(map['bookMarkedUsers'] as List) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, description: $description, imageUrl: $imageUrl, year: $year, purpose: $purpose, category: $category, condition: $condition, createdAt: $createdAt, updatedAt: $updatedAt, viewAt: $viewAt, userId: $userId, bookMarkedUsers: $bookMarkedUsers)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.author == author &&
      other.description == description &&
      other.imageUrl == imageUrl &&
      other.year == year &&
      other.purpose == purpose &&
      other.category == category &&
      other.condition == condition &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.viewAt == viewAt &&
      other.userId == userId &&
      listEquals(other.bookMarkedUsers, bookMarkedUsers);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      author.hashCode ^
      description.hashCode ^
      imageUrl.hashCode ^
      year.hashCode ^
      purpose.hashCode ^
      category.hashCode ^
      condition.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      viewAt.hashCode ^
      userId.hashCode ^
      bookMarkedUsers.hashCode;
  }
}
