//
//  HelperFunctions.swift
//  Hospital
//
//  Created by Shridhar on 1/30/17.
//
//

import Foundation
import UIKit
import Contacts
import AddressBook
import MessageUI


public func installWrapContentLayoutConstraints(_ superview : UIView, childView : UIView) {
    
    childView.translatesAutoresizingMaskIntoConstraints = false
    
    //Center child w.r.t to superview. This is to make childView start from 0(left) w.r.t to superview
    superview.addConstraint(NSLayoutConstraint(
        item: childView,
        attribute: NSLayoutAttribute.centerX,
        relatedBy: NSLayoutRelation.equal,
        toItem: superview,
        attribute: NSLayoutAttribute.centerX,
        multiplier: 1.0,
        constant: 0.0))
    
    //Center child w.r.t to superview. This is to make childView start from 0(top) w.r.t to superview
    superview.addConstraint(NSLayoutConstraint(
        item: childView,
        attribute: NSLayoutAttribute.centerY,
        relatedBy: NSLayoutRelation.equal,
        toItem: superview,
        attribute: NSLayoutAttribute.centerY,
        multiplier: 1.0,
        constant: 0.0))
    
    //Make child's width same as superview's width
    superview.addConstraint(NSLayoutConstraint(
        item: childView,
        attribute: NSLayoutAttribute.width,
        relatedBy: NSLayoutRelation.equal,
        toItem: superview,
        attribute: NSLayoutAttribute.width,
        multiplier: 1.0,
        constant: 0.0))
    
    //Make child's height same as superview's height
    superview.addConstraint(NSLayoutConstraint(
        item: childView,
        attribute: NSLayoutAttribute.height,
        relatedBy: NSLayoutRelation.equal,
        toItem: superview,
        attribute: NSLayoutAttribute.height,
        multiplier: 1.0,
        constant: 0.0))
}

public func isPortrait() -> Bool{
    return UIInterfaceOrientationIsPortrait(UIApplication.shared.statusBarOrientation)
}

public func isLandscape() -> Bool{
    return UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
}

public func createFolderAtPathIfNotExists(folderPath : String){
    var isDir : ObjCBool = false
    
    if( FileManager.default.fileExists(atPath: folderPath, isDirectory: &isDir) == false){
        do {
            try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
        } catch _ {
        }
    }
}

public func isValidEmailID(checkString : String?) -> Bool{
    let stricterFilterString : String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    let emailTest : NSPredicate = NSPredicate(format: "SELF MATCHES %@", stricterFilterString)
    return emailTest.evaluate(with: checkString)
}

public func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    return documentsFolderPath
}

// Get path for a file in the directory
public func fileInDocumentsDirectory(filename: String) -> String {
    
    let writePath = (documentsDirectory() as NSString).appendingPathComponent("Contacts")
    
    if (!FileManager.default.fileExists(atPath: writePath)) {
        do {
            try FileManager.default.createDirectory(atPath: writePath, withIntermediateDirectories: false, attributes: nil) }
        catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    return (writePath as NSString).appendingPathComponent(filename)
}


public func isValidPassword(checkString : String?) -> Bool{
    if(checkString!.characters.count>=6)
    {
        return true
        //        let pwdRegEx = "^.*(?=.{6,})(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$"
        //        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegEx)
        //        return pwdTest.evaluateWithObject(checkString)
    }
    else
    {
        return false
    }
    
}


public func showNetworkActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
}

public func hideNetworkActivityIndicator(){
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
}

public func failAssert() {
    assert(0 != 0, "")
}

public func failAssertWithMsg(msg : String) {
    assert(0 != 0, msg)
}

public func intToString(value : Int) -> String{
    return String(format: "%d", value)
}

public func int32ToString(value : Int32) -> String{
    return String(format: "%ld", value)
}

public func floatToString(value : Float) -> String{
    return String(format: "%f", value)
}

public func sizeOfWindowWrtEye() -> CGSize{
    return (UIApplication.shared.delegate?.window??.bounds.size)!
}

public func degreesToRadians(deg : Int) -> CGFloat {
    return CGFloat(deg) * CGFloat(M_PI) / 180.0
}

public func scaleImageWithRespectToSize(image : UIImage, newSize : CGSize) -> UIImage! {
    var scaledSize = CGSize(width: 0, height: 0)
    scaledSize.width = ceil(newSize.width);
    scaledSize.height = ceil(newSize.height);
    
    if(Float(fabs((image.size.width / image.size.height) - (scaledSize.width / scaledSize.height))) == FLT_EPSILON){
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions( scaledSize, false, 0.0 );
    let scaledImageRect = CGRect(x: 0, y: 0, width: scaledSize.width, height: scaledSize.height)
    image.draw(in: scaledImageRect);
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

func getImageHeightWithRespectWidth(imageName: String?, maxWidth: CGFloat) -> CGFloat {
    if isEmptyString(string: imageName) || maxWidth == 0 {
        return 0
    }
    
    let image = UIImage(named: imageName!)
    return getImageHeightWithRespectWidth(image: image, maxWidth: maxWidth)
}

func getImageHeightWithRespectWidth(image: UIImage?, maxWidth: CGFloat) -> CGFloat {
    if image == nil {
        return 0
    }
    
    let imageSize = image!.size
    let aspectRatio = imageSize.width / imageSize.height
    return maxWidth / aspectRatio
}

public func printAllFonts() {
    for fontFamilyNames in UIFont.familyNames {
        for fontName in UIFont.fontNames(forFamilyName: fontFamilyNames) {
            print("FONTNAME:\(fontName)")
        }
    }
}

public func isAvailable9Version() -> Bool {
    if #available(iOS 9, *) {
        return true
    } else {
        return false
    }
}

func addHeaderSeperator(tableView: UITableView) {
    let px = 1 / UIScreen.main.scale
    let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
    let line: UIView = UIView(frame: frame)
    tableView.tableHeaderView = line
    line.backgroundColor = tableView.separatorColor
    
}


public func isEmptyString(string : String?) -> Bool {
    if string == nil {
        return true
    }
    
    return string!.isEmpty
}

func showAlrt(fromController: UIViewController, title: String?, message: String?, cancelText: String?, cancelAction: (()-> ())?, otherText: String?, action: (()-> ())?) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    
    if isEmptyString(string: cancelText) == false {
        alert.addAction(UIAlertAction(title: cancelText, style: UIAlertActionStyle.cancel, handler: { (alertAction) in
            cancelAction?()
        }))
    }
    
    if isEmptyString(string: otherText) == false {
        alert.addAction(UIAlertAction(title: otherText, style: UIAlertActionStyle.default, handler: { (alertAction) in
            action?()
        }))
    }
    
    fromController.present(alert, animated: true, completion: nil)
}

func notificationRegisterCheck() ->Bool {
    
    if (UIApplication.shared.isRegisteredForRemoteNotifications) == true {
        
        return true
    }
    else {
        return false
    }
}

func validateUrl (urlString: String?) -> Bool {
    let urlRegEx = "((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    
    print(NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString))
    
    return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
}

func sizeOfText(string:String , textView:UITextView) -> CGFloat{
    let fixedWidth = textView.frame.size.width
    textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    var newFrame = textView.frame
    newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    if newFrame.size.height <= 42.0 {
        return 42.0
    }else{
        return newFrame.size.height
    }
    
}

extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

