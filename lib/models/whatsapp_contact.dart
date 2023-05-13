import 'dart:convert';

class WhatsappContact {
  final String id;
  final String phoneNumber;
  final String description;

  const WhatsappContact({
    required this.id,
    required this.phoneNumber,
    required this.description,
  });

  static WhatsappContact fromJson(Map<String, dynamic> json) {
    return WhatsappContact(
      id: json['id'],
      phoneNumber: json['phoneNumber'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'description': description,
    };
  }

  static String listToString(List<WhatsappContact> contacts) {
    final contactJson = contacts.map((e) => e.toJson()).toList();

    return json.encode(contactJson);
  }

  static List<WhatsappContact> stringToList(String contacts) {
    final contactList = json.decode(contacts) as List<dynamic>;

    return contactList.map((json) => WhatsappContact.fromJson(json)).toList();
  }
}
