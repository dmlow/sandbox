def triangulars(n):
    list = []
    t = 0
    for i in range(1,n):
        t += i
        list.append(t)

    return list

def factors(n):
    f = []
    for factor in range(1, int(n ** 0.5 + 0.5)):
        if float(n) / factor == n / factor:
            f.append(factor)

    return f

def countDivisors(n):
    factors = primeFactors(n)
    if factors == []:
        return 2
    
    count = 1
    for f in factors:
        count *= (f[1]+1)
    return count

def primeFactors(n):
    list = []
    max = int(n ** 0.5 + 2)

    m = n
    
    f = 2
    p = 0
    while (m % f) == 0:
        m /= f
        p += 1
    if p > 0:
        list.append((f, p))
    
    for f in range(3, max+2, 2):
        p = 0
        while (m % f) == 0:
            m /= f
            p += 1
        if p > 0:
            list.append((f, p))

    return list

def findFirstTriangular2(minDivisors):
    n = 1
    t = 0
    nDivisors = 0
    while nDivisors < minDivisors:
        t += n
        nDivisors = countDivisors(t)
        n += 1
    # print (n-1, t, nDivisors)

    return (n-1, t, nDivisors)


def findFirstTriangular1(minFactors):
    n = 1
    triangular = n
    nDivisors = 0
    while nDivisors <= minFactors:
        nDivisors = len(factors(triangular))
        print n, triangular, nDivisors
        
        triangular += n
        n += 1



if __name__ == '__main__':
    print findFirstTriangular2(500)

