import 'package:miapp/core/utils/validators.dart';
import 'package:rxdart/rxdart.dart';

class RegisterUseBloc with Validators {
  final _nombresController = BehaviorSubject<String>();
  final _apellidosController = BehaviorSubject<String>();
  final _telefonoController = BehaviorSubject<String>();
  final _direccionController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _repasswordController = BehaviorSubject<String>();
  final _passwordActualController = BehaviorSubject<String>();

  final _codigoInvitacionController = BehaviorSubject<String>();

  ///Data Comercial
  final _nombreComercialController = BehaviorSubject<String>();
  final _cedulaController = BehaviorSubject<String>();
  final _categoriaController = BehaviorSubject<String>();
  final _pinRecoveryController = BehaviorSubject<String>();

  String? ultimoContenido;

  // Recuperar los datos del Stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);

  Stream<String> get nombresStream =>
      _nombresController.stream.transform(validarNombres);
  Stream<String> get apellidosStream =>
      _apellidosController.stream.transform(validarApellidos);

  Stream<String> get telefonoStream =>
      _telefonoController.transform(validarTelefono);

  Stream<String> get codigoInvitacionStream =>
      _codigoInvitacionController.stream;

  Stream<String> get passwordActualStream =>
      _passwordActualController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => CombineLatestStream.combine4(
      nombresStream,
      emailStream,
      passwordStream,
      repasswordStream,
      (n, a, p, r) => true);

  Stream<bool> get formValidEditClientStream => CombineLatestStream.combine2(
      nombresStream,
      apellidosStream,
      (
        n,
        a,
      ) =>
          true);

  Stream<bool> get formValidPasswordStream => CombineLatestStream.combine2(
      passwordStream,
      repasswordStream,
      (
        n,
        a,
      ) =>
          true);

  Stream<bool> get formValidPasswordChangeStream =>
      CombineLatestStream.combine3(
          passwordStream,
          repasswordStream,
          _passwordActualController,
          (
            p,
            r,
            a,
          ) =>
              true);

  Stream<bool> get formValidRepassword => CombineLatestStream.combine2(
      _passwordController, _repasswordController, (p, r) => true);

  Stream<String> get passwordStream => _passwordController.stream
          .transform(validarPassword)
          .doOnData((notification) {
        if (ultimoContenido != null) {
          changeRePassword(ultimoContenido!);
        }
      });

  Stream<String> get repasswordStream =>
      _repasswordController.stream.transform(validarPassword).doOnData((data) {
        ultimoContenido = data;
        if (0 != _passwordController.value.compareTo(data)) {
          _repasswordController.addError('Contraseñas no coinciden');
        }
      });

  // Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changeNombres => _nombresController.sink.add;
  Function(String) get changeApellidos => _apellidosController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeDireccion => _direccionController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePasswordActual =>
      _passwordActualController.sink.add;

  Function(String) get changeRePassword => _repasswordController.sink.add;
  Function(String) get changenombreComercial =>
      _nombreComercialController.sink.add;

  Function(String) get changeCategoria => _categoriaController.sink.add;

  Function(String) get changeCodigoInvitacion =>
      _codigoInvitacionController.sink.add;
  Function(String) get changePin => _pinRecoveryController.sink.add;

  // Obtener el último valor ingresado a los streams
  String? get email => _emailController.valueOrNull;
  String? get nombres => _nombresController.valueOrNull;
  String? get apellidos => _apellidosController.valueOrNull;
  String? get telefono => _telefonoController.valueOrNull;
  String? get cedula => _cedulaController.valueOrNull;
  String? get direccion => _direccionController.valueOrNull;
  String? get password => _passwordController.valueOrNull;
  String? get repassword => _repasswordController.valueOrNull;
  String? get passwordActual => _passwordActualController.valueOrNull;

  String? get nombreComercial => _nombreComercialController.valueOrNull;
  String? get categoria => _categoriaController.valueOrNull;

  String? get codigoInvitacion => _codigoInvitacionController.valueOrNull;

  Stream<bool> get isValidPin => Rx.combineLatest2(
      _pinRecoveryController, _pinRecoveryController, (a, b) => true);

  String? get pin => _pinRecoveryController.valueOrNull;

  void dispose() {
    _emailController.close();
    _nombresController.close();
    _apellidosController.close();
    _telefonoController.close();
    _cedulaController.close();
    _direccionController.close();
    _passwordController.close();
    _repasswordController.close();
    _nombreComercialController.close();
    _categoriaController.close();
    _codigoInvitacionController.close();
    _pinRecoveryController.close();
    _passwordActualController.close();
  }
}
