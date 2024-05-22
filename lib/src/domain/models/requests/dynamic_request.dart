class DynamicRequest {
  final String table;
  final String content;
  DynamicRequest(this.table, this.content);
}

class DynamicRequestMultitable {
  final List<String> tables;
  DynamicRequestMultitable(
    this.tables,
  );
}
