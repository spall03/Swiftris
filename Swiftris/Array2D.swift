//
//  Array2D.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/23/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

class Array2D<T>
{
    let columns: Int
    let rows: Int
    
    //this array can take nil values due to the ? optional designator
    var array: Array<T?>
    
    init(columns: Int, rows: Int)
    {
        self.columns = columns
        self.rows = rows
        
        //create new array with total volume of rows * columns
        array = Array<T?>(count:rows * columns, repeatedValue:nil)
        
    }
    
    subscript(column: Int, row: Int) -> T?
    {
    
        get
        {
            return array[(row * columns) + column] //this accesses the proper array cell given that it's 1D
        }
        
        set(newValue)
        {
            array[(row * columns) + column] = newValue
        }
        
        
    }
    

}
