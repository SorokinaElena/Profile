import 'package:flutter/material.dart';

class SiteLinkItem extends StatefulWidget {
  const SiteLinkItem({
    super.key,
    required this.index,
    required this.onSaveSiteName,
    required this.onSaveSiteLink,
    required this.onDeleteLink,
    required this.regex,
    required this.savedSiteName,
    required this.savedSiteLink,
  });

  final int index;
  final void Function(int index, String value) onSaveSiteName;
  final void Function(int index, String value) onSaveSiteLink;
  final void Function(int index) onDeleteLink;
  final RegExp regex;
  final String savedSiteName;
  final String savedSiteLink;

  @override
  State<SiteLinkItem> createState() {
    return _SiteLinkItemState();
  }
}

class _SiteLinkItemState extends State<SiteLinkItem> {

  late final TextEditingController _siteNameController = TextEditingController(text: widget.savedSiteName);
  late final TextEditingController _siteLinkController = TextEditingController(text: widget.savedSiteLink);

  bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  void dispose() {
    _siteNameController.dispose();
    _siteLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _siteNameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
              hintText: 'Site name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'empty field';
              } else if (value != '') {
                if (value.trim().length < 2 || value.trim().length > 50) {
                  return 'no nolger 50 char';
                } else if (!widget.regex.hasMatch(value)) {
                  return 'letters and spaces';
                }
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                widget.onSaveSiteName(widget.index, value);
              }
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: TextFormField(
            controller: _siteLinkController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
              hintText: 'Link',
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value == '') {
                return 'empty field';
              } else {
                final trimValue = value.trim();
                final isValidLink = isValidUrl(trimValue);
                if (isValidLink) {
                  if (trimValue.length < 8 || trimValue.length > 200) {
                    return 'no longer 200 char';
                  }
                  return null;
                } else {
                  return 'Invalid Link';
                }
              }
            },
            onSaved: (value) {
              if (value != null) {
                widget.onSaveSiteLink(widget.index, value);
              }
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        IconButton(
          color: const Color.fromARGB(255, 28, 27, 31),
          iconSize: 32,
          onPressed: () => widget.onDeleteLink(widget.index),
          icon: const Icon(Icons.delete_forever_sharp),
        ),
      ],
    );
  }
}
