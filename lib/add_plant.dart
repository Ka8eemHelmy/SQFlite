import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odc_sql/database.dart';
import 'package:odc_sql/plant_model.dart';

import 'components/custom_text.dart';
import 'home.dart';

class AddPlant extends StatelessWidget {
  AddPlant({super.key});

  AddPlant.withPlant(this.plantDetail, {super.key}) {
    namePlant.text = plantDetail!.name;
    descriptionPlant.text = plantDetail!.description;
  }

  Plant? plantDetail;

  TextEditingController namePlant = TextEditingController();
  TextEditingController descriptionPlant = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.green,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Add Plant",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextInput(
                  "Enter Name",
                  namePlant,
                  TextInputType.text,
                  false,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter Name of Planet';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                ),
                CustomTextInput(
                  "Enter Description",
                  descriptionPlant,
                  TextInputType.text,
                  false,
                  (value) {
                    if (value!.isEmpty) {
                      return 'Please, Enter Description of Planet';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (plantDetail == null) {
                      //todo add plant to db
                      if (formKey.currentState!.validate()) {
                        SQLHelper.addPlant(
                          namePlant.text,
                          descriptionPlant.text,
                        ).then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            )));
                      }
                    } else {
                      //todo update plant from ui
                      if (formKey.currentState!.validate()) {
                        SQLHelper.updatePlant(
                          plantDetail!.id,
                          namePlant.text,
                          descriptionPlant.text,
                        ).then((value) => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            )));
                      }
                    }
                  },
                  child: Text(
                      plantDetail == null ? "Add Plant to DB" : "Update Plant"),
                ),
                plantDetail == null
                    ? SizedBox()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          SQLHelper.deletePlant(plantDetail!.id).then(
                            (value) => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            ),
                          );
                        },
                        child: const Text("Delete"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
