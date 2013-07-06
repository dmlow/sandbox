def sumSquareDifference(n):
    s = n * (n+1) / 2
    diff = 0
    for m in range(1,n+1):
        diff += m * (s-m)
    return diff

if __name__=='__main__':
    n = 100
    print 'The difference between the sum of squares and square of sums of every number up to %d is %d' % (n, sumSquareDifference(n))