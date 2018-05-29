import math
import sys
sys.setrecursionlimit(1000000000)

from myfunc import time_it

def closest_pair(points):
    if len(points) <= 1:
        return 0.

    if len(points) == 2:
        return points[0] | points[1]

    sorted_points = sorted(points, key=lambda p: p.x)
    mid = int(len(points) / 2)
    p1 = sorted_points[mid]
    p2 = sorted_points[mid + 1]
    mid_line = ( (p1 + p2) / 2 ).x
    print(mid_line)
    d1 = closest_pair(sorted_points[:mid])
    d2 = closest_pair(sorted_points[mid:])
    d = min(d1, d2)
    upper_x, lower_x = mid_line + d, mid_line - d
    middle_points = [point for point in sorted_points
                     if lower_x <= point.x <= upper_x]
    d_ = naive_closest_pair(middle_points)
    return min(d, d_)

def naive_closest_pair(points):
    distances = {}
    for i in range(len(points)):
        for j in range(len(points)):
            if i != j:
                distances[(i, j)] = points[i] | points[j]
    i, j = min(distances, key=lambda key: distances[key])
    return points[i] | points[j]

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

if __name__ == '__main__':
    points = read_closest_data()
    points = points[:1000]
    # points = [Point(7, 7), Point(1, 100), Point(4, 8), Point(7, 7)]
    points = [Point(*pair) for pair in [(4,4), (-2,-2), (-3,-4), (-1,3), (2,3), (-4,0), (1,1), (-1,-1), (3,-1), (-4,2), (-2,4)]]
    print(naive_closest_pair(points))
    print(closest_pair(points))
