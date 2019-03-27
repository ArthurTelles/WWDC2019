import PlaygroundSupport
import SpriteKit

// This file contains the random CGFloat generator used to position the nodes
// Returns a random number based on the range given
func randomInterval(range: Range<Int> ) -> CGFloat
{
    var offset = 0
    if range.startIndex < 0 { offset = abs(range.startIndex) }
    
    let min = UInt32(range.startIndex + offset)
    let max = UInt32(range.endIndex + offset)
    
    return (CGFloat(min + arc4random_uniform(max - min)) - CGFloat(offset))
}
