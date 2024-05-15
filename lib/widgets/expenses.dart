import 'dart:math';

import 'package:expense_tracker/widgets/expenses_list/expense_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
        title: "Test",
        amount: 20.0,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Test",
        amount: 19.0,
        date: DateTime.now(),
        category: Category.food),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final getIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Item Removed"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: "Undo", onPressed: (){
          setState(() {
            _registeredExpense.insert(getIndex, expense);
          });
        },),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) => NewExpense(onAddexpense: _addExpense));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No Expense"),
    );
    setState(() {
      if (_registeredExpense.isNotEmpty) {
        content = ExpenseList(
          registeredExpense: _registeredExpense,
          onRemovedExpense: _removeExpense,
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                _openAddExpenseOverlay();
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: content),
        ],
      ),
    );
  }
}
