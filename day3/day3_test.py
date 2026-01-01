import unittest

from day3.day3 import part1, part2


class TestTotalJoltage(unittest.TestCase):
    test_input: str = """987654321111111
    811111111111119
    234234234234278
    818181911112111"""

    def testPart1(self):
        self.assertEqual(part1(list(self.test_input.splitlines())), 357)

    def testPart2(self):
        self.assertEqual(part2(list(self.test_input.splitlines())), 3121910778619)


unittest.main()
