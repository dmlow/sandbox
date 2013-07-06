def findTriplet(n):
    triplets = getTriplets(n/2)
    for i in range(len(triplets)):
        triplet = triplets[i]
        s = sum(triplet)
        print triplet, s
        if s == n:
            return triplet


def squares(max):
    sq = []
    for i in range(1,max):
        sq.append(i*i)
    return sq

def getTriplets(max):
    sqs = squares(max)
    triplets = []

    for i in range(len(sqs)-1,2,-1):
        diff = sqs[i] - sqs[0]
        j = i - 1
        # determine if the difference of squares is also a square
        for j in range(0, i-1):
            diff = sqs[i] - sqs[j]
            if diff in sqs:
                triplets.append((int(diff**0.5 + 0.5), int(sqs[j]**0.5 + 0.5), int(sqs[i]**0.5 + 0.5)))

    return triplets

def isTriplet(t):
    a = t[0]
    b = t[1]
    c = t[2]

    if a*a + b*b == c*c:
        return True
    else:
        return False


if __name__ == '__main__':
    n = 1000
    t = findTriplet(n)
    print 'The pythagorean triplet, {a,b,c} for which a + b + c = 1000 is {%d, %d, %d}, and has the product abc = %d' % (t[0],t[1],t[2], t[0]*t[1]*t[2])