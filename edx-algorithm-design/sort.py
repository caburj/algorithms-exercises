from myfunc import time_it
from collections import deque
import sys
sys.setrecursionlimit(100000000)

def selection_sort(lst):
    if len(lst) == 1:
        return lst
    min_index, min_value = argmin(lst)
    return [min_value] + selection_sort(lst[:min_index] + lst[min_index+1:])

def argmin(lst):
    if len(lst) == 0:
        return -1
    min_index = -1
    min_value = 999999999999
    for i, value in enumerate(lst):
        if value < min_value:
            min_index = i
            min_value = value
    return min_index, min_value

def merge_sort(lst):
    if len(lst) <= 1:
        return lst
    mid = int(len(lst) / 2)
    left = merge_sort(lst[:mid])
    right = merge_sort(lst[mid:])
    return merge(left, right)

def merge(left, right):
    combine = list()
    left = deque(left)
    right = deque(right)
    while len(left) > 0 and len(right) > 0:
        if left[0] <= right[0]:
            combine.append(left.popleft())
        else:
            combine.append(right.popleft())
    if len(left) > len(right):
        return combine + list(left)
    return combine + list(right)

def number_inversion(lst):
    if len(lst) <= 1:
        return lst, 0
    mid = int(len(lst) / 2)
    left, left_inversions = number_inversion(lst[:mid])
    right, right_inversions = number_inversion(lst[mid:])
    return merge_(left, right, left_inversions, right_inversions)

def merge_(left, right, left_inversions, right_inversions):
    combine = list()
    left = deque(left)
    right = deque(right)
    inversions = left_inversions + right_inversions
    while len(left) > 0 and len(right) > 0:
        if left[0] <= right[0]:
            combine.append(left.popleft())
        else:
            inversions += len(left) # add inversion
            combine.append(right.popleft())
    if len(left) > len(right):
        return combine + list(left), inversions
    return combine + list(right), inversions

def naive_number_inversion(lst):
    inversions = 0
    for i in range(len(lst)):
        for j in range(i, len(lst)):
            if lst[j] < lst[i]:
                inversions += 1
    return inversions

def quick_sort(lst):
    if len(lst) <= 1:
        return lst
    pivot = lst[0]
    left = [i for i in lst if i < pivot]
    equal = [i for i in lst if i == pivot]
    right = [i for i in lst if i > pivot]
    return quick_sort(left) + equal + quick_sort(right)

def read_majority_element_data():
    with open('data/4_2_majority_element.in') as f:
        f.readline()
        lst_ = f.readline().strip().split()
    return [int(i) for i in lst_]

def read_inversions_data():
    with open('data/4_4_inversions.in') as f:
        f.readline()
        lst_ = f.readline().strip().split()
    return [int(i) for i in lst_]

@time_it(n=1)
def test_selection_sort(lst):
    return selection_sort(lst)

@time_it(n=10)
def test_python_sort(lst):
    return sorted(lst)

@time_it(n=5)
def test_quick_sort(lst):
    return quick_sort(lst)

@time_it(n=5)
def test_merge_sort(lst):
    return merge_sort(lst)

@time_it(n=1)
def test_number_inversion(lst):
    return number_inversion(lst)

if __name__ == '__main__':
    lst = read_inversions_data()
    #print(test_selection_sort(lst)[:5])
    #print(test_python_sort(lst)[:5])
    #print(test_merge_sort(lst)[:5])
    #print(test_quick_sort(lst)[:5])
    #print(test_number_inversion(lst)[1])
    print(number_inversion([2,3,9,2,9])[1])
    print(naive_number_inversion([2,3,9,2,9]))
    print(number_inversion(lst)[1])
    print(naive_number_inversion(lst))
