//
//  TitleScreen.swift
//  Super Mario Swift
//
//  Created by Channing Kuo on 2020/8/13.
//  Copyright © 2020 Channing Kuo. All rights reserved.
//

import SpriteKit

class TitleScreenScene: SKScene {
    
    fileprivate var backgroundNode: SKSpriteNode?
    
    fileprivate var pointsNode: SKLabelNode?
    fileprivate var coinsNode: SKLabelNode?
    fileprivate var levelNode: SKLabelNode?
    fileprivate var timeNode: SKLabelNode?
    
    fileprivate var logoNode: SKSpriteNode?
    
    fileprivate var levelSwitchNode: SKSpriteNode?
    fileprivate var recordNode: SKLabelNode?
    
    fileprivate var playerNode: SKSpriteNode?
    
    fileprivate var gameStates: GameStatesEnum?
    
    override func didMove(to view: SKView) {
        switch gameStates {
        case .newGame:
            setUpNewGameTitleScreen()
            setUpStaticNode()
            break
        case .loadingGame:
            setUpLoadingTitleScreen()
            setUpStaticNode()
            break
        case .timeOut:
            setUpGameFailedTimeOutTitleScreen()
            setUpStaticNode()
            break
        case .gameOver:
            setUpGameOverTitleScreen()
            setUpStaticNode()
            break
        default:
            return
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func setUpNewGameTitleScreen() {
        backgroundNode = SKSpriteNode(texture: Tools.genNewGameBackGroundTexture())
        backgroundNode!.size = CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN)
        backgroundNode!.position = CGPoint(x: 0, y: 0)
        backgroundNode!.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(backgroundNode!)

        pointsNode = Tools.genSKLabelNode(text: "000000", position: CGPoint(x: 160 + 10, y: Constants.H_SCREEN - 80), size: 30.0)
        self.addChild(pointsNode!)
        
        coinsNode = Tools.genSKLabelNode(text: "00", position: CGPoint(x: 330, y: Constants.H_SCREEN - 80), size: 30.0)
        self.addChild(coinsNode!)
        
        levelNode = Tools.genSKLabelNode(text: "1-1", position: CGPoint(x: Constants.W_SCREEN / 2 + 60, y: Constants.H_SCREEN - 80), size: 30.0)
        self.addChild(levelNode!)
        
        timeNode = Tools.genSKLabelNode(text: "", position: CGPoint(x: Constants.W_SCREEN - 160, y: Constants.H_SCREEN - 80), size: 30.0)
        self.addChild(timeNode!)
        
        logoNode = SKSpriteNode(texture: SKTexture(imageNamed: "Items/New_game_logo"))
        logoNode!.size = CGSize(width: 474, height: 235)
        logoNode!.position = CGPoint(x: (Constants.W_SCREEN - logoNode!.size.width) / 2, y: Constants.H_SCREEN - logoNode!.size.height - 88)
        logoNode!.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(logoNode!)
        
        recordNode = Tools.genSKLabelNode(text: "000000", position: CGPoint(x: Constants.W_SCREEN / 2 + 40, y: 90), size: 30.0)
        self.addChild(recordNode!)
        
        levelSwitchNode = SKSpriteNode(texture: SKTexture(imageNamed: "Items/Switch_play_number"))
        levelSwitchNode!.size = CGSize(width: 20, height: 20)
        levelSwitchNode!.position = CGPoint(x: Constants.W_SCREEN / 2 - 180, y: 200)
        levelSwitchNode!.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(levelSwitchNode!)
        
        playerNode = SKSpriteNode(texture: SKTexture(imageNamed: "Players/Player_type_1_1"))
        playerNode!.size = CGSize(width: 30, height: 40)
        playerNode!.position = CGPoint(x: 110, y: 64)
        playerNode!.anchorPoint = CGPoint(x: 0, y: 0)
        self.addChild(playerNode!)
        
        self.addChild(Tools.genSKLabelNode(text: "1 PLAYER GAME", position: CGPoint(x: Constants.W_SCREEN / 2, y: 200), size: 30.0))
        
        self.addChild(Tools.genSKLabelNode(text: "2 PLAYER GAME", position: CGPoint(x: Constants.W_SCREEN / 2, y: 150), size: 30.0))
        
        self.addChild(Tools.genSKLabelNode(text: "©1985 NINTENDO", position: CGPoint(x: Constants.W_SCREEN / 2 + 146, y: Constants.H_SCREEN - logoNode!.size.height - 88 - 20), size: 20.0))
        
        self.addChild(Tools.genSKLabelNode(text: "TOP-  ", position: CGPoint(x: Constants.W_SCREEN / 2 - 70, y: 90), size: 30.0))
    }
    
    func setUpStaticNode() {
        // left node
        self.addChild(Tools.genSKLabelNode(text: "MARIO", position: CGPoint(x: 160, y: Constants.H_SCREEN - 50), size: 30.0))
        
        let shinyCoinNode = SKSpriteNode(texture: SKTexture(imageNamed: "Coins/Coin_type_1_1"))
        shinyCoinNode.position = CGPoint(x: 270, y: Constants.H_SCREEN - 80)
        shinyCoinNode.anchorPoint = CGPoint(x: 0, y: 0)
        shinyCoinNode.size = CGSize(width: 15, height: 21)
        self.addChild(shinyCoinNode)
        
        // shiny coin animation
        let textures: Array<SKTexture> = (1..<3).map({return "Coins/Coin_type_1_\($0)"}).map(SKTexture.init)
        let action = { SKAction.animate(with: textures, timePerFrame: 0.3) }()
        let repeatAction = SKAction.repeatForever(action)
        shinyCoinNode.run(repeatAction)
        
        // coin static node
        self.addChild(Tools.genSKLabelNode(text: "x", position: CGPoint(x: 300, y: Constants.H_SCREEN - 80), size: 30.0))
        
        // center node
        self.addChild(Tools.genSKLabelNode(text: "WORLD", position: CGPoint(x: Constants.W_SCREEN / 2 + 60, y: Constants.H_SCREEN - 50), size: 30.0))
        
        // right node
        self.addChild(Tools.genSKLabelNode(text: "TIME", position: CGPoint(x: Constants.W_SCREEN - 160, y: Constants.H_SCREEN - 50), size: 30.0))
    }
    
    func setUpLoadingTitleScreen() {
        backgroundNode = SKSpriteNode(texture: Tools.cropTexture(imageNamed: "level_1_1", rect: CGRect(x: 0, y: 0, width: 0.080895513332592, height: 1)))
        
    }
    
    func setUpGameFailedTimeOutTitleScreen() {
        backgroundNode = SKSpriteNode(texture: Tools.cropTexture(imageNamed: "level_1_1", rect: CGRect(x: 0, y: 0, width: 0.080895513332592, height: 1)))
        
    }
    
    func setUpGameOverTitleScreen() {
        backgroundNode = SKSpriteNode(texture: Tools.cropTexture(imageNamed: "level_1_1", rect: CGRect(x: 0, y: 0, width: 0.080895513332592, height: 1)))
        
    }
    
    class func startNewGame() -> TitleScreenScene {
        let scene = TitleScreenScene(size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
        scene.gameStates = .newGame
        
        return scene
    }
    
    class func loadingGame() -> TitleScreenScene {
        let scene = TitleScreenScene(size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
        scene.gameStates = .loadingGame
        
        return scene
    }
    
    class func gameFailedByTimeOver() -> TitleScreenScene {
        let scene = TitleScreenScene(size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
        scene.gameStates = .timeOut
        
        return scene
    }
    
    class func gameOver() -> TitleScreenScene {
        let scene = TitleScreenScene(size: CGSize(width: Constants.W_SCREEN, height: Constants.H_SCREEN))
        scene.gameStates = .gameOver
        
        return scene
    }
}

#if os(OSX)
// Mouse-based event handling
extension TitleScreenScene {

    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
    }
}
#endif

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension TitleScreenScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
#endif
