 https://codingwithdhrumil.com/2021/02/dio-flutter-rest-api-example.html


import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecommerceshope/API_All_ModelClass/all_category_model_class.dart';
import 'package:ecommerceshope/Drawer/drawerdemo.dart';
import 'package:ecommerceshope/Drawer/enddrawer.dart';
import 'package:ecommerceshope/LoginPage/login_screen.dart';
import 'package:ecommerceshope/ProviderDemo/All_product_Provider/CategoryProvider/category_provider.dart';
import 'package:ecommerceshope/Screen/AllProduct/one_product_cart_details.dat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../API_Integration_All/for_all_category.dart';

class CategoryPageAPI extends StatefulWidget {
  const CategoryPageAPI({Key? key}) : super(key: key);

  @override
  State<CategoryPageAPI> createState() => _CategoryPageAPIState();
}

class _CategoryPageAPIState extends State<CategoryPageAPI> {
  List<Data> categolylist=[];



  // getCategoryDAta()async{
  //   try{
  //     var link="${BaseURL}category";
  //     var response=await http.get(Uri.parse(link));
  //     print(response.statusCode);
  //     if(response.statusCode==200){
  //       var categorydata=jsonDecode(response.body);
  //       Data data;
  //       for(var i in categorydata["data"]){
  //         data=Data.fromJson(i);
  //         categolylist.add(data);
  //       }
  //     }
  //   }catch(error){print("CategoryData error from api $error");}
  //   return categolylist;
  // }


   fetchUsers() async {
    try {
      Response response = await Dio().get("${BaseURL}category");
      print(response.statusCode);
      if (response.statusCode == 200) {
        var getUsersData = response.data["data"] as List;
       var  listUsers = getUsersData.map((data) => Data.fromJson(data)).toList();
        print(listUsers);
        return listUsers;
      } else {
    throw Exception("‘Failed to load users’");
    }
    } catch (e) {
    print(e);
    }

  }
   Future<dynamic>? listUsers;

  @override
  void initState() {

    listUsers= fetchUsers();
    super.initState();

  }
  //
  //
  // @override
  // void initState() {
  //   fetchUsers();
  //     final categoriesData =
  //     Provider.of<CategoryProvider>(context, listen: false)
  //         .getCategories(context,);
  //     super.initState();
  //
  //   // TODO: implement initState
  //   super.initState();
  // }

  final _key=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final alldatalist = Provider.of<CategoryProvider>(context).allproductlist;
    final cat = Provider.of<CategoryProvider>(context);
    return Scaffold(
        body: FutureBuilder (
         future: listUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var user = (snapshot.data as List<Data>)[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("${user.name}", style: TextStyle( fontWeight: FontWeight.bold, fontSize: 22)),

                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: (snapshot.data as List<Data>).length);
            } else if (snapshot.hasError) {
              return Center( child: Text("${snapshot.error}"));
            }
            return Center(
              child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
            );
          },
        ));
  }
}
