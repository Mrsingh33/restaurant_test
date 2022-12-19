// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_helper.dart';

// ignore_for_file: type=lint
class MyOrderData extends DataClass implements Insertable<MyOrderData> {
  final String title;
  final int quantity;
  final String content;
  final String category;
  const MyOrderData(
      {required this.title,
      required this.quantity,
      required this.content,
      required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['title'] = Variable<String>(title);
    map['quantity'] = Variable<int>(quantity);
    map['content'] = Variable<String>(content);
    map['category'] = Variable<String>(category);
    return map;
  }

  MyOrderCompanion toCompanion(bool nullToAbsent) {
    return MyOrderCompanion(
      title: Value(title),
      quantity: Value(quantity),
      content: Value(content),
      category: Value(category),
    );
  }

  factory MyOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyOrderData(
      title: serializer.fromJson<String>(json['title']),
      quantity: serializer.fromJson<int>(json['quantity']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'title': serializer.toJson<String>(title),
      'quantity': serializer.toJson<int>(quantity),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<String>(category),
    };
  }

  MyOrderData copyWith(
          {String? title, int? quantity, String? content, String? category}) =>
      MyOrderData(
        title: title ?? this.title,
        quantity: quantity ?? this.quantity,
        content: content ?? this.content,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('MyOrderData(')
          ..write('title: $title, ')
          ..write('quantity: $quantity, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(title, quantity, content, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyOrderData &&
          other.title == this.title &&
          other.quantity == this.quantity &&
          other.content == this.content &&
          other.category == this.category);
}

class MyOrderCompanion extends UpdateCompanion<MyOrderData> {
  final Value<String> title;
  final Value<int> quantity;
  final Value<String> content;
  final Value<String> category;
  const MyOrderCompanion({
    this.title = const Value.absent(),
    this.quantity = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
  });
  MyOrderCompanion.insert({
    required String title,
    required int quantity,
    required String content,
    required String category,
  })  : title = Value(title),
        quantity = Value(quantity),
        content = Value(content),
        category = Value(category);
  static Insertable<MyOrderData> custom({
    Expression<String>? title,
    Expression<int>? quantity,
    Expression<String>? content,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (title != null) 'title': title,
      if (quantity != null) 'quantity': quantity,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
    });
  }

  MyOrderCompanion copyWith(
      {Value<String>? title,
      Value<int>? quantity,
      Value<String>? content,
      Value<String>? category}) {
    return MyOrderCompanion(
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      content: content ?? this.content,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyOrderCompanion(')
          ..write('title: $title, ')
          ..write('quantity: $quantity, ')
          ..write('content: $content, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $MyOrderTable extends MyOrder with TableInfo<$MyOrderTable, MyOrderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyOrderTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [title, quantity, content, category];
  @override
  String get aliasedName => _alias ?? 'my_order';
  @override
  String get actualTableName => 'my_order';
  @override
  VerificationContext validateIntegrity(Insertable<MyOrderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {title};
  @override
  MyOrderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyOrderData(
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
    );
  }

  @override
  $MyOrderTable createAlias(String alias) {
    return $MyOrderTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $MyOrderTable myOrder = $MyOrderTable(this);
  late final MyOrdersDao myOrdersDao = MyOrdersDao(this as MyDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [myOrder];
}

mixin _$MyOrdersDaoMixin on DatabaseAccessor<MyDatabase> {
  $MyOrderTable get myOrder => attachedDatabase.myOrder;
}
