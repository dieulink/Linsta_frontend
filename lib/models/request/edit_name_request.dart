class EditNameRequest {
  final int id;
  final String newName;

  EditNameRequest({required this.id, required this.newName});

  Map<String, dynamic> toJson() => {'id': id, 'newName': newName};
}
