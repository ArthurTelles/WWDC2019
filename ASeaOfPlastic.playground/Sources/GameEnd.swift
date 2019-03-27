import SpriteKit
import CoreMotion
import PlaygroundSupport

// This class presents a scene to show the player that he lost the game
public class GameEnd: SKScene, SKPhysicsContactDelegate
{
    // Variables used to control the scene
    var play:SKSpriteNode?
    var playPressed:SKSpriteNode?
    var background:SKSpriteNode?
    var waterShader = WaterShader()

    // This function configures the play again button
    override public func sceneDidLoad()
    {
        self.play = childNode(withName: "play") as? SKSpriteNode
        self.playPressed = childNode(withName: "playPressed") as? SKSpriteNode
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.waterShader.applyWaterShader(To: self.background!)
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
