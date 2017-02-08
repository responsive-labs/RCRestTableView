# RCRestTableView

[![CI Status](http://img.shields.io/travis/serluca/RCRestTableView.svg?style=flat)](https://travis-ci.org/serluca/RCRestTableView)
[![Coverage Status](https://coveralls.io/repos/serluca/RCRestTableView/badge.svg)](https://coveralls.io/r/serluca/RCRestTableView)
[![Version](https://img.shields.io/cocoapods/v/RCRestTableView.svg?style=flat)](http://cocoapods.org/pods/RCRestTableView)
[![License](https://img.shields.io/cocoapods/l/RCRestTableView.svg?style=flat)](http://cocoapods.org/pods/RCRestTableView)
[![Platform](https://img.shields.io/cocoapods/p/RCRestTableView.svg?style=flat)](http://cocoapods.org/pods/RCRestTableView)

RCRestTableView is an helpful library for iOs. Many times you want to display your data or build forms to interact with your web-server and you have to create your UITableView to interact with it.

Using RCRestTableView you can create powerful tables/forms using `json`,`plist files` or `NSDictionary` with an easy syntax.

## Installation

RCRestTableView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
platform :ios, '7.0'
pod "RCRestTableView"
```

## Usage
Follow the wiki for more details on the structure.

As already said, you can create tables using `json string`, `plist file` or `NSDictionary`, it means that you can generate your table at runtime, inlcuding the schema in the app or downloading it from the server.

Init the table programmatically:

```
- (instancetype)initWithJsonString:(NSString*)json;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
```

or include it in your storyboard and then configure it using:

```
- (void)setJsonStructure:(NSString*)json;
- (void)setDictionaryStructure:(NSDictionary*)dictionary;
```

You can set/add properties once the table is loaded using:

```
- (void)setPropertyValue:(id)value withKey:(NSString *)key forCellIdentifier:(NSString *)cellIdentifier withSectionIdentifier:(NSString *)sectionIdentifier;
```
Read all values using the method `- (NSDictionary*)values;` or populate the table using a dictionary of values `- (void)setValues:(NSDictionary*)values;`.

This is an example of possible json: ....

Some examples are included in the project.


## Author

Luca Serpico, serpicoluca@gmail.com

## Need help?

If there is a technical problem, [open an issue](https://github.com/serluca/RCRestTableView/issues).

## Contributing
1. Create an issue to discuss about your idea
2. Fork it ([https://github.com/serluca/RCRestTableView/fork](https://github.com/serluca/RCRestTableView))
3. Create your feature branch (git checkout -b my-new-feature)
4. Commit your changes (git commit -am 'Add some feature')
5. Push to the branch (git push origin my-new-feature)
6. Create a new Pull Request

## License

RCRestTableView is available under the MIT license. See the LICENSE file for more info.
