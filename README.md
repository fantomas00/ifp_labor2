<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Ольховський Максим Олександрович КВ-13</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, які виконують певні дії зі списками, використовуючи різні типи рекурсії (за необхідністю). Функції визначаються варіантом (п. 2.1.1). Вимоги:

1. Має змінюватися через створення нового, а не зміну вхідного.
2. Не використовуйте функції вищого порядку або стандартні функції зі списками (окрім наведених у розділі 4 посібника).
3. Функція не повинна приймати інші функції як аргументи.
4. Не можна використовувати псевдофункції (деструктивний підхід).
5. Не можна використовувати цикли.

Функції потрібно протестувати з різними наборами даних. Тести оформити як модульні (п. 2.3).

## Варіант 12

1. Написати функцію remove-thirds-and-reverse , яка видаляє зі списку кожен третій
елемент і обертає результат у зворотному порядку:
CL-USER> (remove-thirds-and-reverse '(a b c d e f g))
(G E D B A)
2. Написати функцію list-set-difference-3 , яка визначає різницю трьох множин, заданих списками атомів:
CL-USER> (list-set-difference '(1 2 3 4) '(4 5 6) '(2 5 7))
(1 3) ; порядок може відрізнятись

## Лістинг функції remove-thirds-and-reverse

```lisp
(defun remove-thirds-and-reverse (lst &optional (i 1))
    (let ((should-drop (eq (mod i 3) 0)))
        (cond
            ((null lst) nil)
            ((null (cdr lst)) (when (not should-drop) lst))
            (t (if should-drop
                (remove-thirds-and-reverse (cdr lst) (1+ i))
                (append
                    (remove-thirds-and-reverse (cdr lst) (1+ i))
                    (cons (car lst) nil)))))))
```

### Тестові набори

```lisp
(defun test-remove-thirds-and-reverse ()
    (check-remove-thirds-and-reverse "Empty list" '() :expected '())
    (check-remove-thirds-and-reverse "List without threes" '(1 2) :expected '(2 1))
    (check-remove-thirds-and-reverse "List with last element removed" '(1 2 3 4 5 6) :expected '(5 4 2 1))
    (check-remove-thirds-and-reverse "List with last element not removed" '(1 2 3 4 5 6 7) :expected '(7 5 4 2 1)))
```

```lisp
CL-USER> (test-remove-thirds-and-reverse)
passed... Empty list
passed... List without threes
passed... List with last element removed
passed... List with last element not removed

```

## Лістинг функції list-set-difference

```lisp
(defun list-set-difference (s1 s2 s3)
    (let ((el (car s1)))
        (when el
            (if (and (contains-not el s2) (contains-not el s3))
                (cons el (list-set-difference (cdr s1) s2 s3))
                (list-set-difference (cdr s1) s2 s3)))))
```

### Тестові набори

```lisp
(defun test-list-set-difference ()
    (check-list-set-difference "Regular input" '(1 2 3 4 5) '(2 4) '(4 5) :expected '(1 3))
    (check-list-set-difference "All empty" '() '() '() :expected '())
    (check-list-set-difference "Empty subtrahends" '(5 6 7 8) '() '() :expected '(5 6 7 8))
    (check-list-set-difference "All unique" '(9 0 4 5) '(1 2) '(3) :expected '(9 0 4 5))
    (check-list-set-difference "Full subtraction" '(1 2 3 4) '(1 2) '(3 4) :expected '()))
```

### Тестування

```lisp
CL-USER> (test-list-set-difference)
passed... Regular input
passed... All empty
passed... Empty subtrahends
passed... All unique
passed... Full subtraction
```
