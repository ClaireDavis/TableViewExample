# TableViewExample
example table view configuration using Parse and AWS S3 databases

## Installation
To install this project, go ahead and clone it to your desired location  
```
git@github.com:ClaireDavis/TableViewExample.git
```  
Next you'll need to install the pods, get the latest stable version of cocoapods and then run
```
pod install
```  
You now will need to get the secret keys file, cd to the root directory of the github repository and then run
```
cp TableViewExample/HelperFiles/APIConstants.m.example TableViewExample/HelperFiles/APIConstants.m
```  
To finish installation, you will need to set the keys in your newly copied .m file to the actual keys so that you will have access to the necessary data stores and apis.
