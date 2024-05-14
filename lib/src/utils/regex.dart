class RegExHelpers {
  static const name =
      r"^[a-zA-ZÁ-ÿ\u00f1\u00d1]+((['][a-zA-Z ])?[a-zA-ZÁ-ÿ\u00f1\u00d1]*)*$";
  static const passwordBack =
      r'(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&+\-_])[A-Za-z\d@$!%*?&+\-_]{8,}';
  static const password =
      r'^(?=.*\d)(?=.*[\u0021-\u002b\u003c-\u0040-_])(?=.*[A-Z])(?=.*[a-z])\S{8,}$';
  static const email =
      r'^[a-z0-9!#$%&"*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&"*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$';
}
