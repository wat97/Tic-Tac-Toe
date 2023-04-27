import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/models.dart';

class DatabaseHelper {
  static final String nameDb = "simpananKuDb";
  static final String nameTbGeneral = "plan_general";
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "/" + nameDb;
    print("pathData $path");
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    // TABLE plan_general
    await db.execute('''
      CREATE TABLE $nameTbGeneral (
          id INTEGER PRIMARY KEY, 
          title TEXT, 
          start_money BIGINT,
          goals_money BIGINT,
          startline DATETIME NULL,
          deadline DATETIME NULL,
          status_planner BOOLEAN, 
          created_at DATETIME, 
          updated_at DATETIME
      );
      ''');

    // TABLE plan_detail
    await db.execute('''
      CREATE TABLE plan_detail(
          id INTEGER PRIMARY KEY, 
          id_plan_general INTEGER, 
          title TEXT, 
          operation VARCHAR(10),
          type_value VARCHAR(10),
          value_nominal FLOAT,
          is_incremental BOOLEAN,
          type_detail VARCHAR(32),
          created_at DATETIME, 
          updated_at DATETIME
      );
      ''');
  }

  Future<int> addPlantGeneral(ModelPlanGeneral modelPlanGeneral) async {
    Database db = await instance.database;
    return await db.insert(nameTbGeneral, modelPlanGeneral.toJson());
  }

  Future<List<ModelPlanGeneral>> getDataPlantGeneral() async {
    Database db = await instance.database;
    var datas = await db.query(nameTbGeneral, orderBy: 'id DESC');
    List<ModelPlanGeneral> dataList = datas.isNotEmpty
        ? datas.map((c) => ModelPlanGeneral.fromJson(c)).toList()
        : [];
    return dataList;
  }

  insert({
    Function()? refresh,
    required ModelPlanGeneral modelPlanGeneral,
  }) async {
    DateTime now = DateTime.now();

    await DatabaseHelper.instance.addPlantGeneral(modelPlanGeneral);
    var result = await DatabaseHelper.instance.getDataPlantGeneral();

    result.forEach((element) {
      print(element.title);
    });

    if (refresh != null) {
      refresh();
    }
  }
}
