import PlaygroundSupport
import SpriteKit
import Foundation

// These  extension controls the creation of harmful and harmless elements
extension GamePlay
{
    // This function generates elements that are going to appear
    // on the game scene based on a random number
    func generateRandomElement(ofType type: Int)
    {
        if type == 0
        {
            let jellyfish = SKSpriteNode()
            jellyfish.name = "jellyfish"
            jellyfish.texture = SKTexture(imageNamed: "jellyfish.png")
            jellyfish.size = CGSize(width: 15, height: 15)
            jellyfish.position = CGPoint(
                x: randomInterval(range: -480..<480),
                y: randomInterval(range: 160..<220))
            jellyfish.alpha = 0
            jellyfish.physicsBody = SKPhysicsBody(rectangleOf:
                CGSize(width: self.sizeOfJellyfish*0.6, height: self.sizeOfJellyfish*0.6))
            jellyfish.physicsBody?.linearDamping = 0
            jellyfish.physicsBody?.affectedByGravity = false
            jellyfish.physicsBody?.isDynamic = true
            jellyfish.physicsBody?.allowsRotation = false
            jellyfish.physicsBody?.pinned = false
            jellyfish.physicsBody?.categoryBitMask = BitMask.jellyfish
            jellyfish.physicsBody?.contactTestBitMask = BitMask.player
            jellyfish.physicsBody?.collisionBitMask = BitMask.noCategory
            jellyfish.physicsBody?.velocity.dy = -80
            jellyfish.run(SKAction.resize(
                toWidth: self.sizeOfJellyfish, height: self.sizeOfJellyfish, duration: 4))
            jellyfish.run(SKAction.fadeAlpha(to: 1, duration: 2))
            self.addChild(jellyfish)
            self.elements.append(jellyfish)
        }
        else if type == 1
        {
            let straw = SKSpriteNode()
            straw.name = "straw"
            straw.texture = SKTexture(imageNamed: "straw.png")
            straw.size = CGSize(width: 10, height: 10)
            straw.position = CGPoint(
                x: randomInterval(range: -460..<460),
                y: randomInterval(range: 160..<220))
            straw.alpha = 0
            straw.physicsBody = SKPhysicsBody(rectangleOf:
                CGSize(width: self.sizeOfJellyfish*0.5, height: self.sizeOfJellyfish*0.5))
            straw.physicsBody?.linearDamping = 0
            straw.physicsBody?.affectedByGravity = false
            straw.physicsBody?.isDynamic = true
            straw.physicsBody?.allowsRotation = false
            straw.physicsBody?.pinned = false
            straw.physicsBody?.categoryBitMask = BitMask.harmful
            straw.physicsBody?.contactTestBitMask = BitMask.player
            straw.physicsBody?.collisionBitMask = BitMask.noCategory
            straw.physicsBody?.velocity.dy = -80
            if Bool.random() { straw.run(SKAction.rotate(byAngle: CGFloat.pi/4, duration: 5)) }
            else { straw.run(SKAction.rotate(byAngle: -CGFloat.pi/4, duration: 5)) }
            straw.run(SKAction.resize(
                toWidth: self.sizeOfJellyfish, height: self.sizeOfJellyfish, duration: 5))
            straw.run(SKAction.fadeAlpha(to: 1, duration: 2))
            self.addChild(straw)
            self.elements.append(straw)
        }
        else
        {
            let plastic = SKSpriteNode()
            plastic.name = "plastic"
            plastic.texture = SKTexture(imageNamed: "plastic.png")
            plastic.size = CGSize(width: 15, height: 15)
            plastic.position = CGPoint(
                x: randomInterval(range: -460..<460),
                y: randomInterval(range: 160..<220))
            plastic.alpha = 0
            plastic.physicsBody = SKPhysicsBody(rectangleOf:
                CGSize(width: self.sizeOfJellyfish*0.6, height: self.sizeOfJellyfish*0.6))
            plastic.physicsBody?.linearDamping = 0
            plastic.physicsBody?.affectedByGravity = false
            plastic.physicsBody?.isDynamic = true
            plastic.physicsBody?.allowsRotation = false
            plastic.physicsBody?.pinned = false
            plastic.physicsBody?.categoryBitMask = BitMask.harmful
            plastic.physicsBody?.contactTestBitMask = BitMask.player
            plastic.physicsBody?.collisionBitMask = BitMask.noCategory
            plastic.physicsBody?.velocity.dy = -80
            plastic.run(SKAction.resize(
                toWidth: self.sizeOfJellyfish, height: self.sizeOfJellyfish, duration: 4))
            plastic.run(SKAction.fadeAlpha(to: 1, duration: 2))
            self.addChild(plastic)
            self.elements.append(plastic)
        }
    }
}
