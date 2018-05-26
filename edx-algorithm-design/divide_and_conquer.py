import time
from functools import wraps

def timeit(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} called. Took {end-start}s to finish.")
        return result
    return wrapper


def read_majority_element_input(path):
    with open(path) as f:
        f.readline() # skip first line
        lst = f.readline().strip().split()
    return [int(item) for item in lst]

def majority_element(lst):
    """This is no divide-and-conquer. However, this is faster."""
    container = {}
    for item in lst:
        if item in container:
            container[item] += 1
        else:
            container[item] = 1
    n = len(lst)
    majority_count = int(n / 2) + 1
    max_element = max(container, key=lambda x: container[x])
    if container[max_element] >= majority_count:
        return max_element
    return None

def read_binary_search_input(path):
    with open(path) as f:
        lst = f.readline().strip().split()
        to_search = f.readline().strip().split()
    lst_ = [int(i) for i in lst]
    to_search_ = [int(i) for i in to_search]
    return lst_, to_search_

def search(lst, item):
    return binary_search(lst, 0, len(lst) - 1, item)

def binary_search(lst, i, j, item):
    mid = int(i + (j - i) / 2)
    if lst[mid] == item:
        return mid
    if i >= j:
        return -1
    if item > lst[mid]:
        return binary_search(lst, mid + 1, j, item)
    else:
        return binary_search(lst, i, mid - 1, item)

@timeit
def answer_binary_search(input_data_path):
    lst, to_search = read_binary_search_input(input_data_path)
    indexes = [search(lst, item) for item in to_search]
    existing = [index for index in indexes if index != -1]
    return len(existing)

@timeit
def answer_python_search(input_data_path):
    lst, to_search = read_binary_search_input(input_data_path)
    indexes = [python_search(lst, item) for item in to_search]
    existing = [index for index in indexes if index != -1]
    return len(existing)

def python_search(lst, item):
    try:
        return lst.index(item)
    except Exception:
        return -1

def compare_search(lst, to_search):
    for i, item in enumerate(to_search):
        print(i, item, search(lst, item), python_search(lst, item))

if __name__ == '__main__':
    import sys
    sys.setrecursionlimit(1000000)
    lst = read_majority_element_input('4_2_majority_element.in')
    #print(majority_element(lst))
    print(answer_binary_search('4_1_binary_search.in'))
    print(answer_python_search('4_1_binary_search.in'))
    #compare_search(lst, to_search[:100])
    #print(search(lst, to_search[91]))

