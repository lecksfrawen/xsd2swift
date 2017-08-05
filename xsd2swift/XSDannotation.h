//
//  XSDAnnotation.h
//  XSDConverter
//
//  Created by Dominik Pich on 26/12/14.
//
//

#import <Foundation/Foundation.h>
#import "xsd2swift/XMLUtils.h"
#import "xsd2swift/XSSchemaNode.h"

@interface XSDAnnotation : XSSchemaNode

@property(nonatomic, readonly) NSString *identifier;
@property(nonatomic, readonly) NSString *appInfo;
@property(nonatomic, readonly) NSString *documentation;

- (NSString *)comment;

@end
