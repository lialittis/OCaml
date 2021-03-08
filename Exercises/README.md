# Exercises


## Tetragon

In this exercise, we will do some basic two-dimensional geometry.

We represent a point in two dimensions using a pair, as defined by type point2d in the given prelude. The first component is abscissa (x) and the second component is the ordinate (y). Abscissas grow from left to right and ordinates grow from bottom to top as illustrated by the following schema:

`
                          ^ (y)
                          |
                          |
                          |
                          |
   -------------------- (0,0) --------------------> (x)
                          |
                          |
                          |
                          |
`
A tetragon is a polygon with four sides. We represent such an object using a 4-uple of points, as defined by type tetragon in the given prelude. that appear in the following order: the left upper point (lup), the right upper point (rup), the left lower point (llp) and the right lower point (rlp).

1. Write a function pairwise_distinct of type tetragon -> bool that checks that the points of an input tetragon are pairwise distinct. In the sequel, we assume that all the points are pairwise distinct.
2. A tetragon is well-formed if the following properties are verified:
The left upper and the left lower points have the lowest abscissa.
	1. Between the two leftmost points, the left upper point has the greatest ordinate.
	2. Between the two rightmost points, the right upper point has the greatest ordinate.
	3. Write a function wellformed of type tetragon -> bool that returns true if and only if the input tetragon is well formed.
	4. A simple way to rotate a tetragon by 90 degrees clockwise with respect to (0, 0) is to rotate each of its points by exchanging their abscissa and ordinate and negating the resulting ordinate.
3. Write a function rotate_point of type point2d -> point2d such that rotate_point p is the point p rotated as explained in the previous paragraph.
Once rotated, the points of the tetragon may not be in the right order: lup may be now llp, rup may be now llp, etc.
4. Write a function reorder of type point2d * point2d * point2d * point2d -> tetragon that takes 4 pairwise distinct points (not necessarily the output of the previous function but any 4 points) and returns a wellformed tetragon.
5. Write a function rotate_tetragon that takes a well-formed tetragon and returns a well-formed rotated tetragon.

## Time on Planet Shadokus

On planet Shadokus, a year has 5 months, each month has 4 days, each day has 3 hours and each hour has 2 minutes. A calendar date is therefore defined as the record type date of the given prelude.

1. A date is well-formed if its year index is >= 1, its month index is >= 1 and <= 5, its day index is >= 1 and <= 4, its hour index is >= 0 and <= 2, and its minute index is >= 0 and <= 1.
The start of year 12 would be:
{ year = 12; month = 1; day = 1; hour = 0; minute = 0 }
The end of year 12 would be:
{ year = 12; month = 5; day = 4; hour = 2; minute = 1 }

Write a function wellformed : date -> bool which checks that the input date is well formed.
2. On planet Shadokus, the origin of time is the discovery of the Big-Lambda-Machine, a magical computer that evaluates the infinite lambda-term of time. It is defined by value the_origin_of_time of the given prelude.
Write a function next : date -> date which computes the date which comes one minute after the input date.
3. In this computer, the time is represented by an integer that counts the number of minutes since 1/1/1 0:0 (the origin of time).
Write a function of_int : int -> date that converts such an integer into a date.







