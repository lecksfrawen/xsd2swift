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
//  main.m
//  xsd2cocoatool
//
//  Created by Marek Ruszczak on 27/11/15.
//
//

#import <Foundation/Foundation.h>

#import "xsd2swift/XSDschema.h"



BOOL writeCode(NSURL *schemaURL, NSURL *outFolder, NSString *classPrefix, NSError **outError) {
  /* Open the schema specified by the user */
  NSError *error = nil;

  /* Build the schemea with simple types, complex types, and elements with imported schemas */
  XSDschema *schema =
      [[XSDschema alloc] initWithUrl:schemaURL targetNamespacePrefix:classPrefix error:&error];
  if (error) {
    if (outError) {
      *outError = error;
    }
    return NO;
  }
  /*************************************************************************************************************************
   *      LOAD THE TEMPLATES USED FOR THE HEADER/CLASS FILES
   *
   *************************************************************************************************************************/
  [schema loadTemplate:[XSDschema swiftTemplate] error:&error];

  /* Ensure that there wasn't an error */
  if (error != nil) {
    if (outError) {
      *outError = error;
    }
    return NO;
  }

  /* Select the type of code that we want to generate (Framework, Library, or Source Code -- Default
   * for us is source code) */
  XSDschemaGeneratorOptions productTypes = XSDschemaGeneratorOptionSourceCode;

  /*
   *  Write the code for the types that are currently in use... All the simple types
   *  that are used in the template and generated for our code will be used here
   */
  [schema generateInto:outFolder products:productTypes error:&error];

  if (error != nil) {
    if (outError) {
      *outError = error;
    }
    return NO;
  }

  return YES;
}

static NSString *const kSchemaKey = @"schema";
static NSString *const kOutputDirKey = @"out";
static NSString *const kClassPrefixKey = @"prefix";
static NSString *const kClearOutputDirKey = @"clear";

int main(int argc, const char *argv[]) {
  @autoreleasepool {
    NSUserDefaults *userDefaults = NSUserDefaults.standardUserDefaults;

    NSURL *schemaURL = [userDefaults URLForKey:kSchemaKey];
    NSURL *outFolder = [userDefaults URLForKey:kOutputDirKey];
    NSString *classPrefix = [userDefaults stringForKey:kClassPrefixKey];
    NSError *error;
    BOOL argumentsAreFine = YES;

    if (!schemaURL) {
      fprintf(stderr, "Please provide schema: \"-schema <xsd location>\"\n");
      argumentsAreFine = NO;
    } else {
      [userDefaults setURL:schemaURL forKey:kSchemaKey];
    }

    if (!outFolder) {
      fprintf(stderr, "Please provide output folder: \"-out <output folder>\"\n");
      argumentsAreFine = NO;
    } else {
      [userDefaults setURL:outFolder forKey:kOutputDirKey];
    }

    if (classPrefix.length == 0) {
      classPrefix = @"";
    }
    [userDefaults setObject:classPrefix forKey:kClassPrefixKey];

    [userDefaults synchronize];
    if (!argumentsAreFine) {
      return 1;
    }

    if (![outFolder checkResourceIsReachableAndReturnError:&error]) {
      fprintf(stderr, "Can find output directory: %s\n%s\n", outFolder.description.UTF8String,
              error.localizedDescription.UTF8String);
      return 2;
    }
    if ([userDefaults boolForKey:kClearOutputDirKey]) {
      NSFileManager *fm = [NSFileManager defaultManager];
      NSURL *itemToDelete = [outFolder URLByAppendingPathComponent:@"Sources"];
      if ([itemToDelete checkResourceIsReachableAndReturnError:&error]) {
        if (![fm removeItemAtURL:itemToDelete error:&error]) {
          fprintf(stderr, "Can remove item at: %s\n%s\n", itemToDelete.description.UTF8String,
                  error.localizedDescription.UTF8String);
          return 3;
        }
      }
    }
    printf(
        "Generating for data:\n"
        "\t  schema:\t%s\n"
        "\t     out:\t%s\n"
        "\t  prefix:\t%s\n………\n",
        schemaURL.description.UTF8String, outFolder.description.UTF8String, classPrefix.UTF8String);

    if (writeCode(schemaURL, outFolder, classPrefix, &error)) {
      printf("…Classes sucessfully generated!\n");
    } else {
      fprintf(stderr, "Failed to generate classes.\n%s\n", error.localizedDescription.UTF8String);
      return 3;
    }
  }
  return 0;
}
