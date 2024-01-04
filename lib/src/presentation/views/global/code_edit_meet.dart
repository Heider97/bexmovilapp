// import 'package:flutter/material.dart';

// import '../../../domain/models/requests/event.dart';


// class CodeEditMeet extends StatefulWidget {

//   final Eventos event;

//   const CodeEditMeet({required this.event, super.key});

//   @override
//   State<CodeEditMeet> createState() => _CodeEditMeetState();
// }

// class _CodeEditMeetState extends State<CodeEditMeet> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: CloseButton(),
    
//       ),
//       body: ListView(
//         padding: EdgeInsets.all(32),
//         children: [
//           buildDateTime(widget.event),
//           SizedBox(height: 32,),
//           Text(
//             widget.event.title,
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 24,),

//           Text(
//             widget.event.description,
//             style: TextStyle(color: Colors.white, fontSize: 18),
//           )
//         ],
//       ),
//     );
//   }
//   Widget buildDateTime(Eventos event){
//     return Column(
//       children: [
//         buildDate(event.isAllDay ? 'All-day':'From', event.from),
//         if(!event.isAllDay) buildDate('To', event.to),
//       ],
//     );
//   }

//   Widget buildDate(String title, DateTime date){
//     return ;
//   }
// }