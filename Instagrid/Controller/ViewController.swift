//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Expleo on 03/05/2021.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //  4 buttons in FrameView
    var button : UIButton!
    
    //  3 buttons for the display mode
    @IBOutlet weak var buttonWideTop: UIButton!
    @IBOutlet weak var buttonWideBottom: UIButton!
    @IBOutlet weak var buttonFourSquare: UIButton!
    
    @IBOutlet weak var frameView: FrameView!
    
    //  selection of the 3 possible display mode
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
    
    // action to pick an image in the gallery
    @IBAction func chooseImage(_ sender: UIButton) {
        button = sender
        openGallery()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipeGesture(recognizer:)))
        //        self.frameView.addGestureRecognizer(swipeGesture)
        //        swipeGesture.direction = .up
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipeGesture(recognizer:)))
        self.frameView.addGestureRecognizer(swipeGesture)
        if UIDevice.current.orientation.isPortrait {
            swipeGesture.direction = .up
        } else {
            swipeGesture.direction = .left
        }
    }
    
    //  choose an image from the gallery and assign it to the button
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        button.setImage(image, for: .normal)
        button.subviews.first?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    
    //  functions called after a swipe
    @objc func actionSwipeGesture(recognizer: UISwipeGestureRecognizer) {
        animView()
        share()
    }
    
    private func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //  animates FrameView after swipe based on screen orientation
    private func animView() {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        var translationTransform: CGAffineTransform
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        } else {
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeight)
        }
        UIView.animate(withDuration: 0.4, animations: {self.frameView.transform = translationTransform})
    }
    
    private func share() {
        let renderer = UIGraphicsImageRenderer(size: frameView.bounds.size)
        let screenshot = renderer.image {
            (context) in
            frameView.drawHierarchy(in: frameView.bounds, afterScreenUpdates: true)
        }
        let activityController = UIActivityViewController (activityItems: [screenshot], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            UIView.animate(withDuration: 0.2, animations: {
                self.frameView.transform = .identity
            })
        }
    }
}

