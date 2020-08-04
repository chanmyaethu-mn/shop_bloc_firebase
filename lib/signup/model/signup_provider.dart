import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_bloc_firebase/common/constants.dart';
import 'package:shop_bloc_firebase/common/model/user.dart';
import 'package:shop_bloc_firebase/common/provider/base_firestore_provider.dart';

class SignUpProvider extends BaseFireStoreProvider {
  static final SignUpProvider _instance = SignUpProvider._internal();
  factory SignUpProvider() => _instance;
  SignUpProvider._internal();

  Future<DocumentReference> insertUser(User user) async {
    return await db.collection(TBL_USER).add(user.toJson());
  }

  Future<User> getUserByPhoneNumber(String phoneNumber) async {
    final result = await _getUserByPhoneNumber(phoneNumber);

    if (result.documents.length > 0) {
      return Future.value(User.fromMap(result.documents[0], result.documents[0].documentID));
    } else {
      return Future.value(null);
    }
  }

  Future<QuerySnapshot> _getUserByPhoneNumber(String phoneNumber) async {
    return await db
        .collection(TBL_USER)
        .where(COL_PHONE_NUMBER, isEqualTo: phoneNumber)
        .getDocuments();
  }

  Future<dynamic> updateUser(User user) async {
    final QuerySnapshot qs = await _getUserByPhoneNumber(user.phoneNumber);

    if (qs.documents.length > 0) {
      final TransactionHandler updateTransaction = (Transaction tx) async {
        final DocumentSnapshot ds = await tx
            .get(db.collection(TBL_USER).document(qs.documents[0].documentID));

        await tx.update(ds.reference, user.toJson());
        return {UPDATE_STATUS, true};
      };

      return Firestore.instance
          .runTransaction(updateTransaction)
          .then((result) => result[UPDATE_STATUS])
          .catchError((error) {
        return false;
      });
    } else {
      return Future.value(false);
    }
  }

  Future<dynamic> deleteUser(String phoneNumber) async {
    final QuerySnapshot qs = await _getUserByPhoneNumber(phoneNumber);
    if (qs.documents.length > 0) {
      final TransactionHandler deleteTransaction = (Transaction tx) async {
        final DocumentSnapshot ds = await tx
            .get(db.collection(TBL_USER).document(qs.documents[0].documentID));
        await tx.delete(ds.reference);
        return {DELETE_STATUS, true};
      };

      return Firestore.instance
          .runTransaction(deleteTransaction)
          .then((result) => result[DELETE_STATUS])
          .catchError((error) {
        return false;
      });
    } else {
      return Future.value(false);
    }
  }
}
