current = 0
total = 1
for ring in range(10):
    print 'ring', ring
    current += 1
    for corner in range(1, 5):
        current += (2*ring - 1)
        total += current
        print current, total

print total