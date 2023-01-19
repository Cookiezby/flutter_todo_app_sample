import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo/constants.dart';
import 'package:todo/features/todo/domain/todo_item/todo_item.dart';

part 'package:todo/features/todo/domain/todo_list/todo_list.freezed.dart';

@freezed
class TodoList with _$TodoList {
  // メソッドを追加する場合はプライベートコンストラクターを定義
  const TodoList._();

  const factory TodoList({
    required List<TodoItem> items,
    @Default(false) bool hasReachedMax,
  }) = _TodoList;

  TodoList fetch(List<TodoItem> todoItemList) {
    // メモがまだ取得できるか(ページングできるか)どうかはここで判断しています。
    // メモの取得個数がページングできる個数に達しなかった場合は、これ以上取得できない状態です。
    final hasReachedMax = todoItemList.length < page;

    return copyWith(
      items: [...items, ...todoItemList],
      hasReachedMax: hasReachedMax,
    );
  }

  TodoList add(TodoItem item) => copyWith(items: [item, ...items]);

  TodoList edit(TodoItem todoItem) {
    // idからリストのindexを調べます。
    final index = items.map((item) => item.id).toList().indexOf(todoItem.id);
    items
      ..removeAt(index)
      ..insert(index, todoItem);

    return copyWith(items: [...items]);
  }
}