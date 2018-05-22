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
    # sort items by descending value/weight ratio
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

def bag_value(bag):
    return sum(item[0] for item in bag)

def read_input(path):
    with open(path) as f:
        first_line = f.readline()
        n, capacity = (int(val) for val in first_line.split())
        items_str = f.readlines()[:-1]
        items = [tuple(int(val) for val in line.split()) for line in items_str]
    return items, capacity

if __name__ == '__main__':
    print(bag_value(maximum_loot(*read_input('loot.in'))))
