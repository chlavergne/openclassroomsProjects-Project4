//
//  ViewController.swift
//  Instagrid
//
//  Created by Christophe Expleo on 03/05/2021.
//

import UIKit

class ViewController: UIViewController {

    //  4 buttons in FrameView
    private var button: UIButton!

    private var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(afterSwipeGesture(recognizer:)))

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

    // action to pick an image in the gallery with the selected button
    @IBAction func chooseImage(_ sender: UIButton) {
        button = sender
        openGallery()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(afterSwipeGesture(recognizer:)))
        self.frameView.addGestureRecognizer(swipeGesture)
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGesture.direction = .left
        } else {
            swipeGesture.direction = .up
        }
    }

    //    change the direction of the swipe when detect a screen rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGesture.direction = .left

        } else {
            swipeGesture.direction = .up
        }
    }

    //  functions called after a swipe
    @objc func afterSwipeGesture(recognizer: UISwipeGestureRecognizer) {
        animView()
        share()
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
        let screenshot = renderer.image { _ in
            frameView.drawHierarchy(in: frameView.bounds, afterScreenUpdates: true)
        }
        let activityController = UIActivityViewController(activityItems: [screenshot], applicationActivities: nil)
        present(activityController, animated: true)
        activityController.completionWithItemsHandler = { (_, _, _, _) in
            UIView.animate(withDuration: 0.2, animations: {
                self.frameView.transform = .identity
            })
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //  choose an image from the gallery and assign it to the button
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]
        button.setImage(image as? UIImage, for: .normal)
        button.subviews.first?.contentMode = .scaleAspectFill
        picker.dismiss(animated: true, completion: nil)
    }
    private func openGallery() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
}
