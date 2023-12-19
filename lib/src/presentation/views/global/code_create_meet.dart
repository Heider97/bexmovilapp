import 'package:flutter/material.dart';
import 'package:bexmovil/src/presentation/blocs/google_account/google_account_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/requests/event.dart';


class CodeCreateMeet extends StatefulWidget {

  final Eventos? event;

  const CodeCreateMeet({super.key, this.event});

  @override
  State<CodeCreateMeet> createState() => _CodeCreateMeetState();
}

class _CodeCreateMeetState extends State<CodeCreateMeet> {

  late GoogleAccountBloc googleaccountbloc;

  final formkey = GlobalKey<FormState>();
   GoogleAccountBloc calendarClient = GoogleAccountBloc();

  late DateTime fromDate;
  late DateTime toDate;

  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    googleaccountbloc = BlocProvider.of<GoogleAccountBloc>(context);

    if (widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
         title: const Text('Nueva reunion'),
         leading: const CloseButton(),
         actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent
            ),
            onPressed: saveForm, 
            icon: const Icon(Icons.done), 
            label: const Text('Guardar')
          )
         ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: const TextStyle(fontSize: 24),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Agregue titulo'
                ),
                onFieldSubmitted: (_) => saveForm(),
                validator: (title) => 
                    title!= null && title.isEmpty ? 'El titulo no puede estar vacio' : null,
                controller: titleController,
              ),
              const SizedBox(height: 12,),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('From', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(GoogleAccountBloc.toDate(fromDate)),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: (){
                        pickFromDateTime(pickDate: true);
                      },
                    )
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(GoogleAccountBloc.toTime(fromDate)),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: (){
                        setState(() {
                          pickFromDateTime(pickDate: false);
                        });
                      },
                    )
                  )
                ],
              ),

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To', style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(GoogleAccountBloc.toDate(toDate)),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: () { 
                        pickToDateTime(pickDate: true);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(GoogleAccountBloc.toTime(fromDate)),
                      trailing: const Icon(Icons.arrow_drop_down),
                      onTap: (){
                        setState(() {
                          pickToDateTime(pickDate: false);
                        });
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      
    );
  }
  Future pickFromDateTime({required bool pickDate})async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    setState(()=> fromDate = date);
  }

  Future pickToDateTime({required bool pickDate})async {
    final date = await pickDateTime(
      toDate, 
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null
    );
    if (date == null) return;

    setState(()=> toDate = date);
  }

  Future saveForm() async {
    final isValid = formkey.currentState!.validate();

    if(isValid){
      final event = Eventos(
        title: titleController.text,
        description: 'Description',
        from: fromDate,
        to: toDate,
        isAllDay: false
      );

      final isEditing = widget.event != null;
      final google = BlocProvider.of<GoogleAccountBloc>(context, listen: false);

      if(isEditing){
        google.editEvent(event, widget.event!);
      } else {
        google.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }

  Future<DateTime?> pickDateTime(
      DateTime initialDate, {
      required bool pickDate,
      DateTime? firstDate,
    }) async{
      if (pickDate) {
        final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101)
        );
        if (date == null) return null; 

        final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);

        return date.add(time);
      } else {
        final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate)
        );
        if (timeOfDay == null) return null;

        final date = DateTime(initialDate.year, initialDate.month, initialDate.day);
        final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

        return date.add(time); 
      }
    }
}