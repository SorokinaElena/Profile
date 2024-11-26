import 'package:flutter/material.dart';


class SiteLinkItem extends StatefulWidget {
  const SiteLinkItem({
    super.key,
    required this.index,
    /* required this.siteNameController,
    required this.siteLinkController, */
    required this.onSaveSiteName,
    required this.onSaveSiteLink,
    required this.onDeleteLink,
    required this.regex,
  });

  final int index;
  /* final TextEditingController siteNameController;
  final TextEditingController siteLinkController; */
  /* final void Function(int index) onSaveSiteName;
  final void Function(int index) onSaveSiteLink; */
  final void Function(int index, String value) onSaveSiteName;
  final void Function(int index, String value) onSaveSiteLink;
  final void Function(int index) onDeleteLink;
  final RegExp regex;

  @override
  State<SiteLinkItem> createState() {
    return _SiteLinkItemState();
  }
}

class _SiteLinkItemState extends State<SiteLinkItem> {

  final TextEditingController _siteNameController = TextEditingController();
  final TextEditingController _siteLinkController = TextEditingController();

  /* bool isValidUrl(String url) {
    final Uri? uri = Uri.tryParse(url);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  } */

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
            //controller: widget.siteNameController,
            controller: _siteNameController,
            // focusNode: _focusNodeSiteName,
            //maxLength: 50,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
              hintText: 'Site name',
            ),
            /* validator: (value) {
              if (value != '') {
                if (value!.trim().length < 2 || value.trim().length > 50) {
                  return 'Site name must be between 2 and 50 characters';
                } else if (widget.regex.hasMatch(value)) {
                  return 'Only letters and spaces';
                }
              }
              return null;
            }, */
            onSaved: (value) {
                      if (value != null) {
                        widget.onSaveSiteName(widget.index, value);
                        //_currentUser.links[0]['siteName'] = value;
                      }
                    },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            //controller: widget.siteLinkController,
            controller: _siteLinkController,
            //focusNode: _focusNodeSiteLink,
            //maxLength: 200,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                ),
              ),
              hintText: 'Link',
            ),
            /*               validator: (value) {
              final trimValue = value!.trim();
              if (trimValue != '') {
                final checkedLink = isValidUrl(trimValue);
                if (checkedLink) {
                  if (trimValue.length < 8 || trimValue.length > 200) {
                    return 'Link must be no longer then 200 characters';
                  }
                  return null;
                } else {
                  return 'Invalid Link';
                }
              }
              return null;
            }, */
            onSaved: (value) {
                      if (value != null) {
                        widget.onSaveSiteLink(widget.index, value);
                        //_currentUser.links[0]['siteLink'] = value;
                      }
                    },
          ),
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
