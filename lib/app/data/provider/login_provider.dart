import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meuscheques/app/data/model/user_model.dart';
import 'package:meuscheques/app/global/constants.dart';
import 'package:meuscheques/app/global/widgets/snacksbar.dart';

class LoginProvider {
  static User? get user => FirebaseAuth.instance.currentUser;
  static late UserModel userModel;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //GetStorage box = GetStorage('login_firebase');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference usuarios =
      FirebaseFirestore.instance.collection(USER_PATH);

  Future<UserModel> _saveUser() async {
    UserModel usuario = UserModel.fromAuthUser(user!, 'nomeUser');
    await usuarios.doc(user!.uid).set(usuario.toJson());
    return usuario;
  }

  Future<void> setSignedUser() async {
    var userDocument = await usuarios.doc(user!.uid).get();
    if (userDocument.exists) {
      userModel =
          UserModel.fromJson(userDocument.data() as Map<String, dynamic>);
    } else {
      userModel = await _saveUser();
    }
  }

  Future<UserModel> getUserInfos(String uid) async {
    var userDocument = await usuarios.doc(uid).get();

    return UserModel.fromDocument(userDocument.data() as Map<String, dynamic>);
  }

  Future<String?> resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email).then((value) {
        return 'Email enviado com sucesso';
      });
    } catch (error) {
      FirebaseAuthException e = error as FirebaseAuthException;
      switch (e.code) {
        case 'user-not-found':
          return 'Email enviado com sucesso';

        case 'invalid-email':
          return 'Email enviado com sucesso';
        default:
          return 'Algo deu errado, tente novamente mais tarde';
      }
    }
    return null;
  }

  // Retorna usuário logado

  // Criar usuário
  Future<String?> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final currentUser = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      await currentUser!.updateDisplayName(name);
      // Atualizando o nome do usuário
      await currentUser.reload();
      return null;
    } catch (error) {
      FirebaseAuthException e = error as FirebaseAuthException;

      switch (e.code) {
        case 'operation-not-allowed':
          return 'Contas anônimas não estão habilitadas';

        case 'invalid-password':
          return 'Sua senha é muito fraca';

        case 'invalid-email':
          return 'Seu email é inválido';

        case 'email-already-in-use':
          return 'O e-mail já está em uso em outra conta';

        case 'invalid-credential':
          return 'Seu email é inválido';

        default:
          return 'Ocorreu um erro indefinido.$e';
      }
    }
  }

  // Fazer Login
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Usuário ou senha incorretos';

        case 'wrong-password':
          return 'Usuário ou senha incorretos';

        case 'operation-not-allowed':
          return 'Este login  não foi permitido.';

        case 'too-many-requests':
          return 'Muitas tentativas de login, tente novamente mais tarde!';

        case 'network-request-failed':
          return 'Verifique sua conexão com a internet e tente novamente.';
        case 'invalid-email':
          return 'Esse email é inválido.';
        default:
          return e.toString();
      }
    }
  }

  sendConfirmationEmail() async {
    try {
      await firebaseAuth.currentUser!.sendEmailVerification();
    } catch (error) {
      var e = error as FirebaseException;
      switch (e.code) {
        case 'too-many-requests':
          warningSnackBar('Atenção',
              'Envio de email desativado devido a altas solicitações de reenvio');
          break;
        default:
          warningSnackBar('Atenção', e.toString());
          break;
      }
    }
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  }
}
