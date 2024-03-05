import 'package:bexmovil/src/utils/constants/gaps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//domain
import '../../../../../domain/models/filter.dart';
import '../../../../../domain/models/option.dart';
import '../../../../widgets/atomsbox.dart';

class FilterFeatureSalePage extends StatelessWidget {
  final Filter filter;

  const FilterFeatureSalePage({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return FilterFeature(filter: filter);
  }
}

class FilterFeature extends StatelessWidget {
  final Filter filter;
  const FilterFeature({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return AppListTile(
        title: AppText(filter.name!),
        subtitle: Wrap(
          runSpacing: 10.0,
          spacing: 10.0,
          children: List<Option>.from(filter.options!).map((option) {
            if (option.type == 'button') {
              return FilterOptionButton(option: option);
            } else if (option.type == 'text') {
              return FilterOptionText(option: option);
            } else if (option.type == 'formfield') {
              return FilterOptionFormField(option: option);
            } else {
              return const SizedBox();
            }
          }).toList(),
        ));
  }
}

class FilterOptionButton extends StatelessWidget {
  final Option option;

  const FilterOptionButton({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(onPressed: () {}, child: AppText(option.name!));
  }
}

class FilterOptionText extends StatelessWidget {
  final Option option;

  const FilterOptionText({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return AppText(option.name!);
  }
}

class FilterOptionFormField extends StatelessWidget {
  final Option option;

  const FilterOptionFormField({super.key, required this.option});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppTextFormField.outlined(
        initialValue: '0',
        labelText: option.name,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        onChanged: (value) {
          //   final number = int.tryParse(value);
          //   if (number != null) {
          //     final text = number.clamp(min, max).toString();
          //     final selection = TextSelection.collapsed(
          //       offset: text.length,
          //     );
          //     textEditingController.value = TextEditingValue(
          //       text: text,
          //       selection: selection,
          //     );
          //   }
        },
      ),
    );
  }
}
