//
//  ViewController.swift
//  CuteLittleXylophone
//
//  Created by parag on 20/12/24.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
  
    var avPlayer:AVAudioPlayer? = nil
    //230
    private let ITEMSIZE = 100;
    private let TOTALITEM = 7
   // rgba(230, 126, 34,1.0)
   
    func getRGBAFromString(red:Double,green:Double,Blue:Double) ->  UIColor{
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(Blue), alpha: 1)
    }
    
    var keyColor:[UIColor] =  [.red,.orange,.yellow,.green,.blue,.purple,.magenta]
   
    let keyTitle = ["A","B","C","D","E","F","G"]
    var ScrollView = UIScrollView()
    
    func rectViews(title:String) -> UIButton {
        let rect1 = UIButton();
        
        let lable = UILabel()
        lable.textColor = .white;
        lable.font = UIFont.systemFont(ofSize: 22, weight: .bold);
        lable.text = title
        rect1.translatesAutoresizingMaskIntoConstraints = false
        rect1.heightAnchor.constraint(equalToConstant: CGFloat(ITEMSIZE)).isActive  = true;
        rect1.layer.cornerRadius = 8;
        rect1.backgroundColor = .lightGray
        rect1.setTitle(lable.text, for: .normal)
      
        rect1.addAction(UIAction {[weak self] _ in
            self?.onKeyPressPlaySound(key: title,rect1: rect1)
        }, for: .touchUpInside)
   
        rect1.addAction(UIAction {[weak self] _ in self?.onReleaseKeyPress(rect1)}, for: .touchCancel)
        
        return rect1
    }

 
    func onReleaseKeyPress(_ rect1:UIButton){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          UIView.animate(withDuration: 0.5) {
             rect1.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }
        }
    }
    
    func onJumpKeyPress(_ rect1:UIButton){
        UIView.animate(withDuration: 0.5) {
            rect1.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }
       
    }
    
    //play sound based on key
    func onKeyPressPlaySound(key:String, rect1:UIButton){
        //load sound from bundle
        if let sound = Bundle.main.url(forResource: key, withExtension: "wav"){
            do{
                onJumpKeyPress(rect1)
                avPlayer =  try AVAudioPlayer(contentsOf: sound)
                avPlayer?.prepareToPlay()
                avPlayer?.play()
                onReleaseKeyPress(rect1)
                
            }catch{
                print("Something went wrong!!")
            }
        }
    }
    
    let VStack:UIStackView = {
        let stack = UIStackView();
        stack.axis = .vertical;
        stack.spacing = 10;
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func keyWidth(index:Int) -> CGFloat{
        if(index > 1){
            return CGFloat(index) * 20
        }
        return index == 0 ? 20 : 30
            
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(ScrollView)
//        keyColor =  [.red,getRGBAFromString(red: 230, green: 126, Blue: 34.1) ,.yellow,.green,.blue,.purple,.magenta]
       for i in 0 ..< TOTALITEM{
           let rect = rectViews(title:keyTitle[i])
          
           rect.backgroundColor = keyColor[i]
           rect.widthAnchor.constraint(equalToConstant:view.frame.width - keyWidth(index: i)).isActive = true
           
           VStack.addArrangedSubview(rect)
       }
      
        ScrollView.addSubview(VStack)
        
       ScrollView.translatesAutoresizingMaskIntoConstraints = false;
       
       ScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       ScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        ScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
       ScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       ScrollView.showsVerticalScrollIndicator = false
       VStack.centerXAnchor.constraint(equalTo: ScrollView.centerXAnchor).isActive = true
      
       ScrollView.contentSize.height = CGFloat(ITEMSIZE * TOTALITEM)
        
        ScrollView.contentInset.bottom = CGFloat(ITEMSIZE)
        
    }


}


#Preview{
    ViewController()
}
