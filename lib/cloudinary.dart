import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:mime/mime.dart';

class CloudinaryService {
  final String cloudName = "dn9t6mk2j"; 
  final String uploadPreset = "dotby_uploads"; // Replace with your upload preset (create one on Cloudinary dashboard)

  Future<String> uploadImage(File imageFile) async {
    try {
      // Prepare the image file for upload
      String fileName = basename(imageFile.path);
      String mimeType = lookupMimeType(imageFile.path) ?? "image/jpeg";
      Uri url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      var request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', imageFile.path, contentType: MediaType.parse(mimeType)));

      // Send the request
      var response = await request.send();

      // If the upload is successful, get the response data
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseData);
        return responseJson['secure_url']; // This is the URL to the uploaded image
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Error uploading image');
    }
  }
}
