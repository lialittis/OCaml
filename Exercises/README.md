# Exercises - BASIC PART


## 1. Tetragon

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

## 2. Time on Planet Shadokus

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


## 3. Enigma

Let us solve the following puzzle:
If you multiply my grand-son age by four, you know how old I am. Now, if you exchange the two digits of our ages then you have to multiply by three my age to get the age of my grand-son!
`
1. Write a function exchange of type int -> int that takes an integer x between 10 and 99 and returns an integer which is x whose digits have been exchanged. For instance, exchange 73 = 37.
2. Define is_valid_answer of type int * int -> bool such that is_valid_answer (grand_father_age, grand_son_age) returns true if and only if grand_father_age and grand_son_age verify the constraints of the puzzle.
3. Write a function find : (int * int) -> (int * int) that takes a pair (max_grand_father_age, min_grand_son_age) and returns a solution (grand_father_age, grand_son_age) to the problem, where min_grand_son_age <= grand_son_age < grand_father_age <= max_grand_father_age or (-1, -1) if there was no valid answer in the given range.
`

## 4. Points and vectors

The given prelude defines three types, one for three dimensional points, another for velocity vectors in three dimensions, and another one representing moving objects in space.

1. Write a function move : point -> dpoint -> point such that move p dp is the point p whose coordinates have been updated according to dp.
(x is now x +. dx, y is now y +. dy, z is now z +. dz.
2. Write a function next : physical_object -> physical_object such that next o is the physical object o at time t + dt.
The position of next o is the position of o moved according to its velocity vector.
3. Suppose that these objects are spheres whose radius is 1.0. Write a function will_collide_soon : physical_object -> physical_object -> bool that tells if at the next instant, the two spheres will intersect.


## 5. Searching for Strings in Arrays

1. Write a function is_sorted : string array -> bool which checks if the values of the input array are sorted in strictly increasing order, implying that its elements are unique (use String.compare).
2. Using the binary search algorithm, an element can be found very quickly in a sorted array. Write a function find : string array -> string -> int such that find arr word is the index of the word in the sorted array arr if it occurs in arr or -1 if word does not occur in arr. The number or array accesses will be counted, to check that you obtain the expected algorithmic complexity. Beware that you really perform the minimal number of accesses. For instance, if your function has to test the contents of a cell twice, be sure to put the result of the access in a variable, and then perform the tests on that variable.

## 6. Finding the Minimum

Consider a non empty array of integers a.

1. Write a function min : int array -> int that returns the minimal element of a.
2. Write a function min\_index : int array -> int that returns the index of the minimal element of a.

Do you think these functions work well on large arrays ?

3. Define a variable it\_scales and set it to "yes" or "no".


## 7. A Small Typed Database

The code of the mini-database example is given in the prelude.

1. You may have noticed that there is an error in the implementation of our database. This error leads to not finding users that should be in the database (because they have been added at some point, and not deleted since) after certain sequences of queries.
Find the bug and give a sequence of operations proof\_of\_bug of type query array that exhibits it when executed one after the other on an initially empty database.
The failure must be triggered by the last query.

3. To fix this bug, write a new version of delete that enforces the following invariant on the database, which is expected by the other functions.

All the contacts of a database db (and no others) should be stored in the array db.contacts between indexes 0 and db.number\_of\_contacts - 1 (inclusive).

3. Write a new function update : database -> contact -> (bool * database * contact) that either changes the number of an existing person or inserts a new contact. It should return true and the updated database if any of these two options succeeded, or false with the untouched database. The returned contact is not important, it is here just so the function has the same signature as the others.
4. Write an updated engine function that does an update when given a query with code 3, and uses your updated delete function.


