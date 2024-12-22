import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppwriteService {
  late Client _client;
  late Account _account;
  late Databases _databases;
  late Storage _storage;

  AppwriteService() {
    _client = Client()
      ..setEndpoint('https://${dotenv.env['APPWRITE_URL']}')
      ..setProject('${dotenv.env['PROJECT_ID']}');

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: dotenv.env['GOOGLE_CLIENT_ID'], // Add this line
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final session = await _account.createOAuth2Session(
        provider: OAuthProvider.google,
        success: 'https://your-app-url.com/success', // Replace with your success URL
        failure: 'https://your-app-url.com/failure', // Replace with your failure URL
        scopes: ['email'],
      );

      return session.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<Document?> createDocument(
      String databaseId, String collectionId, Map<String, dynamic> data) async {
    try {
      final document = await _databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: 'unique()',
          permissions: [
            Permission.read(Role.user('[USER_ID]')),
            Permission.write(Role.user('[USER_ID]'))
          ],
          data: {
            'name': data['name'],
            'type': data['type'],
            'lyrics': data['lyrics'],
            'audio_url': data['audio_url'],
            'user_id': data['user_id']
          });
      return document;
    } catch (e) {
      print('Error creating document: $e');
      return null;
    }
  }

  Future<File?> uploadFile(String bucketId, String filePath) async {
    try {
      final file = await _storage.createFile(
        bucketId: bucketId,
        fileId: 'unique()',
        file: InputFile.fromPath(path: filePath),
      );
      return file;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}
