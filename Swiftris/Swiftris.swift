//
//  Swiftris.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/23/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

//initialize game board
let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

class Swiftris {
    var blockArray:Array2D<Block>
    var nextShape:Shape?
    var fallingShape:Shape?
    
    init() {
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
    }
    
    // #2
    func newShape() -> (fallingShape:Shape?, nextShape:Shape?) {
        fallingShape = nextShape
        nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow) //generate new preview shape
        fallingShape?.moveTo(StartingColumn, row: StartingRow) //move shape from preview column to game board
        return (fallingShape, nextShape)
    }
}
