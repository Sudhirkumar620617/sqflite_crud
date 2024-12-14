import 'dart:io';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../modles/user_modle.dart';

class DataController extends GetxController {
  var allData = <Map<String, dynamic>>[].obs;
  Database? myDatabase;

  // Table name
  static const String tableName = "StudentData";
  @override
  void onInit() {
    super.onInit();
    getAllData();
  }

  // Column names
  static const String columnSrNo = "sr_no";
  static const String columnStudentName = "Student_Name";
  static const String columnStudentAddress = "Student_Address";
  static const String columnStudentEmail = "Student_Email";
  static const String columnStudentPassword = "Password";
  static const String columnStudentPhone = "Student_Phone";

  // Open Database (if exists, open it; otherwise, create it)
  Future<Database> getDatabase() async {
    if (myDatabase != null) {
      return myDatabase!;
    }
    myDatabase = await openDb();
    return myDatabase!;
  }

  Future<Database> openDb() async {
    Directory dirPath = await getApplicationDocumentsDirectory();
    String databasePath = join(dirPath.path, "studentData.db");

    return await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        // Create table
        await db.execute('''
          CREATE TABLE $tableName (
            $columnSrNo INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnStudentName TEXT NOT NULL,
            $columnStudentAddress TEXT NOT NULL,
            $columnStudentEmail TEXT NOT NULL UNIQUE,
            $columnStudentPassword TEXT NOT NULL,
            $columnStudentPhone TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<bool> insertData(UserModles userModles) async {
    var db = await getDatabase();
    int rowEffected = await db.insert(
      tableName, {
        columnStudentName: userModles.username,
        columnStudentAddress: userModles.address,
        columnStudentPhone: userModles.phone,
        columnStudentEmail: userModles.email,
        columnStudentPassword: userModles.password,
      },
    );
    return rowEffected > 0;
  }

  Future<void> getAllData() async {
    var db = await getDatabase();
    List<Map<String, dynamic>> myData = await db.query(tableName);
    allData.value = myData;
  }

  Future<bool> updateData({required UserModles userModles, required int index})async{
    var db = await getDatabase();
    int rowEffected= await db.update(tableName,{
      columnStudentName:userModles.username,
      columnStudentAddress:userModles.address,
      columnStudentEmail:userModles.email,
      columnStudentPassword :userModles.password,
      columnStudentPhone :userModles.phone
    } ,where: "$columnSrNo = $index");
    return rowEffected >0;}


  Future<bool> deleteData(int index) async {
    var db = await getDatabase();
      int rowEffected = await db.delete(tableName, where: "$columnSrNo = ?", whereArgs: [index],);
      if (rowEffected > 0) {
        getAllData();
        return true;
      }
      return false;
    }
  }

