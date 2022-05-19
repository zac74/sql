import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gam3a/component/components.dart';
import 'package:gam3a/search/SearchScreen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sqflite/sqflite.dart';
import 'constants/constants.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    setState(() {
      super.initState();
      createDatabse().then((value) => setState((){}));
    });

     }
    // late Database database;
    // void createDatabse()async{
    //   database = await openDatabase(
    //       'ARQA For Real Estate',
    //       version: 1,
    //       onCreate: (database, version) async {
    //         print('databse created');
    //
    //         await database.execute(
    //           // 'CREATE TABLE Test (id INTEGER PRIMARY KEY, Title TEXT,Details TEXT,PhoneNumber TEXT,Location TEXT,Bedroom INTEGER,Bathroom INTEGER, Area INTEGER ,Price INTEGER , )');
    //           //  'CREATE TABLE Properties (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
    //             'CREATE TABLE Properties1 (id INTEGER PRIMARY KEY, Img TEXT, Title TEXT, Bedroom INTEGER, Area INTEGER , Price INTEGER)');
    //       },
    //
    //       onOpen: (database){
    //         print('database opened');
    //         getDataFromDatabase(database).then((value) {
    //           setState(() {
    //             property=value;
    //           });
    //           print(property);
    //         }
    //         );
    //
    //
    //       }
    //
    //   );
    // }
    // Future <List<Map>> getDataFromDatabase(database) async{
    //   return await database.rawQuery('SELECT * FROM Properties1');
    // }
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<RealEstateCubit, RealEstateStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RealEstateCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('ARQA'),
              actions: [
                IconButton(icon: Icon(Icons.search), onPressed: () {
                  navigateTo(context, SearchScreen());
                },),

              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SalomonBottomBar(
                  unselectedItemColor: Colors.white,
                  onTap: (index) {
                    cubit.ChangeBottom(index);
                  },
                  currentIndex: cubit.currentIndex,
                  items: [

                    /// Home
                    SalomonBottomBarItem(
                      icon: Icon(Icons.home),
                      title: Text("Home"),
                      selectedColor: Colors.blue,
                    ),

                    /// Likes
                    SalomonBottomBarItem(
                      icon: Icon(Icons.favorite_border),
                      title: Text("Favorites"),
                      selectedColor: Colors.pink,
                    ),


                    /// ADD Property
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.add),
                      title: const Text("Add"),
                      selectedColor: Colors.yellow,
                    ),

                    /// Profile
                    SalomonBottomBarItem(
                      icon: const Icon(Icons.person),
                      title: const Text("Profile"),
                      selectedColor: Colors.teal,
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }


