import 'package:drift/drift.dart';


class MyOrder extends Table {
  TextColumn get title => text()();
  IntColumn get quantity  => integer()();
  TextColumn get content => text()();
  TextColumn get category =>  text()();


  @override
  Set<Column> get primaryKey => {title};
}