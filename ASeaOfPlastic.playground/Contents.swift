//: A SpriteKit based Playground
import PlaygroundSupport
import SpriteKit
import AVFoundation

//:![title](aSeaOfPlastic.png)
//: # About:
//: ## This playground was created with the objective of introducing people to the actual state of our oceans. The intention of Art, our brave turtle who is defying those challenges in this little game, is to show people his point of view from our oceans, and how hard it relly is for a animal to survive in a enviroment like this. Turtles and many other sea animals suffer from our culture of disposable materials. So, let's join Art in a day in his life, so he can help us to undertand how important even a little straw could be.

//:# For a better experience this playground should run in landscape mode.

//: # This game has the objectives of:
//: ## - Show how easy it's for animals confuse plastic bags with food.
//: ## - Provide awareness about the harm that plastic materials can cause to the oceans.

//: Sound effects obtained from https://www.zapsplat.com

// Variable used to play the background sound
var backgroundSoundPlayer = AVAudioPlayer()

// The function instructions below are used to make the background sound
// play for an infinity amount of time.
do
{
    backgroundSoundPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "backgroundSound", ofType: "mp3")!))
    backgroundSoundPlayer.numberOfLoops = -1
    backgroundSoundPlayer.prepareToPlay()
} catch {}

// Load the SKScene from the GameStart class to start the game.
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640 , height: 480))
if let scene = GameStart(fileNamed: "GameStart")
{
    // Set the scale mode to fill the window
    scene.scaleMode = .aspectFill
    
    // Present the scene to player
    sceneView.presentScene(scene)
    // Start playing the background sound
    backgroundSoundPlayer.play()
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
