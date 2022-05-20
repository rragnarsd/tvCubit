import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchWidget extends StatefulWidget {
  final String query;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.query,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 45,
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Color(0xff59524F),
            ),
          ),
          suffixIcon: widget.query.isNotEmpty
              ? const SizedBox.shrink()
              : GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: FaIcon(
                      FontAwesomeIcons.xmark,
                      color: Color(0xff59524F),
                    ),
                  ),
                  onTap: () {
                    _searchController.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff59524F),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xff59524F),
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          hintText: 'Search',
        ),
        onChanged: (value) {},
      ),
    );
  }
}
