import time

def threesAndFives(max):
    sum = 0;
    
    for x in range(0, max):
        if (x % 5) == 0 or (x % 3) == 0:
            sum += x

    return sum

def alternateThreesAndFives(max):
    threes = range(0, max, 3)
    fives = range(0, max, 5)
    threesAndFives = range(0, max, 15)

    return sum(threes) + sum(fives) - sum(threesAndFives)

def gaussianMethod(max):
    s3 = gaussianSum(max, 3)
    s5 = gaussianSum(max, 5)
    s15 = gaussianSum(max, 15)

    return s3 + s5 - s15

def gaussianSum(max, n):
    steps = int(max / n)
    sumOfSteps = steps * (steps + 1) / 2
    
    return n * sumOfSteps

if __name__ == "__main__":
    for p in range(3, 8):
        k = 10 ** p
        print 'k = %d' % (k)
        
        start = time.time()
        s1 = threesAndFives(k)
        t1 = time.time() - start
        print 'method 1: %d (%d s)' % (s1, t1)

        start = time.time()
        s2 = alternateThreesAndFives(k)
        t2 = time.time() - start
        print 'method 2: %d (%d s)' % (s2, t2)

        start = time.time()
        s3 = gaussianMethod(k)
        t3 = time.time() - start
        print 'method 3: %d (%d s)' % (s3, t3)
