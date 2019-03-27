// This file contains the bit masks that are being used on the GameScene
public struct BitMask
{
    static var noCategory: UInt32 = 0b000 // Objects that will not interact
    static var player: UInt32 = 0b001 // Player category
    static var harmful: UInt32 = 0b010 // Harmful objects category
    static var jellyfish: UInt32 = 0b100 // Harmless objects category
}
