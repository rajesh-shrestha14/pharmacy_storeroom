import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final String title;
  //this function sets value in the main widget
  final Function setDate;
  const DateTimePicker({@required this.setDate, Key key, this.title})
      : super(key: key);
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  //this is for display screen
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2050));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        widget.setDate(picked);
      });
    }
  }

  @override
  void initState() {
    selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.grey[400]),
      ),
      child: ListTile(
        onTap: () => _selectDate(context),
        leading: Icon(Icons.calendar_today, color: Colors.grey[400]),
        title: Text(
            '${widget.title}\n${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
      ),
    );
  }
}
