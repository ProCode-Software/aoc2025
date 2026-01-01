def part1(input: list[str]) -> int:
    total: int = 0
    for line in input:
        line = line.strip()
        joltage: int = 0
        first: int = 0
        first_index: int = 0
        # Joltage for each battery
        # First number
        for i, n in enumerate(line[:-1]):
            if int(n) > first:
                first = int(n)
                first_index = i
        # second number
        second: int = 0
        for n in line[first_index + 1 :]:
            if int(n) > second:
                second = int(n)
        joltage = first * 10 + second
        total += joltage
    return total


def part2(input: list[str]) -> int:
    total: int = 0
    # Iterate over batteries
    for line in input:
        line = line.strip()
        nums: list[int] = []
        last_index: int = -1
        # largest digit each time
        for i in range(12, 0, -1):
            unavailable = i - 1 if i > 1 else -len(line)
            curr: int = 0
            # reduce
            offset = last_index + 1
            for j, n in enumerate(line[last_index + 1 : -unavailable]):
                if int(n) > curr:
                    curr = int(n)
                    last_index = j + offset
            nums.append(curr)
        # calculate joltage for this battery
        joltage: int = 0
        for n in nums:
            joltage = joltage * 10 + n
        total += joltage

    return total


if __name__ == "__main__":
    with open("day3/input.txt") as input:
        lines = input.readlines()
        part1_joltage = part1(lines)
        print(f"Part1: {part1_joltage}")
        part2_joltage = part2(lines)
        print(f"Part2: {part2_joltage}")
