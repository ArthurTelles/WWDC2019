import Foundation
import SpriteKit

// This class has a property to add a water shader
// effect to a node given as a parameter
public class WaterShader: SKScene
{
    var shaderType:SKShader?
    
    func applyWaterShader(To Node:SKSpriteNode)
    {
        let uniforms: [SKUniform] = [
            SKUniform(name: "u_speed", float: 3),
            SKUniform(name: "u_strength", float: 0.3),
            SKUniform(name: "u_frequency", float: 20)
        ]
        shaderType = SKShader(fileNamed: "waterShader.fsh")
        shaderType?.uniforms = uniforms
        Node.shader = shaderType
    }
}
