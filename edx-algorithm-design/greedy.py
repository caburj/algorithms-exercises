def maximum_loot(items, capacity):
    """
    items: list((float,float))
        list of value and weight
    capacity: float
        capacity of bag

    Return
    ------
    bag containing max value: list((float,float))
    """
    sorted_items = sorted(items, key=lambda item: item[1]/item[0])
    W = capacity
    bag = []
    for item in sorted_items:
        v, w = item
        if w <= W:
            bag.append(item)
            W -= w
        else:
            bag.append((v/w*W,W))
            break
    return bag

def maximum_loot_recursive(items, capacity):
    sorted_items = sorted(items, key=lambda item: item[1]/item[0])

    def _max_loot(items, W, bag):
        if len(items) == 0 or W == 0:
            return bag

        v, w = items[0]
        remaining_items = items[1:]

        if w <= W:
            return _max_loot(remaining_items, W-w, bag+[(v, w)])
        else:
            return _max_loot(remaining_items, 0, bag+[(v/w*W, W)])

    return _max_loot(sorted_items, capacity, bag=[])


def bag_value(bag):
    return sum(item[0] for item in bag)

def read_input(path):
    with open(path) as f:
        first_line = f.readline()
        n, capacity = (int(val) for val in first_line.split())
        items_str = f.readlines()[:-1]
        items = [tuple(int(val) for val in line.split()) for line in items_str]
    return items, capacity

def read_max_rev_input(path):
    with open(path) as f:
        f.readline() # ignore first line
        a_str = f.readline()
        b_str = f.readline()

        a = [float(x) for x in a_str.strip().split()]
        b = [float(x) for x in b_str.strip().split()]

    return a, b

def maximum_revenue(a, b):
    """
    a: list(float)
    b: list(float)

    Return
    ------
    max revenue: float
    """
    sorted_a = sorted(a, reverse=True)
    sorted_b = sorted(b, reverse=True)

    return sum(x*y for x, y in zip(sorted_a, sorted_b))

if __name__ == '__main__':
    print(bag_value(maximum_loot(*read_input('data/loot.in'))))
    print(bag_value(maximum_loot_recursive(*read_input('data/loot.in'))))
    print(maximum_revenue(*read_max_rev_input('data/max_rev_input.in')))
