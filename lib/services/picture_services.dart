
import 'package:alarm_app/model_class/mode_class.dart';
import 'package:alarm_app/repository/repository.dart';


class PictureServices{
  late Repository _repository;

  PictureServices(){
    _repository = Repository();
  }

  SaveUser(SavePicture savePicture) async{
    return await _repository.insertData('pics_save', savePicture.savePictureMap());
  }
}