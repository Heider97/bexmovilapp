


// import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_account_event.dart';
part 'google_account_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class GoogleAccountBloc extends Bloc<GoogleAccountEvent, GoogleAccountState>{
  // final DatabaseRepository _databaseRepository;

  GoogleAccountBloc() : super(GoogleAccountInitial()){}
  //esta es la logica, esta en el bloc
  Future<UserCredential> signInWithGoogle()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}