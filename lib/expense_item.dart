import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem({super.key, required this.registeredExpense});

  final List<Expense> registeredExpense;

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(itemCount: registeredExpense.length,itemBuilder: (ctx,index) => Text(registeredExpense[index].title));
  }
}