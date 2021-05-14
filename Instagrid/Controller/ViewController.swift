//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Expleo on 03/05/2021.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var button : UIButton!
    
    @IBOutlet weak var buttonWideTop: UIButton!
    @IBOutlet weak var buttonWideBottom: UIButton!
    @IBOutlet weak var buttonFourSquare: UIButton!
    @IBOutlet weak var frameView: FrameView!
    
    @IBAction func tapButtonWideTop(_ sender: UIButton) {
        frameView.style = .wideTop
        buttonWideTop.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    
    @IBAction func tapButtonWideBottom(_ sender: UIButton) {
        frameView.style = .wideBottom
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        buttonFourSquare.setImage(nil, for: .normal)
    }
    
    @IBAction func tapButtonFourSquare(_ sender: UIButton) {
        frameView.style = .fourSquare
        buttonWideTop.setImage(nil, for: .normal)
        buttonWideBottom.setImage(nil, for: .normal)
        buttonFourSquare.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        button = sender
        openGallery()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragFrameView(_:)))
        frameView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        button.setImage(image, for: .normal)
//        button.layoutIfNeeded() // Update subview layout to apply the scaleAspectFill
        button.subviews.first?.contentMode = .scaleAspectFill
//        button.setImage(nil, for: .normal) // Remove the cross image
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func dragFrameView(_ sender: UIPanGestureRecognizer){
        switch sender.state {
        case .began, .changed:
            transformFrameViewWith(gesture: sender)
        case .cancelled:
            frameView.transform = .identity
        case .ended:
            animView()
            share()
            
            print("")
        default:
            break
        }
    }
    
    private func transformFrameViewWith(gesture: UIPanGestureRecognizer){
        
        let translation = gesture.translation(in: frameView)
        frameView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
    }
    
    private func share() {
        let shareScreen = UIActivityViewController(activityItems: [], applicationActivities: [])
        present(shareScreen, animated: true)
    }
    private func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    private func animView() {
        let screenHeight = UIScreen.main.bounds.height //anim
        var translationTransform: CGAffineTransform // anim
        translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight) // anim
//        if translation.y < -screenHeight / 3 {  //Swipe need to reach 1/3 of the screen to be valid // anim
//            UIView.animate(withDuration: 0.6, animations: {self.frameView.transform = translationTransform}) // anim
//        }
    }
    
}

