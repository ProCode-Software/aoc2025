// The Swift Programming Language
// https://docs.swift.org/swift-book
//
import Foundation

@main
public struct Day4 {
    static func main() {
        let file = try! String(
            contentsOfFile: FileManager.default.currentDirectoryPath + "/day4/input.txt",
            encoding: .utf8)
        print("Part 1: \(accessibleRollsOfPaper(in: file))")
        print("Part 2: \(removeAsMuchAsWeCan🔥🔥🔥(from: file))")
    }
}

public func accessibleRollsOfPaper(in str: String) -> Int {
    let MAX_ADJACENT = 3
    // Make the matrix
    let lines = str.split(separator: "\n")
    var matrix: [[Character]] = []
    matrix.reserveCapacity(lines.count)
    for line in lines {
        matrix.append([Character](line))
    }
    var total = 0
    // Looping
    for (lineI, line) in matrix.enumerated() {
        rollsLoop: for (rollI, roll) in line.enumerated() {
            if roll != "@" {
                continue
            }
            var adjacent = 0
            var allAdjacent: [Character] = []
            allAdjacent.reserveCapacity(8)

            let isBottomEdge = lineI == matrix.count - 1
            let isTopEdge = lineI == 0
            let isLeftEdge = rollI == 0
            let isRightEdge = rollI == line.count - 1
            // Top
            if !isTopEdge {
                let prevLine = matrix[lineI - 1]
                let top = prevLine[rollI]
                allAdjacent.append(top)
                if !isLeftEdge {
                    let topLeft = prevLine[rollI - 1]
                    allAdjacent.append(topLeft)
                }
                if !isRightEdge {
                    let topRight = prevLine[rollI + 1]
                    allAdjacent.append(topRight)
                }
            }
            // Bottom
            if !isBottomEdge {
                let nextLine = matrix[lineI + 1]
                let bottom = nextLine[rollI]
                allAdjacent.append(bottom)
                if !isLeftEdge {
                    let bottomLeft = nextLine[rollI - 1]
                    allAdjacent.append(bottomLeft)
                }
                if !isRightEdge {
                    let bottomRight = nextLine[rollI + 1]
                    allAdjacent.append(bottomRight)
                }
            }
            // Left
            if !isLeftEdge {
                let left = line[rollI - 1]
                allAdjacent.append(left)
            }
            // Right
            if !isRightEdge {
                let right = line[rollI + 1]
                allAdjacent.append(right)
            }

            // Count all adjacent
            for c in allAdjacent {
                if c == "@" {
                    adjacent += 1
                    if adjacent > MAX_ADJACENT {
                        continue rollsLoop
                    }
                }
            }
            total += 1
        }
    }
    return total
}

public func removeAsMuchAsWeCan🔥🔥🔥(from str: String) -> Int {
    let MAX_ADJACENT = 3
    // Make the matrix
    let lines = str.split(separator: "\n")
    var matrix: [[Character]] = []
    matrix.reserveCapacity(lines.count)
    for line in lines {
        matrix.append([Character](line))
    }
    var actualTotal = 0
    removeMore: while true {
        var moreRemoved = 0
        // Looping
        for (lineI, line) in matrix.enumerated() {
            rollsLoop: for (rollI, roll) in line.enumerated() {
                if roll != "@" {
                    continue
                }
                var adjacent = 0
                var allAdjacent: [Character] = []
                allAdjacent.reserveCapacity(8)

                let isBottomEdge = lineI == matrix.count - 1
                let isTopEdge = lineI == 0
                let isLeftEdge = rollI == 0
                let isRightEdge = rollI == line.count - 1
                // Top
                if !isTopEdge {
                    let prevLine = matrix[lineI - 1]
                    let top = prevLine[rollI]
                    allAdjacent.append(top)
                    if !isLeftEdge {
                        let topLeft = prevLine[rollI - 1]
                        allAdjacent.append(topLeft)
                    }
                    if !isRightEdge {
                        let topRight = prevLine[rollI + 1]
                        allAdjacent.append(topRight)
                    }
                }
                // Bottom
                if !isBottomEdge {
                    let nextLine = matrix[lineI + 1]
                    let bottom = nextLine[rollI]
                    allAdjacent.append(bottom)
                    if !isLeftEdge {
                        let bottomLeft = nextLine[rollI - 1]
                        allAdjacent.append(bottomLeft)
                    }
                    if !isRightEdge {
                        let bottomRight = nextLine[rollI + 1]
                        allAdjacent.append(bottomRight)
                    }
                }
                // Left
                if !isLeftEdge {
                    let left = line[rollI - 1]
                    allAdjacent.append(left)
                }
                // Right
                if !isRightEdge {
                    let right = line[rollI + 1]
                    allAdjacent.append(right)
                }

                // Count all adjacent
                for c in allAdjacent {
                    if c == "@" {
                        adjacent += 1
                        if adjacent > MAX_ADJACENT {
                            continue rollsLoop
                        }
                    }
                }
                moreRemoved += 1
                matrix[lineI][rollI] = "x"
            }
        }
        if moreRemoved == 0 {
            return actualTotal
        }
        actualTotal += moreRemoved
    }
}
