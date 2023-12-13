


// ignore_for_file: avoid_print, unrelated_type_equality_checks

// import 'package:bexmovil/src/domain/repositories/database_repository.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bexmovil/src/locator.dart';
import 'package:bexmovil/src/presentation/blocs/network/network_bloc.dart';
import 'package:bexmovil/src/presentation/views/user/calendar/index.dart';
import 'package:bexmovil/src/services/navigation.dart';
import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import "package:googleapis_auth/auth_io.dart";

import '../../../domain/models/requests/event.dart';



part 'google_account_event.dart';
part 'google_account_state.dart';

final NavigationService _navigationService = locator<NavigationService>();

class GoogleAccountBloc extends Bloc<GoogleAccountEvent, GoogleAccountState>{

  static const scopes =  [CalendarApi.calendarScope];

  final List<Eventos> events = [];

  List<Eventos> get eventos => events;
  
  Event event = Event();

  GoogleAccountBloc() : super(GoogleAccountInitial());
  
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

  void addEvent(Eventos event){
    events.add(event);
    NetworkNotify();
  }

  //calendar event 1 with google api
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

  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime){
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime){
    final time = DateFormat.Hm().format(dateTime);

    return '$time';
  }

  void prompt(String url) async {
    print("Vaya a la siguiente URL y conceda acceso:");
    print("  => $url");
    print("");

    if(await canLaunchUrl(Uri.parse(url))){
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  //lista que agrega una nueva reunion de trabajo
  List<Appointment> appointments = <Appointment>[
    Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Reunión de trabajo',
      color: const Color(0xFF0F8644),
      recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=10',
      notes: 'notas'
    ),
  ];

  //plan B crear evento usando el listado appointment
  void createEvent() {
    Appointment newAppointment = Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      subject: 'Nueva reunion',
      
      color: const Color(0xFF0F8644),
    );

    // Agregar el nuevo evento a la lista de eventos
    appointments.add(newAppointment);
    NetworkNotify();
  }

  //editar evento plan b usando el listado appointment
  void editEvent(){
    Appointment editedAppointment = Appointment(
      startTime: DateTime.now(), 
      endTime: DateTime.now().add(const Duration(hours: 2)),
      subject: 'Reunion de trabajo actualizada',
      color: const Color(0xFF0F8644),
    );

    int index = appointments.indexWhere((appointment) => 
      appointment.subject == 'Nueva reunion' &&
      appointment.startTime == DateTime.now());
    if(index != -1) {
      appointments[index] = editedAppointment;
    }
    NetworkNotify();
  }

  //actualizar un evento
  void updateEvent(){
    Appointment updatedAppointment = Appointment(
      startTime: DateTime.now().add(const Duration(days: 1)), 
      endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
      subject: 'Reunion de trabajo actualizada',
      color: const Color(0xFF0F8644),
    );


    //encontrar y reemplazar el evento en la lista de eventos
    int index = appointments.indexWhere((appointment) => 
      appointment.subject == 'Nueva reunion' &&
      appointment.startTime == DateTime.now());
    if(index != -1) {
      appointments[index] = updatedAppointment;
    }
    NetworkNotify();
  }

  //eliminar evento
 void deleteEvent() {
    // Encontrar el índice del evento que deseas eliminar
    int index = appointments.indexWhere((appointment) =>
        appointment.subject == 'Nueva reunion' &&
        appointment.startTime == DateTime.now());

    // Verificar si el evento se encontró
    if (index != -1) {
      // Eliminar el evento de la lista de eventos
      appointments.removeAt(index);
    }
    NetworkNotify();
  }
}