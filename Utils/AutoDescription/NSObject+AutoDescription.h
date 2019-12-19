//
//  NSObject+AutoDescription.h
//  MGXMLParser
//
//  Created by magicmac on 12-8-28.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AutoDescription)

// Reflects about self.
// Format: [ClassName {prop1 = val1; prop2 = val2; }].,
// SuperClass' properties included (until NSObject).
- (NSString *) autoDescription; // can be in real description or somewhere else

- (NSDictionary *)dictionaryFromAttributes ;
- (NSDictionary *)dictionaryDescriptionForClassType:(Class)classType ;

@end
