import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_glimpse/preview/model/app.dart';
import 'package:store_glimpse/profile/model/user.dart';

class PreviewRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createPreview(User user, App app) async {
    try {
      var docRef = _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc();

      await docRef.set(app.copyWith(id: docRef.id).toDocument());
    } catch (e) {
      throw Exception('Error creating app');
    }
  }

  Stream<List<App>> getPreviews(User user) {
    return _firestore
        .collection('users')
        .doc(user.id)
        .collection('previews')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => App.fromDocument(doc)).toList());
  }

  Future<void> updatePreview(User user, App app) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc(app.id)
          .update(app.toDocument());
    } catch (e) {
      throw Exception('Error updating app');
    }
  }

  Future<void> deletePreview(User user, App app) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc(app.id)
          .delete();
    } catch (e) {
      throw Exception('Error deleting app');
    }
  }

  // Upload App Icon
  Future<void> uploadAppIcon(User user, App app, XFile appIcon) async {
    try {
      var ref = _storage
          .ref()
          .child('users')
          .child(user.id!)
          .child('previews')
          .child(app.id!)
          .child('appIcon.png');

      await ref.putData(await appIcon.readAsBytes());
      var url = await ref.getDownloadURL();

      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc(app.id)
          .update({'appIcon': url});
    } catch (e) {
      throw Exception('Error uploading app icon');
    }
  }

  // Upload App Screenshots
  Future<void> uploadAppScreenshots(
      User user, App app, List<XFile> appScreenshots) async {
    try {
      var ref = _storage
          .ref()
          .child('users')
          .child(user.id!)
          .child('previews')
          .child(app.id!);

      for (var i = 0; i < appScreenshots.length; i++) {
        var screenshotRef = ref.child('appScreenshot$i.png');
        await screenshotRef.putData(await appScreenshots[i].readAsBytes());
        var url = await screenshotRef.getDownloadURL();

        await _firestore
            .collection('users')
            .doc(user.id)
            .collection('previews')
            .doc(app.id)
            .update({
          'appScreenshots': FieldValue.arrayUnion([url])
        });
      }
    } catch (e) {
      throw Exception('Error uploading app screenshots');
    }
  }

  // Delete App Icon
  Future<void> deleteAppIcon(User user, App app) async {
    try {
      var ref = _storage
          .ref()
          .child('users')
          .child(user.id!)
          .child('previews')
          .child(app.id!)
          .child('appIcon.png');

      await ref.delete();

      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc(app.id)
          .update({'appIcon': null});
    } catch (e) {
      throw Exception('Error deleting app icon');
    }
  }

  // Delete App Screenshots
  Future<void> deleteAppScreenshots(User user, App app) async {
    try {
      var ref = _storage
          .ref()
          .child('users')
          .child(user.id!)
          .child('previews')
          .child(app.id!);

      for (var i = 0; i < app.screenshots!.length; i++) {
        var screenshotRef = ref.child('appScreenshot$i.png');
        await screenshotRef.delete();

        await _firestore
            .collection('users')
            .doc(user.id)
            .collection('previews')
            .doc(app.id)
            .update({
          'appScreenshots': FieldValue.arrayRemove([app.screenshots![i]])
        });
      }
    } catch (e) {
      throw Exception('Error deleting app screenshots');
    }
  }

  // Delete single App Screenshot
  Future<void> deleteSingleAppScreenshot(
      User user, App app, String screenshot) async {
    try {
      var ref = _storage
          .ref()
          .child('users')
          .child(user.id!)
          .child('previews')
          .child(app.id!)
          .child(screenshot);

      await ref.delete();

      await _firestore
          .collection('users')
          .doc(user.id)
          .collection('previews')
          .doc(app.id)
          .update({
        'appScreenshots': FieldValue.arrayRemove([screenshot])
      });
    } catch (e) {
      throw Exception('Error deleting app screenshot');
    }
  }
}
