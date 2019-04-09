class PersonModel {
  List<PersonDetailsModel> personListArray = List();

  List<PersonDetailsModel> saveAllPersonListDataResultsInObjectFile(
      jsonResponse) {
    // print('jsonResponse/PersonModel.dart is ======== $jsonResponse');

    for (Map personDetails in jsonResponse) {
    //  print('personDetails is ======== $personDetails');
      PersonDetailsModel newUserObject = PersonDetailsModel();

      newUserObject.personID = personDetails['index'];
      newUserObject.aboutPerson = personDetails['about'];
      newUserObject.personName = personDetails['name'];
      newUserObject.personEmail = personDetails['email'];
      newUserObject.personPicture = personDetails['picture'];

      print(
          'newUserObject.personName/PersonModel.dart is ======== ${newUserObject.personName}');
      print(
          'newUserObject.personEmail/PersonModel.dart is ======== ${newUserObject.personEmail}');

      //Adding Object to array...
      personListArray.add(newUserObject);
    }
    return personListArray;
  }
}

class PersonDetailsModel {
  /*
   {
    "index": 0,
    "about": "Ipsum nisi culpa esse laborum eu. Excepteur labore mollit minim officia proident enim fugiat pariatur cupidatat consequat quis eiusmod fugiat duis. In laborum mollit nostrud aute consectetur do dolore sint occaecat velit do commodo duis anim. Do reprehenderit exercitation sint minim ut cillum eu occaecat sint do commodo.\r\nDolor in minim irure excepteur voluptate id ipsum fugiat culpa sunt deserunt velit aute. Pariatur cupidatat commodo ipsum sint eu elit sit esse in quis. Nulla do ex deserunt fugiat aliquip velit deserunt consectetur labore. Labore nulla laboris dolor mollit officia ad. Aute anim labore labore et minim nostrud. Dolore ad ex exercitation labore reprehenderit duis est do eu nisi do occaecat. Cillum aute sint aliquip aute ad et velit fugiat quis Lorem tempor sit.\r\n",
    "email": "kathleendoyle@orboid.com",
    "name": "Kathleen Doyle",
    "picture": "https://randomuser.me/api/portraits/men/0.jpg"
  }
  */

  int personID;
  String aboutPerson;
  String personName;
  String personEmail;
  String personPicture;
}
