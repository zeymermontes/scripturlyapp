import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

int? returnPosition(
  int? spaces,
  int? number,
) {
  // create a function that gives me the position of the column of a number in a grid from 1 to number with spaces items per row
  if (spaces == null || number == null || number <= 0 || spaces <= 0) {
    return null; // Return null for invalid inputs
  }

  int row = (number - 1) ~/ spaces; // Calculate the row index
  int column = (number - 1) % spaces; // Calculate the column index

  return column + 1; // Return the position (1-based index)
}

double normalicePositionCenter(
  int position,
  int total,
) {
  if (total <= 1) {
    return 0.0;
  }

  // Tamaño de cada segmento
  double segmentSize = 2.0 / total;

  // Posición del centro del segmento
  // -1 + (posición - 0.5) * tamañoSegmento
  return -1.0 + (position - 0.5) * segmentSize;
}

double normalicePositionSide(
  int position,
  int total,
) {
  if (total <= 1) {
    return 0.0; // Si solo hay un elemento o menos, retorna 0
  }

  // Mapear la posición de [1, total] a [-1, 1]
  return -1.0 + 2.0 * (position - 1) / (total - 1);
}

List<DataStruct>? returnBooksOfTestament(
  List<DataStruct>? books,
  bool? oldTestament,
) {
  if (books == null || books.isEmpty) return null;

  // Encontrar el índice de "Matthew" para dividir Old/New Testament
  int matthewIndex = books.indexWhere((book) => book.name == "Matthew");
  if (matthewIndex == -1) return null; // "Matthew" no encontrado

  // Encontrar el índice de "1 Esdras" para excluir del Old Testament
  int esdrasIndex = books.indexWhere((book) => book.name == "1 Esdras");

  if (oldTestament == true) {
    // Para Old Testament: elementos antes de "Matthew" pero excluyendo desde "1 Esdras" en adelante
    if (esdrasIndex != -1 && esdrasIndex < matthewIndex) {
      return books.sublist(0, esdrasIndex); // Excluye desde 1 Esdras
    } else {
      return books.sublist(
          0, matthewIndex); // Caso normal si 1 Esdras no existe
    }
  } else {
    // Para New Testament: elementos desde "Matthew" en adelante
    return books.sublist(matthewIndex);
  }
}

bool checkForIntro(String? code) {
  // return true if the code after de "." is equal to "intro"
  return code?.split('.')?.last == 'intro';
}

String? removeParragraphSymbol(String? text) {
  // return the original text only remove this chartacter  ¶
  return text?.replaceAll('¶', '');
}

String? translateBookName(
  String bookName,
  bool translateToSpanish,
) {
  if (!translateToSpanish) {
    return bookName;
  }
  print(translateToSpanish);
  print(bookName);

  const Map<String, String> bibleTranslations = {
    // Old Testament
    'Genesis': 'Génesis',
    'Exodus': 'Éxodo',
    'Leviticus': 'Levítico',
    'Numbers': 'Números',
    'Deuteronomy': 'Deuteronomio',
    'Joshua': 'Josué',
    'Judges': 'Jueces',
    'Ruth': 'Rut',
    '1 Samuel': '1 Samuel',
    '2 Samuel': '2 Samuel',
    '1 Kings': '1 Reyes',
    '2 Kings': '2 Reyes',
    '1 Chronicles': '1 Crónicas',
    '2 Chronicles': '2 Crónicas',
    'Ezra': 'Esdras',
    'Nehemiah': 'Nehemías',
    'Esther': 'Ester',
    'Job': 'Job',
    'Psalms': 'Salmos',
    'Proverbs': 'Proverbios',
    'Ecclesiastes': 'Eclesiastés',
    'Song of Solomon': 'Cantares',
    'Isaiah': 'Isaías',
    'Jeremiah': 'Jeremías',
    'Lamentations': 'Lamentaciones',
    'Ezekiel': 'Ezequiel',
    'Daniel': 'Daniel',
    'Hosea': 'Oseas',
    'Joel': 'Joel',
    'Amos': 'Amós',
    'Obadiah': 'Abdías',
    'Jonah': 'Jonás',
    'Micah': 'Miqueas',
    'Nahum': 'Nahúm',
    'Habakkuk': 'Habacuc',
    'Zephaniah': 'Sofonías',
    'Haggai': 'Hageo',
    'Zechariah': 'Zacarías',
    'Malachi': 'Malaquías',

    // New Testament
    'Matthew': 'Mateo',
    'Mark': 'Marcos',
    'Luke': 'Lucas',
    'John': 'Juan',
    'Acts': 'Hechos',
    'Romans': 'Romanos',
    '1 Corinthians': '1 Corintios',
    '2 Corinthians': '2 Corintios',
    'Galatians': 'Gálatas',
    'Ephesians': 'Efesios',
    'Philippians': 'Filipenses',
    'Colossians': 'Colosenses',
    '1 Thessalonians': '1 Tesalonicenses',
    '2 Thessalonians': '2 Tesalonicenses',
    '1 Timothy': '1 Timoteo',
    '2 Timothy': '2 Timoteo',
    'Titus': 'Tito',
    'Philemon': 'Filemón',
    'Hebrews': 'Hebreos',
    'James': 'Santiago',
    '1 Peter': '1 Pedro',
    '2 Peter': '2 Pedro',
    '1 John': '1 Juan',
    '2 John': '2 Juan',
    '3 John': '3 Juan',
    'Jude': 'Judas',
    'Revelation': 'Apocalipsis'
  };
  print('${bibleTranslations[bookName]}');

  return bibleTranslations[bookName] ?? bookName;
}

String? returnFirstLetters(String? name) {
  // return every first letter in the name
  if (name == null || name.isEmpty) {
    return null;
  }
  return name.split(' ').map((word) => word[0]).join('');
}

String? returnName(
  String? displayName,
  bool? name,
) {
  if (name == false) {
    return displayName?.split(' ').last;
  } else {
    final parts = displayName?.split(' ');
    if (parts != null && parts.length > 1) {
      // Return all parts except the last one, joined back with spaces
      return parts.sublist(0, parts.length - 1).join(' ');
    } else {
      // If there's only one word or null, return the original
      return displayName;
    }
  }
}
