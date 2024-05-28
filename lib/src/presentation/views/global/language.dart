import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

//utils
import '../../../utils/constants/nums.dart';
import '../../../utils/constants/gaps.dart';

//cubit
import '../../cubits/language/language_cubit.dart';

//widgets
import '../../widgets/atomsbox.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  LanguageViewState createState() => LanguageViewState();
}

class LanguageViewState extends State<LanguageView> {
  late LanguageCubit languageCubit;

  @override
  void initState() {
    languageCubit = BlocProvider.of<LanguageCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapH24,
                const AppIconText(path: 'assets/svg/language.svg'),
                AppList.vertical(
                    title: AppText('Selecciona un idioma'),
                    description: AppText(
                        'Escoge el idioma con el que te sientas familiarizado'),
                    listItems: [
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'es',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('Spanish'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  SvgPicture.asset('assets/svg/spanish.svg'))),
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'en',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('English'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  SvgPicture.asset('assets/svg/english.svg'))),
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'fr',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('French'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  SvgPicture.asset('assets/svg/french.svg'))),
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'gr',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('German'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  SvgPicture.asset('assets/svg/german.svg'))),
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'br',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('Portuguese'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                                  'assets/svg/portuguese.svg'))),
                      AppListTile(
                          trailing: Radio.adaptive(
                              value: 'rs',
                              groupValue: state.language?.languageCode,
                              onChanged: (code) => languageCubit.selectLang(context, code)),
                          title: AppText('Dutch'),
                          leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset('assets/svg/dutch.svg'))),
                    ]),
                AppElevatedButton(
                  minimumSize: Size(size.width, 50),
                  child: AppText('Continuar', fontSize: 20),
                  onPressed: () =>
                      languageCubit.changeLang(context, state.language!),
                ),
                gapH8
              ],
            ),
          );
        }),
      ),
    ));
  }
}
