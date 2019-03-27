import SpriteKit
import CoreMotion
import PlaygroundSupport

// The class below is used to control the final scene of the game
public class GameFinal: SKScene, SKPhysicsContactDelegate
{
    // Here are the variables used in this scene
    var play:SKSpriteNode?
    var playPressed:SKSpriteNode?
    var background:SKSpriteNode?
    var message1:SKSpriteNode?
    var message2:SKSpriteNode?
    var message3:SKSpriteNode?
    var waterShader = WaterShader()
    
    // First function loaded in the scene
    override public func sceneDidLoad()
    {
        // The line below adds the delegate to the physisc world used        
        self.play = childNode(withName: "play") as? SKSpriteNode
        self.playPressed = childNode(withName: "playPressed") as? SKSpriteNode
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.waterShader.applyWaterShader(To: self.background!)
        
        self.message1 = childNode(withName: "message1") as? SKSpriteNode
        self.message2 = childNode(withName: "message2") as? SKSpriteNode
        self.message3 = childNode(withName: "message3") as? SKSpriteNode
        
        self.message1?.run(SKAction.fadeIn(withDuration: 0.5), completion: {
            self.message2?.run(SKAction.fadeIn(withDuration: 2), completion: {
                self.message3?.run(SKAction.fadeIn(withDuration: 2))
            })
        })
    }
    
    // This function is called everytime the touch interaction ends
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { touchUp(atPoint: t.location(in: self)) } }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { touchUp(atPoint: t.location(in: self)) } }
    
    // This function receives the position of the players last touch on the screen
    func touchUp(atPoint pos : CGPoint)
    {
        let reveal = SKTransition.crossFade(withDuration: 0.5)
        if let gameScene = GamePlay(fileNamed: "GamePlay"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    // This function is celled everytime the touch interaction begins
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { self.touchDown(atPoint: t.location(in: self)) } }
    
    // Here i verify the positions of the touchs to know
    // if the player wants to play again
    func touchDown(atPoint pos : CGPoint)
    {
        self.play?.alpha = 0
        self.playPressed?.alpha = 1
    }
}
