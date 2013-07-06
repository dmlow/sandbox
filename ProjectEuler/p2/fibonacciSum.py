def evenFibonacci(max):
    sum = 0
    f1 = 1
    f2 = 1

    while f2 < max:
        f0 = f1
        f1 = f2
        f2 = f0 + f1
        if (f2 % 2) == 0:
            sum += f2

    return sum

if __name__ == '__main__':
    print 'sum = ' + str(evenFibonacci(4000000))