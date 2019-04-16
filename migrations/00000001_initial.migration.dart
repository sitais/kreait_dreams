import 'dart:async';
import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   		database.createTable(SchemaTable("_Dream", [SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("title", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: true),SchemaColumn("author", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("year", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),SchemaColumn("rating", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false)]));
  }
  
  @override
  Future downgrade() async {}
  
  @override
  Future seed() async {
    final List<Map> dreams = [
      {
        "title": "The Alchemist",
        "author": "Paolo Coelho",
        "year": 1898,
        "rating": 4.8
      },
      {
        "title": "The Art of Dreaming",
        "author": "Jill Mellick",
        "year": 1999,
        "rating": 4.6
      },
      {
        "title": "The Lucid Dream Manifesto",
        "author": "Daniel Oldis",
        "year": 2009,
        "rating": 4.5
      },
      {
        "title": "Memories, Dreams, Reflections",
        "author": "Carl Jung",
        "year": 2019,
        "rating": 4.2
      },
      {
        "title": "In Dreams",
        "author": "Roy Orbison",
        "year": 1957,
        "rating": 4.9
      }
    ];

    for (final dream in dreams) {
      await database.store.execute('INSERT INTO _Dream (title, author, year, rating) VALUES (@title, @author, @year, @rating)',
      substitutionValues: {
        'title': dream['title'],
        'author': dream['author'],
        'year': dream['year'],
        'rating': dream['rating'],
      });
    }
  }
}
    