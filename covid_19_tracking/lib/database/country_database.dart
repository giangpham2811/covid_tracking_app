import 'package:covid_19_tracking/model/country/country.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CountryDatabase {
  CountryDatabase._init();

  static final CountryDatabase instance = CountryDatabase._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('country.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);
    return openDatabase(
      path,
      version: 5,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    // const countryIdType = 'TEXT NOT NULL UNIQUE';
    const textType = 'TEXT NOT NULL';
    const dateType = 'DATETIME NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    final String sql = '''
    CREATE TABLE $tableCountry (
    ${CountryField.id} $idType,
    ${CountryField.country} $textType,
    ${CountryField.countryCode} $textType,
    ${CountryField.slug} $textType,
    ${CountryField.dateTime} $dateType,
    ${CountryField.totalConfirmed} $integerType,
    ${CountryField.totalRecovered} $integerType,
    ${CountryField.totalDeaths} $integerType,
    ${CountryField.newConfirmed} $integerType,
    ${CountryField.newRecovered} $integerType,
    ${CountryField.newDeaths} $integerType)
    ''';
    await db.execute(sql);
  }

  Future<Country> createData(Country country) async {
    final db = await instance.database;
    final id = await db.insert(tableCountry, country.toJson());
    return country.copy(id: id);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Country?> readDataByID(String slug) async {
    final db = await instance.database;
    final maps = await db.query(
      tableCountry,
      columns: CountryField.values,
      where: '${CountryField.slug} = ?',
      whereArgs: [slug],
    );

    if (maps.isNotEmpty) {
      return Country.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<bool> isContain(String slug) async {
    final check = await readDataByID(slug);
    if (check == null) {
      return false;
    }
    return true;
  }

  Future<int> update(Country country) async {
    final db = await instance.database;
    return db.update(
      tableCountry,
      country.toJson(),
      where: '${CountryField.id} = ?',
      whereArgs: [country.id],
    );
  }

  Future<int> deleteBySlug(String slug) async {
    final db = await instance.database;
    final delete = db.delete(
      tableCountry,
      where: '${CountryField.slug} = ?',
      whereArgs: [slug],
    );
    return delete;
  }

  Future<List<Country>> readAllCountries() async {
    final db = await instance.database;
    final result = await db.query(tableCountry);
    final check = List.generate(
      result.length,
      (index) => Country.fromJson(
        result[index],
      ),
    );
    return check;
  }
}
