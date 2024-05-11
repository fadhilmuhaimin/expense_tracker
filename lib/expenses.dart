import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(title: "Test", amount: "20.0", date: DateTime.now(), category: Category.food),
    Expense(title: "Test", amount: "20.0", date: DateTime.now(), category: Category.food),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ExpenseItem(registeredExpense: _registeredExpense,),
        ],
      ),
    );
  }
}