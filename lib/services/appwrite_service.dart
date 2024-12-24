import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppwriteService {
  late Client _client;
  late Account _account;
  late Databases _databases;
  late Storage _storage;

  AppwriteService() {
    _client = Client()
      ..setEndpoint('https://${dotenv.env['APPWRITE_URL']}') // Ensure this is correctly loaded
      ..setProject(dotenv.env['PROJECT_ID']!);

    _account = Account(_client);
    _databases = Databases(_client);
    _storage = Storage(_client);
  }

  final String? databaseId = dotenv.env['DATABASE_ID'];
  final String? collectionId = dotenv.env['COLLECTION_ID'];
  final String? bucketId = dotenv.env['BUCKET_ID'];

  Future<Document?> createDocument(Map<String, dynamic> data) async {
    try {
      final document = await _databases.createDocument(
        databaseId: databaseId!,
        collectionId: collectionId!,
        documentId: 'unique()',
        permissions: [
          Permission.read(Role.user(data['user_id'])),
          Permission.write(Role.user(data['user_id']))
        ],
        data: {
          'name': data['name'],
          'type': data['type'],
          'lyrics': data['lyrics'],
          'audio_url': data['audio_url'],
          'user_id': data['user_id']
        },
      );
      return document;
    } catch (e) {
      print('Error creating document: $e');
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

  /// Sign up with name, email, and password
  Future<User?> signUp(String name, String email, String password) async {
    try {
      final user = await _account.create(
        userId: 'unique()', 
        email: email, 
        password: password,
        name: name,
      );
      return user;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  /// Login with email and password
  Future<Session?> login(String email, String password) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  /// Logout the current user
  Future<void> logout() async {
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      print('Error logging out: $e');
    }
  }

  /// Get the current logged-in user's details
  Future<User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }
}
