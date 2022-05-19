import 'package:sqflite/sqflite.dart';



late Database database;
List<Map> property = [];
Future createDatabse()async{
  database = await openDatabase(
      'ARQA For Real Estate',
      version: 1,
      onCreate: (database, version) async {
        print('databse created');

        await database.execute(
          // 'CREATE TABLE Test (id INTEGER PRIMARY KEY, Title TEXT,Details TEXT,PhoneNumber TEXT,Location TEXT,Bedroom INTEGER,Bathroom INTEGER, Area INTEGER ,Price INTEGER , )');
          //  'CREATE TABLE Properties (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
          //  'CREATE TABLE Properties1 (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
            'CREATE TABLE RealEstate (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT,Details TEXT,Location TEXT,Bathroom TEXT, ,Bedroom INTEGER, Area INTEGER ,Phone_Number TEXT ,Price INTEGER)');
      },

      onOpen: (database){
        print('database opened');
        getDataFromDatabase(database).then((value) {

          property=value;
          print(property);


        });


      }

  );
}
Future <List<Map>> getDataFromDatabase(database) async{
  return await database.rawQuery('SELECT * FROM Properties1');
}
void insertToDatabase({
  required String image,
  required String title,
  required String bedroom,
  required String area,
  required String price,


}){
  database.transaction((txn) async {


    await txn.rawInsert('INSERT INTO Properties1 (Img, Title, Bedroom ,Area,Price ) VALUES ("$image" , "$title" , "$bedroom","$area","$price")')
        .then((value) => print('$value inserted succefully'))
        .catchError((e)=> print('error when inserting data: $e'));

  });


}
