import numpy as np

regyearpat = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]
leapyearpat = [0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30]
regyear = np.cumsum(regyearpat)
leapyear = np.cumsum(leapyearpat)
nSundays = np.matrix(2 * [7 * [0]])
print nSundays
for i in range(7):
    # regular years
    ryear = (regyear + i) % 7
    for d in ryear:
        if (d == 0):
            nSundays[0,i] += 1

    # leap years
    lyear = (leapyear + i) % 7
    for d in lyear:
        if d == 0:
            nSundays[1,i] += 1

    print i, nSundays


def go(minyear, maxyear, offset):
    count = 0
    o = offset % 7
    for y in range(minyear, maxyear+1):
        increment = 0
        leap = ((y % 4 == 0) and not (y % 400 == 0))
        if leap:
            increment = nSundays[1,o]
            print count, y, o, leap, increment
            o = (o + 2) % 7
        else:
            increment = nSundays[0,o]
            print count, y, o, leap, increment
            o = (o + 1) % 7
        count += increment

    return count

if __name__ == '__main__':
    minyear = 1901
    maxyear = 2000
    nsundays = go(minyear, maxyear, 2)
    print nsundays
