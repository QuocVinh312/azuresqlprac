/* Recursive CTE
Practice Question R1 (mechanics only, no tables)
Problem: Generate a sequence of integers starting at 1 and ending at 10 using a recursive CTE.
Output: one column named num with values 1 through 10 (each number on its own row).
*/
WITH RECURSIVE num_sequence AS(
    SELECT 1 AS num

    UNION ALL
    SELECT num + 1
    FROM num_sequence

    WHERE num < 10
)
SELECT num
FROM num_sequence

/*Practice Question R2 (Still basic)
Problem:
Generate salary levels starting at 4000, increasing by 500 each step, and stop once the value exceeds 6000.
*/
WITH RECURSIVE salary_cur AS(
    SELECT 4000 AS salary_levels

    UNION ALL
    SELECT salary_levels + 500
    FROM salary_cur

    WHERE salary_levels < 6000
)
SELECT salary_levels
FROM salary_cur
/*
Practice Question R3 (Recursive + CTE output usage):
Problem:
Using a recursive CTE, generate numbers from 1 to 5, and in the final SELECT, also show the square of each number.
*/
WITH RECURSIVE square_num AS(
    SELECT 1 AS num

    UNION ALL
    SELECT num + 1
    FROM square_num

    WHERE num < 5
)
SELECT POWER(num,2) AS square_of_num
FROM square_num
/*Practice Question R4 (Recursive + Derived Value)
Problem:
Using a recursive CTE, generate a sequence that starts at 2 and keeps doubling each time, stopping once the value exceeds 64.
*/
WITH RECURSIVE num_sequence AS(
    SELECT 2 AS num

    UNION ALL
    SELECT num + 2
    FROM num_sequence

    WHERE num < 64
)
SELECT num
FROM num_sequence
/*
Practice Question R5 (Recursive + Counter):
Using a recursive CTE, generate numbers from 1 to 5, and also show a step number that counts
how many iterations were used to reach each value.
*/
WITH RECURSIVE num_sequence AS(
    SELECT
        1 AS num,
        1 AS step_number

    UNION ALL
    SELECT
        num + 1,
        step_number + 1
    FROM num_sequence

    WHERE num < 10
)
SELECT num, step_number
FROM num_sequence

/*Next (R6 — last numbers reinforcement, still basic but very useful):
Problem: Generate numbers from 1 to 10 using a recursive CTE, and also show a running total (cumulative sum) of those numbers.
Output columns: num, running_total
Example idea: at num=4, running_total should be 1+2+3+4 = 10.
*/
WITH RECURSIVE num_sequence AS(
    SELECT
        1 AS num,
        1 AS running_total

    UNION ALL
    SELECT
        num + 1,
        running_total + (num + 1)
    FROM num_sequence

    WHERE num < 10
)
SELECT num, running_total
FROM num_sequence

/*Task:
Generate numbers from 1 to 5 and show num and double_num where double_num = num * 2.
I’ll guide you:
Anchor: num=1, double_num=2
Recursive step: num increases by 1, double_num increases accordingly
Stop at 5
*/
WITH RECURSIVE num_sequence AS(
    SELECT
        1 AS num,
        1 AS double_num

    UNION ALL
    SELECT
        num + 1,
        (num+1)*2 AS double_num
    FROM num_sequence

    WHERE num < 5
)
SELECT num, double_num
FROM num_sequence

/*Next (R7 — still basic, same pattern, one new twist):
Problem: Generate numbers from 1 to 6, and show whether each number is odd or even as a column
named parity with values 'Odd' or 'Even'.
Output columns: num, parity
*/
WITH RECURSIVE num_sequence AS(
    SELECT
        1 AS num,
        CASE WHEN 1 % 2 = 0 THEN 'Even' ELSE 'Odd' END AS odd_or_even

    UNION ALL
    SELECT
        num + 1,
        CASE WHEN (num + 1) % 2 = 0 THEN 'Even' ELSE 'Odd' END
    FROM num_sequence

    WHERE num < 6
)
SELECT num, odd_or_even
FROM num_sequence