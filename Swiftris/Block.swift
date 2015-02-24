//
//  Block.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/23/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import SpriteKit


let NumberOfColors: UInt32 = 6 //six colors available

enum BlockColor: Int, Printable //written to output stream
{
    
    case Blue = 0, Orange, Purple, Red, Teal, Yellow
    
    var spriteName: String
        {
        switch self {
        case .Blue:
            return "blue"
        case .Orange:
            return "orange"
        case .Purple:
            return "purple"
        case .Red:
            return "red"
        case .Teal:
            return "teal"
        case .Yellow:
            return "yellow"
        }
    }
    
    var description: String
    {
        return self.spriteName //computed property to adhere to Printable protocol
    }
    
    static func random() -> BlockColor
    {
        return BlockColor(rawValue: Int(arc4random_uniform(NumberOfColors)))!
        
    }
    
}

class Block: Hashable, Printable
{
    
    let color: BlockColor
    
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    //shortcut for accessing sprite
    var spriteName: String
    {
        return color.spriteName
    }
    
    var hashValue: Int
    {
        return self.column ^ self.row //XOR operator
    }
    
    var description: String
    {
        return "\(color): [\(column), \(row)]"
    }
    
    init(column:Int, row:Int, color: BlockColor)
    {
        self.column = column
        self.row = row
        self.color = color
    }
    
}

//equatable operator override
func ==(lhs: Block, rhs: Block) -> Bool
{
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}