import 'package:kreait_dreams/kreait_dreams.dart';

class Dream extends ManagedObject<_Dream> implements _Dream {
  // @Serialize()
  String get detail => '$title by $author';
}

class _Dream  {
  @primaryKey
  int id;

  @Column(unique: true)
  String title;

  @Column()
  String author;

  @Column()
  int year;

  @Column()
  double rating;
}