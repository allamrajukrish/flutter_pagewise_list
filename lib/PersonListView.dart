import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'constants.dart';
import 'package:listview_sample/model/PersonModel.dart';

class PersonListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonListViewState();
  }
}

class PersonListViewState extends State<PersonListView> {
  final userScrollController = new ScrollController();
  bool isLoading = false;
  final scafFoldKey = GlobalKey<ScaffoldState>();
  final int recordsPerPage = 20;
  int pageIndex = 1;

  List<PersonDetailsModel> personListArray = List();

  @override
  void initState() {
    super.initState();

    loadMoreRecords();

    userScrollController.addListener(() {
      if (userScrollController.position.maxScrollExtent ==
          userScrollController.offset) {
        pageIndex = pageIndex + 1;
        loadMoreRecords();
      }
    });
  }

  Future loadMoreRecords() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    var dio = Dio();
    var apiRequest = baseUrl + pageIndex.toString();
    print('apiRequest/loadMoreRecords is $apiRequest');

    var response = await dio.get(apiRequest);

    if (response.statusCode == 200) {
      var jsonResponse = response.data;
      // print('jsonResponse is $jsonResponse');

      PersonModel pDetailsObject = new PersonModel();

      this.setState(() {
        List<PersonDetailsModel> dummyListArray;

        dummyListArray = pDetailsObject
            .saveAllPersonListDataResultsInObjectFile(jsonResponse);
        
        if (dummyListArray.length > 0) {
          

          personListArray.addAll(dummyListArray);
          //print('dummyListArray/loadMoreRecords is ${dummyListArray.length}');
          //print('personListArray/loadMoreRecords is ${personListArray.length}');
        }

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Users List'),
        centerTitle: true,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListView.builder(
                controller: userScrollController,
                itemCount:
                    personListArray == null ? 0 : personListArray.length + 1,
                itemBuilder: (context, index) {
                  if (index < personListArray.length) {
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.all(12.0),
                      child: ListTile(
                        isThreeLine: false,
                        title: Text(
                          "Name : " +
                              personListArray[index].personName + "\n" + 'Id : ${index+1}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Email : " +
                              personListArray[index].personEmail +
                              "\n",
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(personListArray[index].personPicture),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {},
                      ),
                    );
                  }
                  return Center(
                    child: Opacity(
                      opacity: isLoading ? 1.0 : 0.0,
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
