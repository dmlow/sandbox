import time
import itertools
digits = range(10)

def choosepairs():
    pairs = []

    # get the one digit multiplicands
    for e in digits[1:]:
        multipliers = choosemultipliers([e])
        for multiplier in multipliers:
            [a,b,c,d] = multiplier
            if checkproduct([a,b,c,d],[e]):
                pairs.append(([a,b,c,d],[e]))
    
    # choose multiplicand (note how we start with 12, instead of 01)
    for d in digits:
        for e in digits:
            if d != e:
                # now go get your multipliers
                multipliers = choosemultipliers([d, e])
                for multiplier in multipliers:
                    [a,b,c] = multiplier
                    if checkproduct([a,b,c], [d,e]):
                        pairs.append(([a,b,c],[d,e]))
                
    return pairs

def choosemultipliers(m):
    multipliers = []

    if len(m) == 2:
        [d,e] = m
        mutliplicand = d * 10 + e
    
        mina = (10000 / mutliplicand / 100)
        minb = (10000 / mutliplicand % 100) / 10
        minc = (10000 / mutliplicand % 10)
            
    
        for a in digits:
            if a != d and a != e:
                for b in digits:
                    if b != a and b != d and b != e:
                        for c in digits:
                            if c != a and c != b and c != d and c != e:
                                multipliers.append((a, b, c))
    elif len(m) == 1:
        [e] = m
        
        mina = (10000 / e / 1000)
        minb = (10000 / e % 1000) / 100
        minc = (10000 / e % 100) / 10
        mind = (10000 / e % 10)
    
        for a in digits:
            if a != e:
                for b in digits:
                    if b != a and b != e:
                        for c in digits:
                            if c != a and c != b and c != e:
                                for d in digits:
                                    if d != a and d != b and d != c and d != e:
                                        multipliers.append((a,b,c,d))

    return multipliers
            
def checkproduct(m, n):
    p = pairproduct(m, n)
    # print n, m, p
    # time.sleep(0.5)
    pdigits = map(int, [x for x in str(p)])
    alldigits = pdigits + m + n
    alldigits.sort()
    return (alldigits == digits)
            
def pairproduct(m,n):
    if len(m) == 1:
        [e] = m
        [a,b,c,d] = n
        p = (a*1000 + b*100 + c*10 + d) * (e)
    elif len(m) == 2:
        [d,e] = m
        [a,b,c] = n
        p = (a*100 + b*10 + c) * (d*10 + e)
    elif len(m) == 3:
        [a,b,c] = m
        [d,e] = n
        p = (a*100 + b*10 + c) * (d*10 + e)
    else:
        [a,b,c,d] = m
        [e] = n
        p = (a*1000 + b*100 + c*10 + d) * (e)
    return p

def bruteforce():
    seqs = itertools.permutations(range(1,10))
    products = []
    for s in seqs:
        seq = list(s)
        [a,b, c,d,e, f,g,h,i] = seq
        p = f*1000 + g*100 + h*10 + i
        
        t = a*10 + b
        u = c*100 + d*10 + e
        v = a
        w = b*1000 + u
        
        if (p == t * u):
            print t, u, p
            products.append(p)
        elif (p == v * w):
            print v, w, p
            products.append(p)

    return products


if __name__ == '__main__':
    pairs = choosepairs()
    total = 0
    products = []
    print '%d valid pairs' % len(pairs)
    for pair in pairs:
        [m,n] = pair
        p = pairproduct(m,n)
        products.append(p)
        print n, m, p
        total += p
    print 'total = %d' % total
    products.sort()
    print products

    b = bruteforce()
    b.sort()
    for a in b:
        print a
    print sum(b)


            
            
            
            
            
