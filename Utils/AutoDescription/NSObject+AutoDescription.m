//
//  NSObject+AutoDescription.m
//  MGXMLParser
//
//  Created by magicmac on 12-8-28.
//  Copyright (c) 2012年 magicpoint. All rights reserved.
//

#import "NSObject+AutoDescription.h"
#import <objc/runtime.h>

@implementation NSObject (AutoDescription)

- (NSString *) autoDescriptionForClassType:(Class)classType {
    
	NSMutableString * result = [NSMutableString string];
    
	// Find Out something about super Classes
	Class superClass  = class_getSuperclass(classType);
	if  ( superClass != nil && ![superClass isEqual:[NSObject class]])
	{
		// Append all the super class's properties to the result (Reqursive, until NSObject)
		[result appendString:[self autoDescriptionForClassType:superClass]];
	}
    
	// Add Information about Current Properties
	NSUInteger		  property_count;
	objc_property_t * property_list = class_copyPropertyList(classType, &property_count); // Must Free, later
    
	for (int i = property_count - 1; i >= 0; --i) { // Reverse order, to get Properties in order they were defined
		objc_property_t property = property_list[i];
        
		// For Eeach property we are loading its name
		const char * property_name = property_getName(property);
        
		NSString * propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];
		if (propertyName) { // and if name is ok, we are getting value using KVC
			id value = [self valueForKey:propertyName];
            
			// format of result items: p1 = v1; p2 = v2; ...
			[result appendFormat:@"%@ = %@; ", propertyName, value];
		}
	}
	free(property_list);//Clean up
    
	return result;
}

// Reflects about self.
- (NSString *) autoDescription {
	return [NSString stringWithFormat:@"[%@ {%@}]", NSStringFromClass([self class]), [self autoDescriptionForClassType:[self class]]];
}
- (NSDictionary *)dictionaryDescriptionForClassType:(Class)classType  {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithCapacity:0];
    
	// Find Out something about super Classes
	Class superClass  = class_getSuperclass(classType);
	if  ( superClass != nil && ![superClass isEqual:[NSObject class]])
	{
		// Append all the super class's properties to the result (Reqursive, until NSObject)
		[result addEntriesFromDictionary:[self dictionaryDescriptionForClassType:superClass]];
	}
    
	// Add Information about Current Properties
	NSUInteger		  property_count;
	objc_property_t * property_list = class_copyPropertyList(classType, &property_count); // Must Free, later
    NSLog(@"integer count 123:%@,== %d",classType,property_count);
	for (int i = property_count - 1; i >= 0; --i) { // Reverse order, to get Properties in order they were defined
		objc_property_t property = property_list[i];
        
		// For Eeach property we are loading its name
		const char * property_name = property_getName(property);
        
		NSString * propertyName = [NSString stringWithCString:property_name encoding:NSASCIIStringEncoding];
        
		if (propertyName) { // and if name is ok, we are getting value using KVC
			
            id value = [self valueForKey:propertyName];
            DLog(@"propertyName == %@, value==:%@",propertyName,value);
            
            if (value) {
                [result setObject:value forKey:propertyName];
            }
            
		}
	}
	free(property_list);//Clean up
    DLog(@"classType:%@",result);
	return result;
    
}

- (NSDictionary *)dictionaryFromAttributes {
    DLog(@"fromAttributes :%@",[self dictionaryDescriptionForClassType:[self class]]);
    return [self dictionaryDescriptionForClassType:[self class]];
}

@end
