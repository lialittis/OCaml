# Exercises


## Tetragon

In this exercise, we will do some basic two-dimensional geometry.

We represent a point in two dimensions using a pair, as defined by type point2d in the given prelude. The first component is abscissa (x) and the second component is the ordinate (y). Abscissas grow from left to right and ordinates grow from bottom to top as illustrated by the following schema:

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


