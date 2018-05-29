import math
import sys
sys.setrecursionlimit(1000000000)

from myfunc import time_it

"""
LESSONS LEARNED
--------------
- It is very important to correctly define the base cases, especially in
implementing recursive functions.
"""

def closest_distance(points):
    # base cases
    if len(points) <= 1:
        return None
    if len(points) == 2:
        return points[0] | points[1]
    # calculate the mid-line
    mid = int(len(points) / 2)
    p1 = points[mid]
    p2 = points[mid + 1]
    mid_line = ( (p1 + p2) / 2 ).x
    # recusive call for left and right parts
    d1 = closest_distance(points[:mid])
    d2 = closest_distance(points[mid:])
    # merging the results
    d = min_(d1, d2)
    upper_x, lower_x = mid_line + d, mid_line - d
    # points in the middle band
    middle_points = [point for point in points if lower_x <= point.x <= upper_x]
    # perform naive closest pair algorithm for the points in the middle band
    d_ = naive_closest_distance(middle_points)
    return min_(d, d_)


def improved_closest_distance(points):
    pass


def min_(a, b):
    if a is None:
        return b
    if b is None:
        return a
    return min(a, b)


def naive_closest_distance(points):
    if len(points) <= 1:
        return None

    distances = {}
    for i in range(len(points)):
        for j in range(len(points)):
            if i != j:
                distances[(i, j)] = points[i] | points[j]

    return min(distances.values())


class Point:
    def __init__(self, x, y):
        self._x = x
        self._y = y

    @property
    def x(self):
        return self._x

    @property
    def y(self):
        return self._y

    def __repr__(self):
        return f"{self.__class__.__name__}({self.x}, {self.y})"

    def __abs__(self):
        return math.sqrt(self.x ** 2 + self.y ** 2)

    def __add__(self, other):
        x = self.x + other.x
        y = self.y + other.y
        return self.__class__(x, y)

    def __sub__(self, other):
        x = self.x - other.x
        y = self.y - other.y
        return self.__class__(x, y)

    def __truediv__(self, other):
        x = self.x / other
        y = self.y / other
        return self.__class__(x, y)

    def __or__(self, other):
        """operator to get the distance between self and other"""
        return abs(self - other)


def read_closest_data():
    with open('data/4_6_closest.in') as f:
        f.readline()
        points_ = [line.strip().split() for line in f.read().strip().split('\n')]
    return [Point(*[int(comp) for comp in point]) for point in points_]


@time_it(n=1)
def test_naive_closest_distance(points):
    return naive_closest_distance(points)


@time_it(n=1)
def test_closest_distance(points):
    return closest_distance(points)


@time_it(n=1)
def test_improved_closest_distance(points):
    return improved_closest_distance(points)


if __name__ == '__main__':
    points = read_closest_data()
    points = points[:]
    sorted_points = sorted(points, key=lambda p: p.x)
    # sorted_points_ = sorted(sorted_points, key=lambda p: p.y)
    # print(test_naive_closest_distance(sorted_points))
    print(test_closest_distance(sorted_points))
