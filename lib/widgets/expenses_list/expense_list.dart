import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key,
      required this.registeredExpense,
      required this.onRemovedExpense});

  final List<Expense> registeredExpense;

  final void Function(Expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: registeredExpense.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(registeredExpense[index]),
              background: Container(
                  color: Theme.of(context).colorScheme.error,
                  margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal,vertical: Theme.of(context).cardTheme.margin!.vertical
                  )),
              onDismissed: (direction) =>
                  onRemovedExpense(registeredExpense[index]),
              child: ExpensesItem(
                expense: registeredExpense[index],
              ),
            ));
  }
}
