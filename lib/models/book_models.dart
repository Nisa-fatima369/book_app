// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String? id;
  String? title;
  String? author;
  String? description;
  String? imageUrl;
  String? year;
  String? purpose;
  String? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? viewAt;
  String? userId;
  Book({
    this.id,
    this.title,
    this.author,
    this.description,
    this.imageUrl,
    this.year,
    this.purpose,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.viewAt,
    this.userId,
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
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? viewAt,
    String? userId,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewAt: viewAt ?? this.viewAt,
      userId: userId ?? this.userId,
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
      'createdAt': createdAt ,
      'updatedAt': updatedAt ,
      'viewAt': viewAt ,
      'userId': userId,
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
      createdAt: map['createdAt'] != null ? (map['createdAt'] as Timestamp ).toDate()   : null,
      updatedAt: map['updatedAt'] != null ?  (map['updatedAt']  as Timestamp).toDate() : null,
      viewAt: map['viewAt'] != null ? (map['viewAt']  as Timestamp ).toDate() : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, description: $description, imageUrl: $imageUrl, year: $year, purpose: $purpose, category: $category, createdAt: $createdAt, updatedAt: $updatedAt, viewAt: $viewAt, userId: $userId)';
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
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.viewAt == viewAt &&
      other.userId == userId;
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
      createdAt.hashCode ^
      updatedAt.hashCode ^
      viewAt.hashCode ^
      userId.hashCode;
  }
}
