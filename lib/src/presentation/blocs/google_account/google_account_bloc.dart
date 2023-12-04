


// ignore_for_file: avoid_print, unrelated_type_equality_checks

// import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'dart:developer';
import 'dart:io';

import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/network/network_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/calendar/index.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import "package:googleapis_auth/auth_io.dart";

part 'google_account_event.dart';
part 'google_account_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class GoogleAccountBloc extends Bloc<GoogleAccountEvent, GoogleAccountState>{

  static const scopes = [CalendarApi.calendarScope];
  Event event = Event();

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

  Future<void> createID() async {
    var credentials;
    if(Platform.isAndroid){
      credentials =  ClientId(
        '509826364584-aurod6st47hiekgdo2agg0tfnep4q40t.apps.googleusercontent.com',
        ""
      );
    } else if (Platform.isIOS){
      credentials =  ClientId(
        'YOUR_CLIENT_ID_FOR_IOS_APP_RETRIEVED_FROM_Google_Console_Project_EARLIER',
        ""
      );
    }
  }

  //calendar event 1
  Future<void> createEvents(title, startTime, endTime) async {
    var clientID =  ClientId("YOUR_CLIENT_ID", "");
    clientViaUserConsent(clientID, scopes, prompt).then((AuthClient client){
       var calendar = CalendarApi(client);
       calendar.calendarList.list().then((value) => print("VAL________$value"));

       String calendarId = "primary";
       Event event = Event(); //create object of event

       event.summary = title;

      EventDateTime start =  EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+05:00";
      event.start = start;

      EventDateTime end =  EventDateTime();
      end.timeZone = "GMT+05:00";
      end.dateTime = endTime;
      event.end = end;

      //insertEvent
      try{
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if(value.status == "confirmed"){
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      } catch (e) {
        log('Error Error creating event $e');
      }
    });
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");

    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

    List <Meeting> meetings = [
    Meeting('Confernece 1', DateTime.now(), DateTime.now().add(const Duration(hours: 2)),
    const Color(0xFF0F8644), false),
    Meeting('Confernece 2', DateTime.now(), DateTime.now().add(const Duration(hours: 2)),
    const Color(0xFF0F8644), false),
    Meeting('Confernece 3', DateTime.now(), DateTime.now().add(const Duration(hours: 2)),
    const Color(0xFF0F8644), false),
  ];

  //addmeeting
  void addMeeting(){
    meetings.add(
      Meeting('Confernece 5', DateTime.now(), DateTime.now().add(const Duration(hours: 2)),
      const Color(0xFF0F8644), false),
    );
    NetworkNotify();
  }

  //editar evento
  void editMeeting(int index){
    meetings[index].eventName = 'Con $index $index';
    NetworkNotify();
  }

  //actualizar un evento
  void updateEvent(){
    Meeting updateMeeting = Meeting(
      'Nueva Reunion', 
      DateTime.now(), 
      DateTime.now().add(const Duration(hours: 2)),
      const Color(0xFF0F8644), 
      false
    );

    int index = meetings.indexWhere((meeting) => 
      meeting == 'reunion de trabajo' &&
      meeting == DateTime.now());
    if(index != -1){
      meetings[index] = updateMeeting;
    }
    NetworkNotify();
  }

  //eliminar evento
  void deleteEvent() {
    int index = meetings.indexWhere((meeting) => 
      meeting == 'reunion de trabajo' &&
      meeting == DateTime.now());

    if(index != -1){
      meetings.removeAt(index);
    }
    NetworkNotify();
  }
}