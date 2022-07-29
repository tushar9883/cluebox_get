import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class StorageData {
  final ImagePicker _picker = ImagePicker();
  late FirebaseStorage storageReferece;

  //Get the url of the file in the database
  Future<String?> getFileUrl({String? key}) async {
    return '';
  }

  //Get all images and videos
  Future<void> getImageVideoFiles({String? key}) async {}

  //Upload and image or video file
  Future<XFile?> uploadImageFile({String? fileType}) async {
    final XFile? file;
    switch (fileType) {
      case 'imageGallery':
        // Pick an image
        file = await _picker.pickImage(
            source: ImageSource.gallery,
            preferredCameraDevice: CameraDevice.front,
            imageQuality: 25,
            maxHeight: 400,
            maxWidth: 400);
        return file;
      case 'imageCamera':
        // Capture a photo
        file = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 10,
        );
        return file;
      case 'videoGallery':
        file = await _picker.pickVideo(source: ImageSource.gallery);

        return file;
      case 'videoCamera':
        file = await _picker.pickVideo(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
        );
        return file;
      default:
        print('Could not find your request!');
        return null;
    }
  }

  //Upload file to firebase storage
  Future<Map<String, dynamic>> uploadFile(
      {XFile? xfile, String? folderName}) async {
    print("*************************");
    String fileUrl = '';
    String thumbnailUrl = '';
    // final Info.MediaInfo _mediaInfo = Info.MediaInfo();

    Map<String, dynamic> result;
    try {
      print("=======================Success===========================");
      if (xfile != null) {
        storageReferece = FirebaseStorage.instance;
        Reference ref = storageReferece
            .ref()
            .child('$folderName/${Path.basename(xfile.path)}');

        UploadTask uploadTask = ref.putFile(File(xfile.path));
        var downloadUrl = await (await uploadTask).ref.getDownloadURL();
        fileUrl = downloadUrl.toString();

        result = {'imageUrl': fileUrl};
        print("RETUUUUUUUUUUUUUUURN $result");
        return result;
      }
      //In case null value were received
      result = {
        'videoUrl': '',
        'imageUrl': '',
      };
      return result;
    } catch (e, stackTrace) {
      print("manish");
      print('Error uploading file: $e');
      // await Sentry.captureException(e, stackTrace: stackTrace);
      result = {'error': e.toString()};
      return result;
    }
  }

  // //Generate thumbnail image from a video url
  // Future<File?> generateThumbnailUrl(String videoUrl) async {
  //   final fileName = await VideoThumbnail.thumbnailFile(
  //       video: videoUrl,
  //       thumbnailPath: (await getTemporaryDirectory()).path,
  //       imageFormat: ImageFormat.JPEG,
  //       quality: 100);
  //
  //   var file = File(fileName!);
  //   return file;
  // }

  //Query from bucket
  Future<void> listAllItems() async {}

  //Upload profile photo
  Future<String> uploadProfilePhoto() async {
    return '';
  }
}
