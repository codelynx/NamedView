# Provide you own store-ish properties on UIView

This project is created for the purpose in use of following article.

[名前付き UIView と後付けストアドプロパティもどき](https://qiita.com/codelynx/items/e7f197158e6471a0e33a)

This article demonstrate how to add 'stored-ish' properties for a certain classes such as `UIView`.  When you coding, sometime you may wish to have some properties to keep some information for your purpose.  But `UIView` for example, you may subclass to provide your own properties, but it could not not apply to all other `UIView` subclasses such as `UIButton` or `UIImageView`.


This sample code shows how to implement a 'stored-ish' property for a classes like `UIView`.  The reason I say 'stored-ish' because this technique is not really a stored property, but it acts like a stored property.

Here is an example of how to add a `name` string property to `UIView`.


```.swift
import UIKit

fileprivate var viewNameMap = NSMapTable<UIView, NSString>.weakToStrongObjects()

extension UIView {

    @IBInspectable dynamic public var name: String? {
        get {
            return viewNameMap.object(forKey: self) as String?
        }
        set {
            if let name = newValue {
                viewNameMap.setObject(name as NSString, forKey: self)
            }
            else {
                viewNameMap.removeObject(forKey: self)
            }
        }
    }

    public func view(named name: String) -> UIView? {
        if self.name == name {
            return self
        }
        for subview in self.subviews {
            if let view = subview.view(named: name) {
                return view
            }
        }
        return nil
    }
}
```

In this way, you may set any name to a `UIView` and it's subclasses.  By using `view(named:)` method to find any view in a view and it's subviews.  Therefore, you may set some names to some views in storyboard by using user runtime attributes, and can be accessed by name from your code.

It uses `NSMapTable.weakToStrongObjects()` to keep the relationship between `UIView` and `NSString` when assigned, then this relationship will be released around the same time with the `UIView` is being released.



Here is an another example of providing `configuration` dictionary property. 


```.swift
import UIKit

fileprivate var viewDictionaryMap = NSMapTable<UIView, NSDictionary>.weakToStrongObjects()

extension UIView {
    public var configuration: NSDictionary? {
        get {
            return viewDictionaryMap.object(forKey: self)
        }
        set {
            if let newValue = newValue {
                viewDictionaryMap.setObject(newValue, forKey: self)
            }
            else {
                viewDictionaryMap.removeObject(forKey: self)
            }
        }
    }
}
```

Thus you may add some stored-ish properties on your own, but be aware that Apple may provide the same property name in the future version of iOS, so try name them unique when possible.


Here is the version information at the time of writing.

```.console
Xcode Version 11.3 (11C29)
$ swift --version
Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
Target: x86_64-apple-darwin19.0.0

```
