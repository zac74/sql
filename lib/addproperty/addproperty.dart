import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gam3a/cubit/cubit.dart';
import 'package:gam3a/cubit/states.dart';
import 'package:gam3a/home/home.dart';
import 'package:gam3a/homescreen.dart';
import 'package:gam3a/profile/profile_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import '../constants/constants.dart';





class AddProperty extends StatefulWidget {
  @override
  State<AddProperty> createState() => _AddPropertyState();
}
class _AddPropertyState extends State<AddProperty> {

  @override
  initState(){
    super.initState();
    createDatabse();
  }


TextEditingController titleController = TextEditingController();
TextEditingController detailsController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController bedroomsController = TextEditingController();
TextEditingController bathroomsController = TextEditingController();
TextEditingController areaController = TextEditingController();
TextEditingController phonenumberController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController imgController = TextEditingController();



  @override


  Widget build(BuildContext context) {
    var cubit = RealEstateCubit.get(context);
    return BlocProvider(
      create: (BuildContext context) => RealEstateCubit()..createDatabse(),
      child: BlocConsumer<RealEstateCubit, RealEstateStates>(
        listener: (BuildContext context , RealEstateStates state){
          if (state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
          builder: (BuildContext context , RealEstateStates state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.title),
                          labelText: 'Title',
                          hintText: 'Property Title',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: detailsController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.assignment),
                          labelText: 'Details',
                          hintText: 'Property Details',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bedroomsController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.bedroom_parent_outlined),
                          labelText: 'Bedrooms ',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bathroomsController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.bathroom_outlined),
                          labelText: 'Bathrooms',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: areaController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.crop_square_outlined),
                          labelText: 'Area',
                          hintText: 'Property Area',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_on),
                          labelText: 'Location',
                          hintText: 'Add Address',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: phonenumberController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                          hintText: '01115123763',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: priceController,
                        keyboardType: const TextInputType.numberWithOptions(),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.attach_money_outlined),
                          labelText: 'Price',
                          hintText: 'property price',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      TextFormField(
                        controller: imgController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.attach_money_outlined),
                          labelText: 'Image',
                          hintText: 'Image Path',
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.red, width: 5)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                        onPressed: () async {
                          insertToDatabase(image: imgController.text,
                              title: titleController.text,
                              bedroom: bedroomsController.text,
                              area: areaController.text,
                              price: priceController.text);
                          //Navigator.push(context, MaterialPageRoute(builder:(context) => HomeScreen() ));
                          cubit.ChangeBottom(0);
                        },
                        child: Text('Add'),
                      ),
                    ],
                  ),
                ),
              ),


            );
          }
      )
    );

  }
}
