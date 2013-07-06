import time

def readTriangle(filename):
    T = []
    f = open(filename, 'r')
    for line in f:
        T.append(map(int, line.split(' ')))

    return T

def getPath(triangle):
    path = []
    col = 0
    for row in range(len(triangle)):
        dir = chooseDirection(triangle, row, col)
        print dir, row, col, triangle[row][col]
        if dir is not None:
            path.append(dir)
            col += dir

    return path

def chooseDirection(triangle, row, col):
    for i in range(len(triangle) - row):
        l = leftSum(triangle, row+i, col)
        r = rightSum(triangle, row+i, col+i)
        print l, r
        if l > r:
            return 0
        if r > l:
            return 1

    return None

def pathSum(triangle, startRow, startCol, path):
    if startRow + len(path) > len(triangle):
        return None
    # print 'pathsum at %d, %d (%d)' % (startRow, startCol, triangle[startRow][startCol])
    # print path
    row = startRow
    col = startCol
    s = []
    for i in range(len(path)):
        if row > len(triangle):
            break
        s += [triangle[row][col]]
        # print i, row, col, triangle[row][col], s

        row += 1
        col += path[i]

    print s, sum(s)
    return sum(s)

def leftSum(triangle, row, col):
    path = (len(triangle) - row - 1) * [0]
    return pathSum(triangle, row+1, col, path)

def rightSum(triangle, row, col):
    path = (len(triangle) - row - 1) * [1]
    return pathSum(triangle, row+1, col+1, path)

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
