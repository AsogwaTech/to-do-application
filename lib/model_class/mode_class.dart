
class UserData {
  int? id;
  String? userName;
  String? fullName;
  String? email;
  String? password;

  userDataMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['userName'] = userName!;
    mapping['fullName'] = fullName!;
    mapping['email'] = email!;
    mapping['password'] = password!;
    return mapping;
  }
}

class TaskDescription{
  int? id;
  String? taskTitle;
  String? taskDescription;

  taskDescriptionMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['taskTitle'] = taskTitle!;
    mapping['taskDescription'] = taskDescription!;
    return mapping;
  }
}

class SavePicture{
  int? id;
  String? title;
  String? picture;

  savePictureMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['title'] = title!;
    mapping['picture'] = picture!;
    return mapping;
  }
}