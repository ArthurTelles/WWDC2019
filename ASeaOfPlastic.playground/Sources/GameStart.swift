import SpriteKit
import CoreMotion
import PlaygroundSupport

// This class makes the introduction screen and waits
// for the players thouch to start the gameplay.
public class GameStart: SKScene, SKPhysicsContactDelegate
{
    // Here are the variables used in the screen
    var start:SKSpriteNode?
    var startPressed:SKSpriteNode?
    var background:SKSpriteNode?
    var shaderType:SKShader?
    var waterShader = WaterShader()
    
    // This functions loads the first elements on the screen
    // and add the effect of underwater movement.
    override public func sceneDidLoad()
    {
        physicsWorld.contactDelegate = self
        
        self.background = childNode(withName: "background") as? SKSpriteNode
        self.waterShader.applyWaterShader(To: self.background!)
        self.start = childNode(withName: "start") as? SKSpriteNode
        self.startPressed = childNode(withName: "startPressed") as? SKSpriteNode
        self.waterShader.applyWaterShader(To: self.start!)
    }
    
    // This function detects an array of nodes
    // when the player touches the screen.
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { self.touchDown(atPoint: t.location(in: self)) } }
    
    // This function receives the position of the players first touches.
    func touchDown(atPoint pos : CGPoint)
    {
        // Here i verify if the player touched the start button
        // to make the transition to the game play
        let node = self.nodes(at: pos)
        
        guard let startButton = self.start else { return }
        if node.contains(startButton)
        {
            self.start?.alpha = 0
            self.startPressed?.alpha = 1
        }
    }
    
    // This function is called everytime the touch interaction ends
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
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
}
