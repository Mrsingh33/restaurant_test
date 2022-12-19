// To open the database, add these imports to the existing file defining the
// database class. They are used to open the database.
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'myorderTable.dart';
part 'database_helper.g.dart';


@DriftDatabase(tables: [MyOrder],
  daos: [
    MyOrdersDao
  ]
)
class MyDatabase extends _$MyDatabase {
  static final sharedInstance = MyDatabase();
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
@DriftAccessor(tables: [MyOrder])
class MyOrdersDao extends DatabaseAccessor<MyDatabase>
    with _$MyOrdersDaoMixin {
  final MyDatabase db;

  MyOrdersDao(this.db) : super(db);

  addOrders(MyOrderData myOrder) =>
      into(db.myOrder).insert(myOrder, mode: InsertMode.replace);
  //
  Future<List<MyOrderData>> getOrders() =>
      (select(db.myOrder)
        ..orderBy(
          ([
            // Primary sorting by due date
                (t) =>
                OrderingTerm(expression: t.quantity, mode: OrderingMode.desc),

          ]),
        )
       )
          .get();

  Future<List<MyOrderData>> getOrderBYTitle(String title) =>
      (select(db.myOrder)
        ..where((order) => order.title.equals(title)))
          .get();


  updateOrder(String title,int value) =>
      (update(db.myOrder)..where((order) => order.title.equals(title)))
        ..write(MyOrderCompanion(quantity: Value(value)));
}




