import time

def readTriangle(filename):
    T = []
    f = open(filename, 'r')
    for line in f:
        T.append(map(int, line.split(' ')))

    return T

def addBiggerSum(T):
    for row in range(len(T)-2, -1, -1):
        for col in range(len(T[row])):
            T[row][col] = addBigger(T, row, col)

    return T[0][0]

def addBigger(T, row, col):
    l = T[row+1][col]
    r = T[row+1][col+1]
    if l > r:
        return T[row][col] + l
    else:
        return T[row][col] + r

if __name__ == '__main__':
    T = readTriangle('triangle.txt')
    for t in T:
        print t

    start = time.time()
    s = addBiggerSum(T)
    t = time.time() - start
    print '%d, %f ms' % (s, t * 1000)
