//
//  XSDenumeration.m
//  XSDConverter
//
//  Created by Alex Smith on 3/25/15.
//
//

#import "xsd2swift/XSDenumeration.h"
#import "xsd2swift/XMLUtils.h"
#import "xsd2swift/XSDschema.h"
#import "xsd2swift/XSType.h"

@interface XSDenumeration ()

@property(strong, nonatomic) NSString* value;
@property(strong, nonatomic) NSString* type;

@end

@implementation XSDenumeration

- (id)init {
  if (self = [super init]) {
    self.value = nil;
  }
  return self;
}

- (id)initWithNode:(NSXMLElement*)node schema:(XSDschema*)schema {
  if (self = [super initWithNode:node schema:schema]) {
    self.value = [XMLUtils node:node stringAttribute:@"value"];
  }
  return self;
}

- (NSString*)objcType {
  return [[self.schema typeForName:self.type] targetClassName];
}
@end
