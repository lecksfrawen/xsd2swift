/*
xsd2swift: Command line tool to convert XML schemas to Swift classes.
Copyright (C) 2017  Steven E Wright

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//
//  XSDschema.h
//  xsd2cocoa
//
//  Created by Stefan Winter on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "xsd2swift/XSSchemaNode.h"

@protocol XSType;
@protocol FileFormatter;
@class XSDcomplexType;

typedef NS_OPTIONS(NSUInteger, XSDschemaGeneratorOptions) {
  XSDschemaGeneratorOptionSourceCode = 1 << 0,
  XSDschemaGeneratorOptionSourceCodeWithSubfolders = 1 << 1
};

@interface XSDschema : XSSchemaNode

+ (NSData*)swiftTemplate;

@property(readonly, nonatomic) NSString* schemaId;
@property(readonly, nonatomic) NSURL* schemaUrl;
@property(readonly, nonatomic) NSString* targetNamespace;
@property(readonly, nonatomic) NSArray* allNamespaces;
@property(readonly, nonatomic) NSArray* complexTypes;
@property(readonly, nonatomic)
    NSArray* includedSchemas;  // included and imported both. except for namespacing, we dont care
@property(readonly, nonatomic) NSArray* simpleTypes;
@property(readonly, nonatomic) NSString* xmlSchemaNamespace;
- (NSString*)nameSpacedSchemaNodeNameForNodeName:(NSString*)nodeName;

@property(readonly, weak, nonatomic) XSDschema* parentSchema;

// create the scheme, loading all types and includes
- (id)initWithUrl:(NSURL*)schemaUrl targetNamespacePrefix:(NSString*)prefix error:(NSError**)error;

// element may add local types (Complex or simple)
- (void)addType:(id<XSType>)type;

- (BOOL) loadTemplate:(NSData*)templateData error:(NSError**)resultError;

- (id<XSType>)typeForName:(NSString*)qname;  // this will only return proper type info when called during generation
- (NSString*)classPrefixForType:(id<XSType>)type;
+ (NSString*)variableNameFromName:(NSString*)vName multiple:(BOOL)multiple;

#pragma mark -

// generate code using loaded template
- (BOOL)generateInto:(NSURL*)destinationFolder
            products:(XSDschemaGeneratorOptions)options
               error:(NSError**)error;

@end
