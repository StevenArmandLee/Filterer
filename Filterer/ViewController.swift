//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    var colour: String = ""
   // var rgb: RGBAImage
    
    
    

    
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet var sliderEditView: UIView!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var filteredImageView: UIImageView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var filterButton: UIButton!
    var originalImage: UIImage?
    
    @IBOutlet weak var contrastSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        originalImage = imageView.image!
        compareButton.enabled = false
        filteredImageView.alpha = 0.0
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        hideSecondaryMenu()
        hideSliderView()
        editButton.selected = false
        filterButton.selected = false
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        hideSecondaryMenu()
        hideSliderView()
        editButton.selected = false
        filterButton.selected = false
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onEdit(sender: UIButton) {
        if (sender.selected) {
            hideSliderView()
            sender.selected = false
        } else {
            showSliderView()
            hideSecondaryMenu()
            filterButton.selected = false
            sender.selected = true
        }    }
    
    func showSliderView()
    {
        view.addSubview(sliderEditView)
        sliderEditView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = sliderEditView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderEditView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderEditView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = sliderEditView.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        view.layoutIfNeeded()
        self.sliderEditView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderEditView.alpha = 1.0
        }
        sliderEditView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)

    }
    
    func hideSliderView()
    {
        UIView.animateWithDuration(0.4, animations: {
            self.sliderEditView.alpha = 0
        }) { completed in
            if completed == true {
                self.sliderEditView.removeFromSuperview()
            }
        }
    }
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            originalImage = image
            filteredImageView.image = image
            compareButton.enabled = false
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        filterPreview()
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            hideSliderView()
            sender.selected = true
            editButton.selected = false
        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    func changeImage(isShowOriginal: Bool){
        if isShowOriginal{
            
            UIView.animateWithDuration(0.4) {
                self.imageView.alpha = 1.0
                self.filteredImageView.alpha = 0.0
                self.originalLabel.alpha = 0.4
                
            }
            
        } else {
            
            
            UIView.animateWithDuration(0.4) {
                self.imageView.alpha = 0.0
                self.filteredImageView.alpha = 1.0
                self.originalLabel.alpha = 0.0
                
            }
        }
    }
    
    
    @IBAction func touchDown(sender: AnyObject) {
        changeImage(true)
    }
    
    @IBAction func upInside(sender: AnyObject) {
        changeImage(false)
        
    }
    
    @IBAction func onSlide(sender: UISlider) {
        var filteredImage = originalImage
        var filter = Filter(image: filteredImage!)
        filter.applyFilter(colour, contrastValue: sender.value)
        filteredImageView.image = filter.image
    }
    @IBAction func onFilterColor(sender: UIButton) {
        var filteredImage = originalImage
        var filter = Filter(image: filteredImage!)
        UIView.animateWithDuration(0.4) {
            self.filteredImageView.alpha = 0.0
            
        
                switch sender.currentTitle!{
                case "Red":
                    filter.applyFilter("red", contrastValue: self.contrastSlider.value)
                    self.filteredImageView.image = filter.image
                    self.colour = "red"
                case "Green":
                    filter.applyFilter("green", contrastValue: self.contrastSlider.value)
                    self.filteredImageView.image = filter.image
                    self.colour = "green"
                case "Yellow":
                    filter.applyFilter("yellow", contrastValue: self.contrastSlider.value)
                    self.filteredImageView.image = filter.image
                    self.colour = "yellow"
                case "Blue":
                    filter.applyFilter("blue", contrastValue: self.contrastSlider.value)
                    self.filteredImageView.image = filter.image
                    self.colour = "blue"
                case "Purple":
                    filter.applyFilter("purple", contrastValue: self.contrastSlider.value)
                    self.filteredImageView.image = filter.image
                    self.colour = "purple"
            default:
                break
            
            }
           self.filteredImageView.alpha = 1.0
        }
        
        compareButton.enabled = true
        editButton.enabled = true
        changeImage(false)
    }
    
    func filterPreview()
    {
        var red = originalImage
        var redFilter = Filter(image: red!)
        redFilter.applyFilter("red", contrastValue: 1.0)
        redButton.setImage(redFilter.image, forState: UIControlState.Normal)
        
        var green = originalImage
        var greenFilter = Filter(image: green!)
        greenFilter.applyFilter("green", contrastValue: 1.0)
        greenButton.setImage(greenFilter.image, forState: UIControlState.Normal)
        
        var yellow = originalImage
        var yellowFilter = Filter(image: yellow!)
        yellowFilter.applyFilter("yellow", contrastValue: 1.0)
        yellowButton.setImage(yellowFilter.image, forState: UIControlState.Normal)
        
        var blue = originalImage
        var blueFilter = Filter(image: blue!)
        blueFilter.applyFilter("blue", contrastValue: 1.0)
        blueButton.setImage(blueFilter.image, forState: UIControlState.Normal)
        
        var purple = originalImage
        var purpleFilter = Filter(image: purple!)
        purpleFilter.applyFilter("purple", contrastValue: 1.0)
        purpleButton.setImage(purpleFilter.image, forState: UIControlState.Normal)
        
        
    }
    

}

