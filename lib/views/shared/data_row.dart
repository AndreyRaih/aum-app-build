import 'package:aum_app_build/views/shared/typo.dart';
import 'package:flutter/widgets.dart';

class AumDataRow extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  AumDataRow({@required this.data});

  Widget _makeItem({String label, String value}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AumText.regular(
        label,
        size: 14,
      ),
      Padding(padding: EdgeInsets.only(top: TINY_OFFSET), child: AumText.bold(value, size: 14))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _shortInfo = data.map((item) => _makeItem(label: item["label"], value: item["value"])).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _shortInfo,
    );
  }
}
