import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_word_search/screens/widget/toast.dart';
import 'package:flutter_word_search/services/local_storage.dart';

class WordRepository {
  void addHistoryToFirestore(String word) async {
    var storage = await LocalStorageService.getInstance();
    String token = storage.getDataFromDisk("token");
    DocumentReference wordList =
        FirebaseFirestore.instance.collection('history').doc(token);

    wordList.set(
      {
        'words': FieldValue.arrayUnion([word])
      },
      SetOptions(merge: true),
    ).then((value) {
      log('Word added to Firestore: $word');
    }).catchError((error) {
      log('Error adding word to Firestore: $error');
    });
  }

  void addToFavorite(String word) async {
    var storage = await LocalStorageService.getInstance();
    String token = storage.getDataFromDisk("token");
    DocumentReference wordList =
        FirebaseFirestore.instance.collection('favorite').doc(token);

    wordList.set(
      {
        'words': FieldValue.arrayUnion([word])
      },
      SetOptions(merge: true),
    ).then((value) {
      log('Word added to Firestore: $word');
      ToastResp.toastMsgSuccess(resp: "Added to favorite");
    }).catchError((error) {
      log('Error adding word to Firestore: $error');
    });
  }

  Future<void> addWordsToFirestore(List<String> words) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (final word in words) {
        final docRef = FirebaseFirestore.instance.collection('words').doc();
        batch.set(docRef, {
          'word': word,
          // Add additional fields if necessary
        });
      }

      await batch.commit();
      print('Words added to Firestore');
    } catch (e) {
      print('Error adding words to Firestore: $e');
    }
  }

  void removeWordFromFirestore(String word) async {
    var storage = await LocalStorageService.getInstance();
    String token = storage.getDataFromDisk("token");
    DocumentReference wordList =
        FirebaseFirestore.instance.collection('favorite').doc(token);

    wordList.update({
      'words': FieldValue.arrayRemove([word])
    }).then((value) {
      log('Word removed from Firestore: $word');
      ToastResp.toastMsgSuccess(resp: "Remove from favorite");
    }).catchError((error) {
      log('Error removing word from Firestore: $error');
    });
  }
}
