import UIKit

public class PlaceHolderTextView: UITextView {
    
    var placeHolderLabel: UILabel = UILabel()
    var placeHolderColor: UIColor = UIColor.lightGray
    var placeHolder: NSString = ""
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // placeHolderを描画する
    override public func draw(_ rect: CGRect) {
        if (placeHolder.length > 0) {
            placeHolderLabel.frame = CGRect(x: 8, y: 8, width: self.bounds.size.width - 16 , height: 0)
            placeHolderLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            placeHolderLabel.numberOfLines = 0
            placeHolderLabel.font = self.font
            placeHolderLabel.backgroundColor = UIColor.clear
            placeHolderLabel.textColor = self.placeHolderColor
            placeHolderLabel.alpha = 0
            placeHolderLabel.tag = 1
            placeHolderLabel.text = self.placeHolder as String
            placeHolderLabel.sizeToFit()
            self.addSubview(placeHolderLabel)
        }
        
        self.sendSubviewToBack(placeHolderLabel)
        
        if (self.text.utf16.count == 0 && self.placeHolder.length > 0) {
            self.viewWithTag(1)?.alpha = 1
        }
        
        super.draw(rect)
    }
    
    // テキストが1文字以上入力されたらプレースホルダーを隠す
    @objc func textChanged(notification:NSNotification?) -> (Void) {
        if (placeHolder.length == 0) {
            return
        }
        
        if (self.text.utf16.count == 0) {
            self.viewWithTag(1)?.alpha = 1
        } else {
            self.viewWithTag(1)?.alpha = 0
        }
    }
}
