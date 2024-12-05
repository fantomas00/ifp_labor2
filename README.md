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

1. має змінюватися через створення нового, а не зміну вхідного.
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

## Лістинг функції remove-seconds-and-reverse

```lisp
(defun remove-seconds-and-reverse (lst)
  (cond
    ((null lst) '())                    ; corner case: empty list
    ((null (cdr lst)) (list (car lst))) ; corner case: single element list
    (t (append (remove-seconds-and-reverse (cddr lst)) (list (car lst)) ))))
```

### Тестові набори

```lisp
(defun test-remove-seconds-and-reverse ()
  (check-remove-seconds-and-reverse "test 1" '(1 2 a b 3 4 d) '(D 3 A 1))
  (check-remove-seconds-and-reverse "test 2" nil nil)
  (check-remove-seconds-and-reverse "test 3" '(10 20 30 40 50) '(50 30 10)))
```

```lisp
CL-USER> (test-remove-seconds-and-reverse)
passed... test 1
passed... test 2
passed... test 3
```

## Лістинг функції list-set-difference

```lisp
(defun list-set-difference (set1 set2)
  (if (null set1)             
      '()                
      (if (member (car set1) set2)
          (list-set-difference (cdr set1) set2)
          (cons (car set1) (list-set-difference (cdr set1) set2)))))
```

### Тестові набори

```lisp
(defun test-list-set-difference ()
  (check-list-set-difference "test 1" '(1 2 3 4) '(3 4 5 6) '(1 2))
  (check-list-set-difference "test 2" '(a b c) '(c d e) '(a b))              
  (check-list-set-difference "test 3" '(1 2 3 4 5) '(1 2) '(3 4 5)))
```

### Тестування

```lisp
CL-USER> (test-list-set-difference)
passed... test 1
passed... test 2
passed... test 3
```
