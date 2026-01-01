import Testing

@testable import Day4

let theRolls = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

@Test("Part 1") func testPart1() {
    #expect(accessibleRollsOfPaper(in: theRolls) == 13)
}

@Test("Part 2") func testPart2() {
    #expect(removeAsMuchAsWeCan🔥🔥🔥(from: theRolls) == 43)
}
