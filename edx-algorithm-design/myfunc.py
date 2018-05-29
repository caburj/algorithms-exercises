from functools import wraps
import time

def time_it(n=1):
    """
    Returns a decorator that calculates the execution of the given function.
    """
    def _time_it(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            start = time.time()
            for i in range(n):
                result = func(*args, **kwargs)
            end = time.time()
            print(f"{func.__name__} executed {n} times.\n"
                  f"Average execution time: {(end-start) / n}s.")
            return result
        return wrapper
    return _time_it

