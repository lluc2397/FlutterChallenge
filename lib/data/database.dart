import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trialing/data/models.dart';

class ONGDatabase {
  static final ONGDatabase instance = ONGDatabase._init();

  static Database? _database;

  ONGDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ongtests.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
  

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableProjects ( 
        ${ProjectFields.id} $idType,
        ${ProjectFields.name} $textType,
        ${ProjectFields.web} $textType,
        ${ProjectFields.description} $textType,
        ${ProjectFields.img} $textType,
        ${ProjectFields.budget} $integerType,
        ${ProjectFields.closingDate} $textType,
        ${ProjectFields.isOpened} $boolType,
        )
      ''');
      await db.execute('''
      CREATE TABLE $tableStackeholders ( 
        ${StackeholderFields.id} $idType, 
        ${StackeholderFields.fullName} $textType,
        ${StackeholderFields.email} $textType,
        ${StackeholderFields.web} $textType,
        ${StackeholderFields.projecsFounded} $textType,
        ${StackeholderFields.amount} $integerType,
        )
      ''');
        }

  Future<Project> create(Project project) async {
    final db = await instance.database;
    final id = await db.insert(tableProjects, project.toJson());
    return project.copy(id: id);
  }


  Future<List<Project>> readAllProject() async {
    final db = await instance.database;

    final orderBy = '${ProjectFields.closingDate} ASC';

    final result = await db.query(tableProjects, orderBy: orderBy);

    return result.map((json) => Project.fromJson(json)).toList();
  }

  
}