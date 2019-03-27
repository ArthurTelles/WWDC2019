import SpriteKit

// This extension controls the moviment of the brackground nodes
extension GamePlay
{
    // This function makes the first background animation
    // and adds the nodes to the array that controls then
    func generateBackground()
    {
        self.thirdPlan = childNode(withName: "thirdPlan") as? SKSpriteNode
        self.thirdPlan?.size = CGSize(width: 1024, height: 665)
        self.thirdPlan?.run(SKAction.moveTo(y: -900, duration: 10))
        self.thirdPlan?.run(SKAction.resize(toWidth: self.thirdPlan!.frame.width*self.sizeMultiplier, height: self.thirdPlan!.frame.height*self.sizeMultiplier, duration: 14))
        self.waterShader.applyWaterShader(To: self.thirdPlan!)
        self.backgroundFrames.append(self.thirdPlan!)
        
        self.secondPlan = childNode(withName: "secondPlan") as? SKSpriteNode
        self.secondPlan?.size = CGSize(width: 1024, height: 665)
        self.secondPlan?.run(SKAction.moveTo(y: -900, duration: 8))
        self.secondPlan?.run(SKAction.resize(toWidth: self.secondPlan!.frame.width*self.sizeMultiplier, height: self.secondPlan!.frame.height*self.sizeMultiplier, duration: 12))
        self.waterShader.applyWaterShader(To: self.secondPlan!)
        self.backgroundFrames.append(self.secondPlan!)
        
        self.firstPlan = childNode(withName: "firstPlan") as? SKSpriteNode
        self.firstPlan?.size = CGSize(width: 1024, height: 665)
        self.firstPlan?.run(SKAction.moveTo(y: -900, duration: 6))
        self.firstPlan?.run(SKAction.resize(toWidth: self.firstPlan!.frame.width*self.sizeMultiplier, height: self.firstPlan!.frame.height*self.sizeMultiplier, duration: 10))
        self.waterShader.applyWaterShader(To: self.firstPlan!)
        self.backgroundFrames.append(self.firstPlan!)
    }
    
    // This function keeps moving the backgrounds
    // in the right order when called in the update
    func changeOrderOfBackground(ofNumber background:Int)
    {
        if background == 1
        {
            self.firstPlan?.removeAllActions()
            self.firstPlan?.alpha = 0
            self.firstPlan?.position = CGPoint(x: 0, y: 0)
            self.firstPlan?.run(SKAction.fadeAlpha(to: 1, duration: 4))
            self.firstPlan?.size = CGSize(width: 1024, height: 665)
            self.firstPlan?.run(SKAction.moveTo(y: -900, duration: 10))
            self.firstPlan?.run(SKAction.resize(toWidth: self.firstPlan!.frame.width*self.sizeMultiplier, height: self.firstPlan!.frame.height*self.sizeMultiplier, duration: 10))
            self.secondPlan?.zPosition = -1
            self.thirdPlan?.zPosition = -2
            self.firstPlan?.zPosition = -3
        }
        else if background == 2
        {
            self.secondPlan?.removeAllActions()
            self.secondPlan?.alpha = 0
            self.secondPlan?.position = CGPoint(x: 0, y: 0)
            self.secondPlan?.run(SKAction.fadeAlpha(to: 1, duration: 4))
            self.secondPlan?.size = CGSize(width: 1024, height: 665)
            self.secondPlan?.run(SKAction.moveTo(y: -900, duration: 10))
            self.secondPlan?.run(SKAction.resize(toWidth: self.secondPlan!.frame.width*self.sizeMultiplier, height: self.secondPlan!.frame.height*self.sizeMultiplier, duration: 12))
            self.thirdPlan?.zPosition = -1
            self.firstPlan?.zPosition = -2
            self.secondPlan?.zPosition = -3
        }
        else
        {
            self.thirdPlan?.removeAllActions()
            self.thirdPlan?.alpha = 0
            self.thirdPlan?.position = CGPoint(x: 0, y: 0)
            self.thirdPlan?.run(SKAction.fadeAlpha(to: 1, duration: 4))
            self.thirdPlan?.size = CGSize(width: 1024, height: 665)
            self.thirdPlan?.run(SKAction.moveTo(y: -900, duration: 10))
            self.thirdPlan?.run(SKAction.resize(toWidth: self.thirdPlan!.frame.width*self.sizeMultiplier, height: self.thirdPlan!.frame.height*self.sizeMultiplier, duration: 14))
            self.firstPlan?.zPosition = -1
            self.secondPlan?.zPosition = -2
            self.thirdPlan?.zPosition = -3
        }
    }
}
