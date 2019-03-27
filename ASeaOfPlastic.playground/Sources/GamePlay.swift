import GameplayKit
import SpriteKit
import CoreMotion
import AVFoundation
import PlaygroundSupport

// This global variable is used to verify if the player
// alredy completed the onboarding
var firstTimePlaying = true

// The class below controls the game play functions
public class GamePlay: SKScene, SKPhysicsContactDelegate
{
    // Here i create the variables of the nodes there are going to be used in the scene
    var player:SKSpriteNode?
    var playerShade:SKSpriteNode?
    var rightButton:SKSpriteNode?
    var leftButton:SKSpriteNode?
    var onboard:SKSpriteNode?
    var emitter:SKEmitterNode?
    var limiter1:SKSpriteNode?
    var limiter2:SKSpriteNode?
    var elements = [SKSpriteNode]()
    var backgroundFrames = [SKSpriteNode]()
    var waterShader = WaterShader()
    var plasticSound = AVAudioPlayer()
    
    // These variables below are used to store the backgrounds
    // to make the infinity movement effect
    var firstPlan:SKSpriteNode?
    var secondPlan:SKSpriteNode?
    var thirdPlan:SKSpriteNode?
    
    // Here i created some variables that will help to setup the game configurations
    var motionManager:CMMotionManager?
    var shaderType:SKShader?
    var timeDuration:Double = 0.1
    var movimentationVector:CGFloat = 300
    var maxSpeed:CGFloat = 500
    var sizeOfJellyfish:CGFloat = 100
    var playerLife:Int = 4
    var sizeMultiplier:CGFloat = 1.8
    var onboardingParts:Int = 0
    var onboard2:Bool = false
    
    // MARK: First load of the scene
    // This function is called when the view is initialized
    override public func sceneDidLoad()
    {
        // The line below adds the delegate to the physisc world used
        physicsWorld.contactDelegate = self
        
        // These lines limit the movement of the player on the scene
        self.limiter1?.physicsBody?.collisionBitMask = BitMask.player
        self.limiter2?.physicsBody?.collisionBitMask = BitMask.player
        
        //************************************************************************
        self.rightButton = childNode(withName: "rightButton") as? SKSpriteNode
        self.leftButton = childNode(withName: "leftButton") as? SKSpriteNode
        self.limiter1 = childNode(withName: "limiter1") as? SKSpriteNode
        self.limiter2 = childNode(withName: "limiter2") as? SKSpriteNode
        //************************************************************************
        
        // Here i set the properties of my particle emitter
        // to give the impression of underwater movement
        self.emitter = SKEmitterNode.init(fileNamed: "WaterParticles.sks")
        self.emitter?.position = CGPoint(x: 0, y: 80)
        self.addChild(self.emitter!)
        
        // Here i set the properties of the player
        self.player = childNode(withName: "player") as? SKSpriteNode
        self.player?.name = "player"
        self.player?.physicsBody?.linearDamping = 10
        self.player?.physicsBody?.categoryBitMask = BitMask.player
        self.player?.physicsBody?.contactTestBitMask = BitMask.harmful | BitMask.jellyfish
        self.player?.physicsBody?.collisionBitMask = BitMask.player
        self.waterShader.applyWaterShader(To: player!)
        self.playerShade = self.player?.childNode(withName: "playerShade") as? SKSpriteNode
        self.playerShade?.alpha = 0
        
        // In these lines the motion manager is being setting up
        self.motionManager = CMMotionManager()
        self.motionManager!.startAccelerometerUpdates()
        self.motionManager?.accelerometerUpdateInterval = 1 / 60
        self.motionManager?.gyroUpdateInterval = 1 / 60
        
        // In this verification I want to know if it's the
        // first time the player is playing the game
        if firstTimePlaying
        {
            // In these lines i'm doing the setup for the onboard instructions
            self.onboard = childNode(withName: "onboard") as? SKSpriteNode
            self.onboard?.texture = SKTexture(imageNamed: "onboard1")
            self.onboard?.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.fadeIn(withDuration: 2)])), withKey: "firstMessage")
        }
        
        // Generation of the first jellyfish in the screen
        self.generateRandomElement(ofType: 0)
        
        // This function is used to set up background on the screen
        self.generateBackground()
    }
    
    // MARK: Contact between two physics bodies
    // The code below is executed everytime a contact
    // between to physics bodies happens
    public func didBegin(_ contact: SKPhysicsContact)
    {
        // Here I verify if the player hit's a harmful or a harmelles
        // element and if so, I remove it from the scene
        if verifyContact(contact, byNameA: "player", nameB: "plastic")
        {
            do
            {
                plasticSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "plasticSound", ofType: "mp3")!))
                plasticSound.prepareToPlay()
                plasticSound.volume = 0.2
            }
            catch {}
            plasticSound.play()
            
            if self.elements.count > 0 { self.elements.removeFirst() }
            if contact.bodyA.node?.name == "plastic" { contact.bodyA.node?.removeFromParent() }
            else { contact.bodyB.node?.removeFromParent() }
            
            contact.bodyA.node!.run(SKAction.sequence([.fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2),
                                                       .fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2),
                                                       .fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2)]))
            self.movimentationVector -= 50
            self.playerShade?.run(SKAction.fadeAlpha(by: 0.25, duration: 0.5))
            
            if self.playerLife == 0 { self.gameEnd() }
            if self.playerLife != 0 { self.playerLife -= 1 }
        }
        else if verifyContact(contact, byNameA: "player", nameB: "straw")
        {
            do
            {
                plasticSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "strawSound", ofType: "mp3")!))
                plasticSound.prepareToPlay()
                plasticSound.volume = 0.1
            }
            catch {}
            plasticSound.play()
            
            if self.elements.count > 0 { self.elements.removeFirst() }
            if contact.bodyA.node?.name == "straw" { contact.bodyA.node?.removeFromParent() }
            else { contact.bodyB.node?.removeFromParent() }
            
            contact.bodyA.node!.run(SKAction.sequence([.fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2),
                                                       .fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2),
                                                       .fadeOut(withDuration: 0.2),
                                                       .fadeIn(withDuration: 0.2)]))
            self.movimentationVector -= 50
            self.playerShade?.run(SKAction.fadeAlpha(by: 0.25, duration: 0.5))
            
            if self.playerLife == 0 { self.gameEnd() }
            if self.playerLife != 0 { self.playerLife -= 1 }
        }
        else if verifyContact(contact, byNameA: "player", nameB: "jellyfish")
        {
            do
            {
                plasticSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "jellyfishSound", ofType: "mp3")!))
                plasticSound.prepareToPlay()
                plasticSound.volume = 0.2
            }
            catch {}
            plasticSound.play()
            
            if self.elements.count > 0 { self.elements.removeFirst() }
            if contact.bodyA.node?.name == "jellyfish"{ contact.bodyA.node?.removeFromParent() }
            else { contact.bodyB.node?.removeFromParent() }
            self.onboardingParts += 1
            if self.playerLife < 4
            {
                self.playerShade?.run(SKAction.fadeAlpha(by: -0.25, duration: 0.5))
                self.movimentationVector += 50
                self.playerLife += 1
            }
        }
    }
    
    // This function is celled everytime the touch interaction begins
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { for t in touches { self.touchDown(atPoint: t.location(in: self)) } }
    
    // This function receives the position of the players first touch on the screen
    func touchDown(atPoint pos : CGPoint)
    {
        // Here i verify the positions of the touchs to know
        // if he needs to go right or left
//        let node = self.nodes(at: pos)
    }
    
    // This function is called everytime the touch interaction ends
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { touchUp(atPoint: t.location(in: self)) } }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    { for t in touches { touchUp(atPoint: t.location(in: self)) } }
    
    // This function receives the position of the players last touch on the screen
    func touchUp(atPoint pos : CGPoint)
    {
    }
    
    // MARK: Update function
    // This function is called at every frame
    override public func update(_ currentTime: TimeInterval)
    {
        // Here i verify if a new node should be created and what's it's type
        if let lastElement = self.elements.last
        {
            if lastElement.position.y < 0.0 && self.onboardingParts < 5 && firstTimePlaying
            {
                self.generateRandomElement(ofType: 0)
            }
            else if lastElement.position.y < 0.0 && (self.onboardingParts >= 10 || !firstTimePlaying)
            {
                self.onboard?.run(SKAction.fadeOut(withDuration: 0.5))
                self.onboard?.removeAllActions()
                self.onboard?.isHidden = true
                self.generateRandomElement(ofType: Int.random(in: 0..<3))
                self.generateRandomElement(ofType: Int.random(in: 0..<3))
            }
            else if lastElement.position.y < 0.0 && (self.onboardingParts >= 5 || !firstTimePlaying)
            {
                self.generateRandomElement(ofType: Int.random(in: 0..<3))
                self.generateRandomElement(ofType: Int.random(in: 0..<3))
            }
        }
        
        if self.elements.count == 0 {self.generateRandomElement(ofType: Int.random(in: 0..<3))}
        
        // If the player finished the onboarding, the game starts
        if self.onboardingParts >= 5 && self.onboardingParts < 10 && !self.onboard2 && firstTimePlaying
        {
            self.onboard2 = true
            self.onboard?.run(SKAction.fadeOut(withDuration: 0.5))
            self.onboard?.removeAllActions()
            self.onboard?.texture = SKTexture(imageNamed: "onboard2")
            self.onboard?.run(SKAction.repeatForever(SKAction.sequence([SKAction.fadeOut(withDuration: 2), SKAction.fadeIn(withDuration: 2)])))
        }

        // This verification is used to know if the game should end
        if self.onboardingParts >= 40 { gameFinal() }

        // Know i make some animations to look like the elements are passing by
        if let element = self.elements.first
        {
            if element.position.y < -190.0
            {
                self.elements.first?.run(SKAction.resize(toWidth: self.elements.first!.frame.width*1.8,
                                                         height: self.elements.first!.frame.height*1.8, duration: 3))
            }
        }
        // In the code below i verify if the nodes are
        // out of the screen and should be removed
        if let element = self.elements.first
        {
            if element.position.y <= -480.0
            {
                if self.elements.first?.name == "plastic" || self.elements.first?.name == "straw"
                { self.onboardingParts += 1 }
                self.elements.first?.removeFromParent()
                self.elements.removeFirst()
            }
        }
        
        // The three verifications below will asure that the backgroud
        // is going to be removed after it leaves the screen
        if self.backgroundFrames[2].position.y <= -575.0 { self.changeOrderOfBackground(ofNumber: 1) }
        if self.backgroundFrames[1].position.y <= -575.0 { self.changeOrderOfBackground(ofNumber: 2) }
        if self.backgroundFrames[0].position.y <= -575.0 { self.changeOrderOfBackground(ofNumber: 3) }
        
        // In these lines below i control the player's velocity
        // and limits on the screen
        if self.player!.physicsBody!.velocity.dx > self.maxSpeed && self.player!.physicsBody!.velocity.dx > 0
        { self.player?.physicsBody?.velocity.dx = self.maxSpeed }
        else if self.player!.physicsBody!.velocity.dx < -self.maxSpeed && self.player!.physicsBody!.velocity.dx < 0
        { self.player?.physicsBody?.velocity.dx = -self.maxSpeed }
        
        // Here i verify if the user is moving the iPad
        // and if he is using it in landscape right or left
        
        if let accelerometerData = motionManager?.accelerometerData {
            if accelerometerData.acceleration.x < 0
            {
                if accelerometerData.acceleration.y <= -0.1
                {
                    let goRight = SKAction.applyForce(CGVector(dx: self.movimentationVector, dy: 0), duration: self.timeDuration)
                    self.player?.run(goRight)
                }
                else if accelerometerData.acceleration.y >= 0.1
                {
                    let goLeft = SKAction.applyForce(CGVector(dx: -self.movimentationVector, dy: 0), duration: self.timeDuration)
                    self.player?.run(goLeft)
                }
            }
            else if accelerometerData.acceleration.x > 0
            {
                if accelerometerData.acceleration.y <= -0.1
                {
                    let goLeft = SKAction.applyForce(CGVector(dx: -self.movimentationVector, dy: 0), duration: self.timeDuration)
                    self.player?.run(goLeft)
                }
                else if accelerometerData.acceleration.y >= 0.1
                {
                    let goRight = SKAction.applyForce(CGVector(dx: self.movimentationVector, dy: 0), duration: self.timeDuration)
                    self.player?.run(goRight)
                }
            }
        }
    }
    
    // MARK: Lose the game transition
    // This function is called when the player lose the game
    func gameEnd()
    {
        let reveal = SKTransition.crossFade(withDuration: 1.5)
        if let gameScene = GameEnd(fileNamed: "GameEnd"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    // MARK: Finish game transition
    // This function is called when the player finishes the game
    func gameFinal()
    {
        firstTimePlaying = false
        let reveal = SKTransition.crossFade(withDuration: 1.5)
        if let gameScene = GameFinal(fileNamed: "GameFinal"){
            gameScene.scaleMode = .aspectFill
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    // MARK: Verify contact between physics bodies
    // This function was created to verify the contact on both bodies
    // to make the comparisons more intuitives
    func verifyContact(_ contact: SKPhysicsContact?, byNameA nameA: String?, nameB: String?) -> Bool {
        return (contact?.bodyA.node?.name?.isEqual(nameA) ?? false && contact?.bodyB.node?.name?.isEqual(nameB) ?? false) || (contact?.bodyA.node?.name?.isEqual(nameB) ?? false && contact?.bodyB.node?.name?.isEqual(nameA) ?? false)
    }
}
