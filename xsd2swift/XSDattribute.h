#import <Foundation/Foundation.h>

#import "xsd2swift/XSSchemaNode.h"

@interface XSDattribute : XSSchemaNode

@property(readonly, nonatomic) NSString* name;
@property(readonly, nonatomic) NSString* simpleType;
@property(readonly, nonatomic) NSString* type;
@property(readonly, nonatomic) id use;
@property(readonly, nonatomic) NSString* defaultValue;
@property(readonly, nonatomic) NSString* fixed;
@property(readonly, nonatomic) NSString* form;

@property(readonly, nonatomic) NSString* readCodeForAttribute;
@property(readonly, nonatomic) NSString* writeCodeForAttribute;

- (BOOL)optional;
- (BOOL)hasDefault;
- (NSString*)variableName;  // name in generated code
- (BOOL)hasEnumeration;

@end
