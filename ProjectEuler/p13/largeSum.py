def readNumbers(filename):
    f = open(filename, 'r')
    numbers = []
    for line in f:
        numbers.append(line)
    return numbers

def roughSum(numbers):
    s = 0
    for i in range(len(numbers)):
        n = int(numbers[i][0:10])
        n = int(n / 10. + 0.5)
        print '%s\n%d\n\n' % (numbers[i][0:10], n)
        s += n
    return s

if __name__ == '__main__':
    numbers = readNumbers('numbers.txt')
    s = roughSum(numbers)
    print '%d, %d digits' % (s, len(str(s)))
