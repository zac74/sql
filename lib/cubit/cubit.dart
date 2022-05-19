import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gam3a/addproperty/addproperty.dart';
import 'package:gam3a/cubit/states.dart';
import 'package:gam3a/homescreen.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../favourites/favourites_Screen.dart';
import '../home/home.dart';
import '../profile/profile_screen.dart';

class RealEstateCubit extends Cubit<RealEstateStates>
{
  RealEstateCubit() : super(RealEstateInitialState());

  static RealEstateCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;
  List<Widget>bottomScreens=[
    Home(),
    FavouritesScreen(),
    AddProperty(),
    ProfileScreen(),
  ];
  List<Widget>Screens=[
    HomeScreen(),
  ];
  void ChangeBottom(int index){
    currentIndex=index;
    emit(RealEstateChangeBottomNavState());
  }

  late Database database;
  List<Map> property = [];

  void createDatabse(){
    openDatabase(
        'ARQA For Real Estate',
        version: 1,
        onCreate: (database, version) async {
          print('databse created');

          await database.execute(
            // 'CREATE TABLE Test (id INTEGER PRIMARY KEY, Title TEXT,Details TEXT,PhoneNumber TEXT,Location TEXT,Bedroom INTEGER,Bathroom INTEGER, Area INTEGER ,Price INTEGER , )');
            //  'CREATE TABLE Properties (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
              'CREATE TABLE Properties1 (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
        },

        onOpen: (database){
          print('database opened');
          getDataFromDatabase(database).then((value) {
           property=value;
           print(property);
           emit(AppGetDatabaseState());
           }
           );


        }

    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    }) ;
  }

   insertToDatabase({
    required String image,
    required String title,
    required String bedroom,
    required String area,
    required String price,


  })async
  {
    await database.transaction((txn) async {
       txn.rawInsert(
          'INSERT INTO Properties1 (Img, Title, Bedroom ,Area,Price ) VALUES ("$image" , "$title" , "$bedroom","$area","$price")')
          .then((value) => print('$value inserted succefully'));
           emit(AppInsertDatabaseState());
             getDataFromDatabase(database).then((value) {
            property=value;
             print(property);
             emit(AppGetDatabaseState());
           }
           );
           }).catchError((e)=> print('error when inserting data: $e'));

    }



  }
  Future <List<Map>> getDataFromDatabase(database) async{
    return await database.rawQuery('SELECT * FROM Properties1');
  }
