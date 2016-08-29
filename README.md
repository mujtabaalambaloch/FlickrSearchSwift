# FlickrSearchSwift

**Note: This only runs on iOS 9+ Device**

To run simple open the **FlickrSearchSwift.xcworkspace**

From Xcode: Connect Device, Product > Run

This is a basic Flickr Photo Search done in Swift. Which contains the following librabies

1. [Alamofire](https://github.com/Alamofire/Alamofire) - To call the Flickr API and have a response in JSON
2. [AlamorfireObjectMapper](https://github.com/tristanhimmelman/AlamofireObjectMapper) - To map the JSON response into Model Classes
3. [SDWebImage](https://github.com/rs/SDWebImage) - To download images and cache them
4. [MBProgressHub](https://github.com/jdg/MBProgressHUD) - Loading Indicator used while calling Flickr API

> Flickr API Key must be added in the **Constants.h** file under **flickrAPIKey**
