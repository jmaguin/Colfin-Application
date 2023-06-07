import 'package:flutter_finance_app/purchase.dart';
import 'package:intl/intl.dart';

// Test data for various database functions
class DatabaseData {
  DateTime time0 = DateTime.parse('2023-06-01 01:08'),
      time1 = DateTime.parse('2023-06-01 11:41'),
      time2 = DateTime.parse('2023-06-02 09:00'),
      time3 = DateTime.parse('2023-06-03 04:49'),
      time4 = DateTime.parse('2023-06-04 09:03'),
      time5 = DateTime.parse('2023-06-04 12:51'),
      time6 = DateTime.parse('2023-06-05 07:16'),
      time7 = DateTime.parse('2023-06-06 06:33'),
      time8 = DateTime.parse('2023-06-06 15:05');

  List<Purchase> data = <Purchase>[];

  DatabaseData() {
    data = <Purchase>[
      Purchase(
          id: 0,
          name: "Burger",
          price: 8.99,
          category: "Food",
          createdAt: time1.millisecondsSinceEpoch,
          year: time0.year,
          month: time0.month,
          day: time0.day,
          weekday: DateFormat('EEEE').format(time0)),
      Purchase(
          id: 1,
          name: "Fries",
          price: 3.99,
          category: "Food",
          createdAt: time1.millisecondsSinceEpoch,
          year: time1.year,
          month: time1.month,
          day: time1.day,
          weekday: DateFormat('EEEE').format(time1)),
      Purchase(
          id: 2,
          name: "Pizza",
          price: 7.50,
          category: "Food",
          createdAt: time2.millisecondsSinceEpoch,
          year: time2.year,
          month: time2.month,
          day: time2.day,
          weekday: DateFormat('EEEE').format(time2)),
      Purchase(
          id: 3,
          name: "Sushi",
          price: 14.99,
          category: "Food",
          createdAt: time3.millisecondsSinceEpoch,
          year: time3.year,
          month: time3.month,
          day: time3.day,
          weekday: DateFormat('EEEE').format(time3)),
      Purchase(
          id: 4,
          name: "Salad",
          price: 8.00,
          category: "Food",
          createdAt: time4.millisecondsSinceEpoch,
          year: time4.year,
          month: time4.month,
          day: time4.day,
          weekday: DateFormat('EEEE').format(time4)),
      Purchase(
          id: 5,
          name: "Sandwich",
          price: 9.20,
          category: "Food",
          createdAt: time5.millisecondsSinceEpoch,
          year: time5.year,
          month: time5.month,
          day: time5.day,
          weekday: DateFormat('EEEE').format(time5)),
      Purchase(
          id: 6,
          name: "Burrito",
          price: 11.60,
          category: "Food",
          createdAt: time6.millisecondsSinceEpoch,
          year: time6.year,
          month: time6.month,
          day: time6.day,
          weekday: DateFormat('EEEE').format(time6)),
      Purchase(
          id: 7,
          name: "Pancakes",
          price: 7.99,
          category: "Food",
          createdAt: time7.millisecondsSinceEpoch,
          year: time7.year,
          month: time7.month,
          day: time7.day,
          weekday: DateFormat('EEEE').format(time7)),
      Purchase(
          id: 8,
          name: "Pizza",
          price: 8.99,
          category: "Food",
          createdAt: time8.millisecondsSinceEpoch,
          year: time8.year,
          month: time8.month,
          day: time8.day,
          weekday: DateFormat('EEEE').format(time8)),
    ];
  }
}
