import 'package:bexmovil/src/data/datasources/local/app_database.dart';
import 'package:bexmovil/src/presentation/cubits/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

//cubit
import '../../blocs/network/network_bloc.dart';
import '../../cubits/login/login_cubit.dart';

//utils
import '../../../utils/constants/strings.dart';
import '../../../utils/constants/gaps.dart';
import '../../../utils/constants/strings.dart';

//widgets
import '../../widgets/global/custom_elevated_button.dart';
import '../../widgets/global/custom_textformfield.dart';

//services
import '../../../locator.dart';
import '../../../services/storage.dart';

part '../../widgets/global/form_login.dart';

final LocalStorageService _storageService = locator<LocalStorageService>();

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  late LoginCubit loginCubit;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    rememberSession();
    super.initState();
  }

  void rememberSession() {
    var usernameStorage = _storageService.getString('username');
    var passwordStorage = _storageService.getString('password');

    if (usernameStorage != null) {
      setState(() {
        usernameController.text = usernameStorage;
      });
    }

    if (passwordStorage != null) {
      setState(() {
        passwordController.text = passwordStorage;
      });
    }
  }

  bool obscureText = true;

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  //TODO [Sebastian Monroy] add back button to company and onPress function call loginCubit goToCompany method
  @override
  Widget build(BuildContext context) {
    loginCubit = BlocProvider.of<LoginCubit>(context);

    final Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) => buildBlocConsumer(size, theme),
    );
  }

  Widget buildBlocConsumer(Size size, ThemeData theme) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: buildBlocListener,
      builder: (context, state) {
        return _buildBody(size, theme, state);
      },
    );
  }

  void buildBlocListener(context, state) {
    if (state is LoginSuccess || state is LoginFailed) {
      if (state.error != null) {
        buildSnackBar(context, state.error!);
      } else {
        loginCubit.goToHome();
      }
    }
  }

  Widget _buildBody(Size size, ThemeData theme, LoginState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          fit: BoxFit.contain,
          width: double.infinity,
          height: 100.0,
          imageUrl: state.enterprise != null && state.enterprise!.logo != null
              ? 'https://${state.enterprise!.name}.bexmovil.com/img/enterprise/${state.enterprise!.logo}'
              : '',
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        gapH64,
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: Const.space25,
                  left: Const.space25,
                  right: Const.space25),
              child: CustomTextFormField(
                  controller: usernameController, hintText: 'Usuario o correo'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: Const.space25, right: Const.space25),
              child: CustomTextFormField(
                controller: passwordController,
                obscureText: obscureText,
                hintText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: theme.primaryColor),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
          ],
        ),
        gapH64,
        Column(
          children: [
            GestureDetector(
                onTap: () => loginCubit.goToCompany(),
                child: const Text('Desear Cambiar de empresa?')),
            gapH24,
            TextButton(
                onPressed: () {
                  DatabaseHelper test = DatabaseHelper();
                  test.getDataBase(
                      onUpdate:
                          r'''PRAGMA journal_mode = MEMORY;\r\nPRAGMA synchronous = OFF;\r\nPRAGMA foreign_keys = OFF;\r\nPRAGMA ignore_check_constraints = OFF;\r\nPRAGMA auto_vacuum = NONE;\r\nPRAGMA secure_delete = OFF;\r\nBEGIN TRANSACTION;\r\n\r\n\r\nCREATE TABLE IF NOT EXISTS `tblmvendedor` (\r\n`CODVENDEDOR` TEXT NOT NULL DEFAULT '',\r\n`NOMVENDEDOR` TEXT DEFAULT NULL,\r\n`EMAIL` TEXT DEFAULT NULL,\r\n`ESTADOVENDEDOR` TEXT  NOT NULL DEFAULT 'A',\r\n`CONVISVENDEDOR` decimal(10,0) DEFAULT NULL,\r\n`convisotros` decimal(10,0) NOT NULL DEFAULT '1000000',\r\n`clavevendedor` TEXT DEFAULT NULL,\r\n`CODBODEGA` TEXT DEFAULT NULL,\r\n`CODGRUPOEMP` TEXT DEFAULT NULL,\r\n`CODSUPERVISOR` TEXT NOT NULL,\r\n`PORCLOGCUMPVENDEDOR` int DEFAULT NULL,\r\n`CALIFLOGCUMPVENDEDOR` int DEFAULT NULL,\r\n`PORCANTLOGCUMPVENDEDOR` int DEFAULT '0',\r\n`DEVOLVENDEDOR` TEXT  DEFAULT 'S',\r\n`DESCUENVENDEDOR` TEXT  DEFAULT 'N',\r\n`ENV_PORPEDIDO_JAVA` TEXT  DEFAULT 'N',\r\n`CODGRUPODCTO` TEXT DEFAULT '000',\r\n`CONSULTAINVENTARIO` TEXT  DEFAULT 'S',\r\n`JAVAUNOAUNO` TEXT  DEFAULT 'N',\r\n`MAXPEDIDOSJAVA` int DEFAULT NULL,\r\n`EXTRARUTA` TEXT  DEFAULT 'S',\r\n`DESCUENTOSESCALA` TEXT  DEFAULT 'N',\r\n`CONSULTAPRECIOS` TEXT  DEFAULT 'N',\r\n`CODDESCUENTO` TEXT DEFAULT NULL,\r\n`CODPORTAFOLIO` TEXT DEFAULT NULL,\r\n`valminpedido` decimal(10,0) DEFAULT NULL,\r\n`HACEDCTOPIEFACAUT` TEXT  DEFAULT 'S',\r\n`HACEDCTONC` TEXT  DEFAULT 'N',\r\n`CONTROLADCTOS` TEXT  DEFAULT 'N',\r\n`RECAUDOS` TEXT  DEFAULT 'S',\r\n`gps` TEXT  DEFAULT 'S',\r\n`PREVENTA` TEXT  DEFAULT 'N',\r\n`CO` TEXT DEFAULT NULL,\r\n`TIPODOC` TEXT DEFAULT NULL,\r\n`PREFIJO` TEXT DEFAULT NULL,\r\n`RESVENDEDOR` TEXT DEFAULT NULL,\r\n`RANINIVENDEDOR` decimal(10,0) DEFAULT NULL,\r\n`RANFINVENDEDOR` decimal(10,0) DEFAULT NULL,\r\n`FECRESVENDEDOR` datetime DEFAULT NULL,\r\n`MENENC1VENDEDOR` text,\r\n`MENENC2VENDEDOR` text,\r\n`MENENC3VENDEDOR` text,\r\n`MENPIE1VENDEDOR` TEXT DEFAULT NULL,\r\n`MENPIE2VENDEDOR` text,\r\n`MENPIE3VENDEDOR` text,\r\n`TERCVENDEDOR` TEXT DEFAULT NULL,\r\n`CAJA` TEXT DEFAULT NULL,\r\n`pais` TEXT DEFAULT NULL,\r\n`departamento` TEXT DEFAULT NULL,\r\n`ciudad` TEXT DEFAULT NULL,\r\n`barrio` TEXT DEFAULT NULL,\r\n`VERNC` TEXT  DEFAULT 'N',\r\n`INVENTARIOENLINEA` TEXT  NOT NULL DEFAULT 'N',\r\n`MULTIBODEGA` TEXT  DEFAULT 'N',\r\n`DCTOERP` TEXT  NOT NULL DEFAULT 'S1E',\r\n`HACEINVENTARIOS` TEXT  NOT NULL DEFAULT 'N',\r\n`RUTEROAUTOMATICO` TEXT  NOT NULL DEFAULT 'N',\r\n`emailcertificadook` TEXT  NOT NULL DEFAULT 'N',\r\n`omnikanal` TEXT  NOT NULL DEFAULT 'S',\r\n`mensajeadic` TEXT  NOT NULL DEFAULT 'N',\r\n`CAMBIAPRECIO` TEXT  NOT NULL DEFAULT 'N',\r\n`capturacajas` TEXT  NOT NULL DEFAULT 'S',\r\n`capturadirentrega` TEXT  NOT NULL DEFAULT 'N',\r\n`tipoentrega` TEXT  NOT NULL DEFAULT 'N',\r\n`chequespostfechados` TEXT  NOT NULL DEFAULT 'S',\r\n`talonario` TEXT  NOT NULL DEFAULT 'N',\r\n`creaclienteav` TEXT  NOT NULL DEFAULT 'N',\r\n`solser` TEXT  NOT NULL DEFAULT 'N',\r\n`adjuntopedido` TEXT  NOT NULL DEFAULT 'N',\r\n`ccostos` TEXT DEFAULT NULL,\r\n`idcampaprobadores` double NOT NULL,\r\n`emailaprobadorb2b` TEXT DEFAULT NULL,\r\n`cambiapreomniknalgm1` TEXT  NOT NULL DEFAULT 'S',\r\n`moddctoprecio` TEXT  NOT NULL DEFAULT 'N',\r\n`stockceroautoventa` TEXT  NOT NULL DEFAULT 'N',\r\n`devolvermayor` TEXT  NOT NULL DEFAULT 'N',\r\n`cedula` TEXT DEFAULT '',\r\n`devoafectastock` TEXT  NOT NULL DEFAULT 'S',\r\n`emailfacturacion` TEXT DEFAULT NULL,\r\n`tipodocnc` TEXT DEFAULT '',\r\n`syncahora` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',\r\n`codbodegaalt` TEXT DEFAULT NULL,\r\n`coalt` TEXT DEFAULT NULL,\r\n`carteraunificada` TEXT  NOT NULL DEFAULT 'N',\r\n`razempresaven` TEXT DEFAULT NULL,\r\n`nitempresaven` TEXT DEFAULT NULL,\r\n`tblmvendedor_modulovta` TEXT  NOT NULL DEFAULT 'S',\r\n`haceajustealpeso` TEXT  NOT NULL DEFAULT 'N',\r\n`tomapedido` TEXT  NOT NULL DEFAULT 'S',\r\n`tomapines` TEXT  NOT NULL DEFAULT 'N',\r\n`ctrlainventariopedido` TEXT  NOT NULL DEFAULT 'N',\r\n`liquidacomisiones` TEXT  NOT NULL DEFAULT 'N',\r\n`cargue` TEXT DEFAULT NULL,\r\n`desctipodoc` TEXT DEFAULT NULL,\r\n`valida_udid` TEXT  NOT NULL DEFAULT 'N',\r\n`udid` TEXT NOT NULL DEFAULT '',\r\n`os` TEXT NOT NULL DEFAULT '',\r\n`apruebapines` TEXT  NOT NULL DEFAULT 'N',\r\n`codcanal` double NOT NULL DEFAULT '1',\r\n`emailaprobadorpines` TEXT DEFAULT NULL,\r\n`preguntaobsequio` TEXT  NOT NULL DEFAULT 'N',\r\n`tipovendedor` TEXT  NOT NULL DEFAULT 'vendedor',\r\n`ruterointeligente` TEXT  NOT NULL DEFAULT 'N',\r\n`bodegafija` TEXT  NOT NULL DEFAULT 'N',\r\n`usanocomercliente` TEXT  NOT NULL DEFAULT 'N',\r\n`fletesimple` TEXT  NOT NULL DEFAULT 'N',\r\n`fecentllena` TEXT  NOT NULL DEFAULT 'S',\r\n`obliga_bextramites` TEXT  NOT NULL DEFAULT 'N',\r\n`codvendedor_alt` TEXT NOT NULL DEFAULT '',\r\n`recaudo_reteciones` TEXT  NOT NULL DEFAULT 'N',\r\n`tipofactura` TEXT  NOT NULL DEFAULT 'N',\r\n`encmensajepdf` text,\r\n`centroopnom` TEXT DEFAULT NULL,\r\n`rtefteica` TEXT  NOT NULL DEFAULT 'N',\r\n`sidctofinanciero` TEXT  NOT NULL DEFAULT 'N',\r\n`created_by_id` int DEFAULT NULL,\r\n`created_at` timestamp NULL DEFAULT NULL,\r\n`updated_at` timestamp NULL DEFAULT NULL,\r\n`deleted_at` timestamp NULL DEFAULT NULL,\r\nPRIMARY KEY (`CODVENDEDOR`),\r\nFOREIGN KEY (`CODBODEGA`) REFERENCES `tblmbodega` (`CODBODEGA`),\r\nFOREIGN KEY (`CODGRUPOEMP`) REFERENCES `tblmgrupoemp` (`CODGRUPOEMP`),\r\nFOREIGN KEY (`CODSUPERVISOR`) REFERENCES `tblmsupervisor` (`CODSUPERVISOR`),\r\nFOREIGN KEY (`CODGRUPODCTO`) REFERENCES `tblmgrupodcto` (`CODGRUPODCTO`),\r\nFOREIGN KEY (`CODDESCUENTO`) REFERENCES `tblmdescuento` (`coddescuento`),\r\nFOREIGN KEY (`CODPORTAFOLIO`) REFERENCES `tblmportafolio` (`CODPORTAFOLIO`)\r\n);\r\n\r\n\r\n\r\nCREATE INDEX `tblmvendedor_CODBODEGA` ON `tblmvendedor` (`CODBODEGA`);\r\nCREATE INDEX `tblmvendedor_CODGRUPOEMP` ON `tblmvendedor` (`CODGRUPOEMP`);\r\nCREATE INDEX `tblmvendedor_CODSUPERVISOR` ON `tblmvendedor` (`CODSUPERVISOR`);\r\nCREATE INDEX `tblmvendedor_CODGRUPODCTO` ON `tblmvendedor` (`CODGRUPODCTO`);\r\nCREATE INDEX `tblmvendedor_CODDESCUENTO` ON `tblmvendedor` (`CODDESCUENTO`);\r\nCREATE INDEX `tblmvendedor_CODPORTAFOLIO` ON `tblmvendedor` (`CODPORTAFOLIO`);\r\nCREATE INDEX `tblmvendedor_estadoven` ON `tblmvendedor` (`ESTADOVENDEDOR`);\r\nCREATE INDEX `tblmvendedor_tercvendedor` ON `tblmvendedor` (`TERCVENDEDOR`);\r\nCREATE INDEX `tblmvendedor_nomvendedor` ON `tblmvendedor` (`NOMVENDEDOR`);\r\nCREATE INDEX `tblmvendedor_preventa` ON `tblmvendedor` (`PREVENTA`);\r\n\r\nCOMMIT;\r\nPRAGMA ignore_check_constraints = ON;\r\nPRAGMA foreign_keys = ON;\r\nPRAGMA journal_mode = WAL;\r\nPRAGMA synchronous = NORMAL;''',
                      version: 6);
                },
                child: const Text('tesst ScriptDatabase')),
            gapH24,
            BlocSelector<LoginCubit, LoginState, bool>(
                selector: (state) => state is LoginLoading ? true : false,
                builder: (context, booleanState) {
                  return CustomElevatedButton(
                    width: 150,
                    height: 50,
                    onTap: () => booleanState
                        ? null
                        : loginCubit.onPressedLogin(
                            usernameController, passwordController),
                    child: booleanState
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : Text(
                            'Iniciar',
                            style: theme.textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  );
                })
          ],
        ),
        gapH64,
        GestureDetector(
            onTap: () => loginCubit.goToCompany(),
            child: const Text('Olvidaste tu contraseña?')),
      ],
    );
  }
}
