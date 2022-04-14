//
//  ViewController.swift
//  MatchEmScene
//
//  Created by Guest User on 3/22/22.
//

import UIKit

class MatchEmSceneViewController: UIViewController {

   
    // MARK: - ==== Config Properties ====
    //================================================
    // Min and max width and height for the rectangles
    private let rectSizeMin:CGFloat = 50.0
    private let rectSizeMax:CGFloat = 150.0
    private var randomAlpha = false
    private var fadeDuration: TimeInterval = 0.8
    // Rectangle creation interval
    private var newRectInterval: TimeInterval = 1.0
    // Rectangle creation, so the timer can be stopped
    private var newRectTimer: Timer?
    // Game duration
    private var gameDuration: TimeInterval = 12.0
    // Game timer
    private var gameTimer: Timer?
    private var gameInProgress = false
    private var gameTimeRemaining : TimeInterval = 10.0 {
    didSet { gameInfoLabel?.text = gameInfo }
    }
    
    // MARK: - ==== Internal Properties ====
    // Keep track of all rectangles created
    private var rectangles = [UIButton]()
    private var rectanglesClicked = [UIButton]()
    private var rectanglePairs: [UIButton: UIButton] = [:]
    // Counters, property observers used
    private var rectanglePairsCreated: Int = 0 {
    didSet { gameInfoLabel?.text = gameInfo } }
    private var rectanglesTouched: Int = 0 {
    didSet { gameInfoLabel?.text = gameInfo } }
    
    
   
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    private var gameInfo: String {
        let labelText = String(format: "Time Remaining:%2.1f \n Pairs Created:%2d \n Pairs Matched:%2d",
        gameTimeRemaining, rectanglePairsCreated, rectanglesTouched)
        return labelText
    }
    
    // MARK: - ==== View Controller Methods ====
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
    // Don't forget the call to super in these methods
    super.viewWillAppear(animated)
    // Create a single rectangle
        startGameRunning()
    }
    
    override var prefersStatusBarHidden: Bool {
    return true
    }
    
    @objc private func handleTouch(sender: UIButton) {
        
        if(!gameInProgress){
            return
        }
        
    sender.setTitle("🐱", for: .normal)
        
    rectanglesClicked.append(sender)
        
    print(rectanglesClicked.count)
        
    if(rectanglesClicked.count > 1){
        
        if(rectanglePairs[rectanglesClicked[0]] == sender || rectanglePairs[sender] == rectanglesClicked[0]){
            
            removeRectangle(rectangle: sender)
            removeRectangle(rectangle: rectanglesClicked[0])
            rectanglesClicked.remove(at: 1)
            rectanglesClicked.remove(at: 0)
            rectanglesTouched += 1;
            
        }
        
        else{
            
            sender.setTitle("", for: .normal)
            rectanglesClicked[0].setTitle("", for: .normal)
            rectanglesClicked.remove(at: 1)
            rectanglesClicked.remove(at: 0)
            
            print(rectanglesClicked.count)
            
        }
        
        
    }

    }
    
}

// MARK: - ==== Rectangle Methods ====
extension MatchEmSceneViewController {
//================================================
    private func createRectanglePair() {
        
        let randSize = Utility.getRandomSize(fromMin: rectSizeMin, throughMax: rectSizeMax)
        let randLocation1 = Utility.getRandomLocation(size: randSize, screenSize: view.bounds.size)
        let randLocation2 = Utility.getRandomLocation(size: randSize, screenSize: view.bounds.size)
        let randomFrame1 = CGRect(origin: randLocation1, size: randSize)
        let randomFrame2 = CGRect(origin: randLocation2, size: randSize)
            
        // Create a rectangle
        //let rectangleFrame = CGRect(x: 50, y: 150, width: 80, height: 40)
        let rectangle1 = UIButton(frame: randomFrame1)
        let rectangle2 = UIButton(frame: randomFrame2)

        let backgroundCol = Utility.getRandomColor(randomAlpha: randomAlpha)
        
        // Do some button/rectangle setup
        rectangle1.backgroundColor = backgroundCol
        rectangle1.setTitle("", for: .normal)
        rectangle1.setTitleColor(.black, for: .normal)
        rectangle1.titleLabel?.font = .systemFont(ofSize: 50)
        rectangle1.showsTouchWhenHighlighted = true

        rectangle1.addTarget(self,
        action: #selector(self.handleTouch(sender:)),
        for: .touchUpInside)
        
        rectangle2.backgroundColor = backgroundCol
        rectangle2.setTitle("", for: .normal)
        rectangle2.setTitleColor(.black, for: .normal)
        rectangle2.titleLabel?.font = .systemFont(ofSize: 50)
        rectangle2.showsTouchWhenHighlighted = true

        rectangle2.addTarget(self,
        action: #selector(self.handleTouch(sender:)),
        for: .touchUpInside)
        
        rectangles.append(rectangle1)
        rectangles.append(rectangle2)
        
        rectanglePairs[rectangle1] = rectangle2
        rectanglePairs[rectangle2] = rectangle1
        
        self.view.addSubview(rectangle1)
        self.view.addSubview(rectangle2)
        
        
        rectanglePairsCreated += 1;
        gameTimeRemaining -= newRectInterval
        
        view.bringSubviewToFront(gameInfoLabel!)
        
    }
    
func removeRectangle(rectangle: UIButton) {
// Rectangle fade animation
let pa = UIViewPropertyAnimator(duration: fadeDuration,curve: .linear,animations: nil)
pa.addAnimations {
rectangle.alpha = 0.0
}
pa.startAnimation()
}
    
//================================================
func removeSavedRectangles() {
// Remove all rectangles from superview
for rectangle in rectangles {
rectangle.removeFromSuperview()
}
// Clear the rectangles array
rectangles.removeAll()
}

    
}


// MARK: - ==== Timer Functions ====
extension MatchEmSceneViewController {
//================================================
private func startGameRunning()
{
    
//removeSavedRectangles()
gameInfoLabel.textColor = .black
gameInfoLabel.backgroundColor = .clear
gameInProgress = true;
// Timer to end the game
gameTimer = Timer.scheduledTimer(withTimeInterval: gameDuration,
repeats: false)
{ _ in self.stopGameRunning() }
    
// Timer to produce the rectangles
newRectTimer = Timer.scheduledTimer(withTimeInterval: newRectInterval,
repeats: true)
{ _ in self.createRectanglePair() }
}
    
//================================================
private func stopGameRunning() {
gameInfoLabel.textColor = .red
gameInfoLabel.backgroundColor = .black
//removeSavedRectangles()
gameInProgress = false;
// Stop the timer
if let timer = newRectTimer { timer.invalidate() }
// Remove the reference to the timer object
self.newRectTimer = nil
}
    
}

