import 'package:flutter/material.dart';

class CounterFormField extends FormField<int> {
  CounterFormField(
      {super.key,
      required FormFieldSetter<int> onSaved,
      required FormFieldValidator<int> validator,
      int initialValue = 0,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<int> state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      state.didChange(state.value! - 1);
                    },
                  ),
                  Text(state.value.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      state.didChange(state.value! + 1);
                    },
                  ),
                ],
              );
            });
}
