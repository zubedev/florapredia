// IMPORTS --- MD ZUBAIR IBNE BEG
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import '../models/cardModel.dart';

// CLASS: DbHelper
class DbHelper {
  static final _dbName = 'florapredia.db';
  static final _dbVersion = 1;

  // singleton class
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  // single connections only
  static Database _db;
  Future<Database> get db async {
    if(_db != null) return _db;
    _db = await _initDb();
    return _db;
  } // get db

  // initialize database
  Future<Database> _initDb() async { // database initialize
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    ); // return: openDatabase()
  } // _initDb()

  // onCreate method using SQL string
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE imgCards (
        _id TEXT PRIMARY KEY,
        label TEXT NOT NULL,
        accuracy REAL NOT NULL,
        description TEXT,
        path TEXT NOT NULL,
        url TEXT NOT NULL,
        user TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        created TEXT NOT NULL,
        updated TEXT NOT NULL
      )
    '''); // db.execute()
  } // _onCreate()

  Map<String, dynamic> _toMap(CardModel card) {
    return { // return a map from card
      '_id': card.imgId,
      'label': card.imgLabel,
      'accuracy': card.imgAcc,
      'description': card.imgDesc,
      'path': card.imgPath,
      'url': card.imgUrl,
      'user': card.imgUser,
      'address': card.locAddress,
      'latitude': card.locLat,
      'longitude': card.locLng,
      'created': card.timeCreated,
      'updated': card.timeUpdated,
    }; // return
  } // toMap()

  CardModel _toCard(Map<String, dynamic> map) {
    return CardModel(
        imgId: map['_id'],
        imgLabel: map['label'],
        imgAcc: map['accuracy'],
        imgDesc: map['description'],
        imgPath: map['path'],
        imgUrl: map['url'],
        imgUser: map['user'],
        locAddress: map['address'],
        locLat: map['latitude'],
        locLng: map['longitude'],
        timeCreated: map['created'],
        timeUpdated: map['updated'],
    ); // return: _toCard()
  } // _toCard()

  // database operations
  Future<int> insert(CardModel card) async {
    Map<String, dynamic> values = _toMap(card);
    Database database = await db;
    return await database.insert('imgCards', values);
  } // insert()

  Future<int> delete(String id) async {
    Database database = await db;
    return await database.delete(
        'imgCards',
        where: '_id = ?',
        whereArgs: [id],
    ); // return
  } // delete()

  Future<CardModel> getCard(String id) async {
    Database database = await db;
    final List<Map<String, dynamic>> listMap = await database.query('imgCards',
      columns: ['_id','label','accuracy','description','path','url','user','address','latitude','longitude','created','updated'],
      where: '_id = ?',
      whereArgs: [id],
    ); // listMap
    return listMap.length > 0 ?  _toCard(listMap.first) :  null;
  } // getCard()

  Future<List<Map<String, dynamic>>> getCards() async {
    Database database = await db;
    return await database.query('imgCards');
  } // getCards()

  Future<void> close() async => _db.close();
} // class: DbHelper()