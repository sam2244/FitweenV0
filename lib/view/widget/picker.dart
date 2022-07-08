import 'package:dropdown_search/dropdown_search.dart';
import 'package:fitween1/global/config/theme.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:flutter/material.dart';

class FWDropdownSearch extends StatelessWidget {
  const FWDropdownSearch({
    Key? key,
    this.enable = true,
    this.hintText = '',
    required this.item,
    this.selectedItem,
    required this.onChanged,
    this.search = false,
  }) : super(key: key);

  final bool enable;
  final String hintText;
  final List<String>? item;
  final String? selectedItem;
  final Function(String) onChanged;
  final bool search;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: item ?? [],
      selectedItem: selectedItem,
      enabled: enable,
      onChanged: (value) => onChanged(value ?? ''),
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: const Icon(Icons.expand_more),
          hintStyle: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      dropdownBuilder: (context, value) {
        return FWText(
          value ?? hintText,
          overflow: true,
          style: Theme.of(context).textTheme.labelLarge,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
      },
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        showSearchBox: search,
        listViewProps: const ListViewProps(itemExtent: 48.0),
        menuProps: MenuProps(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          animationDuration: Duration.zero,
          textStyle: Theme.of(context).textTheme.labelLarge,
          shadowColor: Theme.of(context).colorScheme.shadow,
        ),
        itemBuilder: (context, value, _) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 15.0),
            selected: value == selectedItem,
            tileColor: FWTheme.surface[1],
            selectedTileColor: Color.alphaBlend(
              Theme.of(context).colorScheme.onSurface.withOpacity(.12),
              FWTheme.surface[1]!,
            ),
            title: FWText(
              value,
              style: Theme.of(context).textTheme.labelLarge,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          );
        },
        searchFieldProps: TextFieldProps(
          style: Theme.of(context).textTheme.labelLarge,
          // padding: EdgeInsets.zero,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            contentPadding: const EdgeInsets.only(left: 10.0),
            hintText: '검색',
            hintStyle: Theme.of(context).textTheme.labelLarge?.apply(
              color: Theme.of(context).colorScheme.outline,
            ),
            // fillColor: FWTheme.surface[1],
          ),
        ),
        emptyBuilder: (context, searchEntry) {
          return Center(
            child: FWText('$searchEntry 검색결과가 없습니다.',
              style: Theme.of(context).textTheme.labelLarge,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
        },
      ),
    );
  }
}
