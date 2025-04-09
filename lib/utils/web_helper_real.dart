import 'dart:convert';
import 'dart:html' as html;

void downloadMarkdownWeb(String content) {
  final bytes = utf8.encode(content);
  final blob = html.Blob([bytes]);
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor =
      html.AnchorElement(href: url)
        ..setAttribute("download", "note.md")
        ..click();
  html.Url.revokeObjectUrl(url);
}
