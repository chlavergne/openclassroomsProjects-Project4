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
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(actionSwipeGesture(recognizer:)))
            swipeGesture.direction = .up
            self.frameView.addGestureRecognizer(swipeGesture)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        button.setImage(image, for: .normal)
        button.subviews.first?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    
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
    
    private func share() {
        let shareScreen = UIActivityViewController(activityItems: [], applicationActivities: [])
        present(shareScreen, animated: true)
    }
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
}

