import 'package:appwrite/appwrite.dart';
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppwriteService {
  late Client _client;
  late Account _account;
  late Databases _databases;
  late Storage _storage;

  final String? appwriteUrl = dotenv.env['APPWRITE_URL'];
  final String? projectId = dotenv.env['PROJECT_ID'];
  final String? databaseId = dotenv.env['DATABASE_ID'];
  final String? collectionId = dotenv.env['COLLECTION_ID'];
  final String? bucketId = dotenv.env['BUCKET_ID'];

  AppwriteService() {
    _client = Client()
      ..setEndpoint(appwriteUrl!) // Ensure this is correctly loaded
      ..setProject(projectId!)
      ..setSelfSigned(status: true);

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
  }

  Future<Document?> createDocument(Map<String, dynamic> data) async {
    try {
      final document = await _databases.createDocument(
        databaseId: databaseId!,
        collectionId: collectionId!,
        documentId: 'unique()',
        permissions: [
          Permission.read(Role.user(data['user_id'])),
          Permission.write(Role.user(data['user_id'])),
        ],
        data: {
          'name': data['name'],
          'type': data['type'],
          'lyrics': data['lyrics'],
          'audio_url': data['audio_url'],
          'user_id': data['user_id'],
        },
      );
      return document;
    } catch (e) {
      print('Error creating document: $e');
      return null;
    }
  }
  
  Future<List<Document>?> getDocuments() async {
    try {
      final documents = await _databases.listDocuments(
        databaseId: databaseId!,
        collectionId: collectionId!,
      );
      return documents.documents;
    } catch (e) {
      print('Error retrieving documents: $e');
      return null;
    }
  }

  Future<File?> uploadFile(String filePath) async {
    try {
      final file = await _storage.createFile(
        bucketId: bucketId!,
        fileId: 'unique()',
        file: InputFile.fromPath(path: filePath),
      );
      return file;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  Future<String?> signUp(String name, String email, String password) async {
    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      return "success";
    } on AppwriteException catch (e) {
      return 'SignUp Error: ${e.message}';
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      // Clear any existing session
      await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return "success";
    } on AppwriteException catch (e) {
      return 'Login Error: ${e.message}';
    }
  }

  Future<void> logout() async {
    try {
      bool? isSessionActive = await checkSession();
      if (isSessionActive != true) {
        print('No active session to log out from.');
        return;
      }
      await _account.deleteSession(sessionId: 'current');
      print('Logged out successfully');
    } on AppwriteException catch (e) {
      print('Error logging out: ${e.message}');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      print('User details: ${user.toMap()}');
      return user;
    } on AppwriteException catch (e) {
      print('Error getting current user: ${e.message}');
      return null;
    }
  }

  Future<bool> checkSession() async {
    try {
      await _account.getSession(sessionId: "current");
      return true;
    } on AppwriteException catch(e) {
      print('No active session: ${e.message}');
      return false;
    }
  }

  Future<bool> continueWithGoogle() async {
  try {
    final response = await _account
        .createOAuth2Session(provider: OAuthProvider.google, scopes: ["profile", "email"]);
    print(response);
    return true;
  } catch (e) {
    print("error : ${e.toString()}");
    return false;
  }
}
}
