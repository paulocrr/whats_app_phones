import 'package:url_launcher/url_launcher.dart';
import 'package:whats_app_phones/extensions/string_extensions.dart';
import 'package:whats_app_phones/models/whatsapp_contact.dart';

extension WhatsappContactExtension on WhatsappContact {
  void launchWhatAppChat() {
    final url = Uri.parse('https://wa.me/${phoneNumber.formatPhoneNumber}');

    launchUrl(url);
  }

  void launchPhoneCall() {
    final url = Uri.parse('tel:${phoneNumber.formatPhoneNumber}');

    launchUrl(url);
  }
}
