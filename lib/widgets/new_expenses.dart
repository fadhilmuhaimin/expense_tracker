import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddexpense});

  final void Function (Expense expense) onAddexpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedTime;
  Category _selectedCategory = Category.leisure;
  void _openDialogDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final pickedDate =
        await showDatePicker(context: context, firstDate: first, lastDate: now);

    setState(() {
      _selectedTime = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.isEmpty ||
        amountIsValid ||
        _selectedTime == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close"))
                ],
                content: const Text("Please Make sure a valid amount"),
              ));
      return;
    }

    setState(() {
      widget.onAddexpense(Expense(title: _titleController.text, amount:enteredAmount, date: _selectedTime!, category: _selectedCategory));
    });
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text("Amount"), prefixText: '\$'),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedTime == null
                      ? "No Date Selected"
                      : formatter.format(_selectedTime!)),
                  IconButton(
                    onPressed: _openDialogDate,
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((data) => DropdownMenuItem(
                            value: data,
                            child: Text(data.name.toUpperCase()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {_submitExpenseData();},
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple[400]),
                child: const Text("Save Expense"),
              )
            ],
          )
        ],
      ),
    );
  }
}
