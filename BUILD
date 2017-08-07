# xsd2swift: Command line tool to convert XML schemas to Swift classes.
# Copyright (C) 2017  Steven E Wright
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

package(default_visibility = ["//visibility:public"])

licenses(["notice"])

load(
    "@build_bazel_rules_apple//apple:macos.bzl",
    "macos_command_line_application",
)

load(
    "@build_bazel_rules_apple//apple:versioning.bzl",
    "apple_bundle_version",
)

filegroup(
    name = "Documentation",
    srcs = [
        "README.md",
        "CONTRIBUTORS.md",
        "NOTICE.md",
        "LICENSE.md",
    ],
)

objc_library(
    name = "MGTemplateEngine_sources",
    pch = "third_party/MGTemplateEngine/MGTemplateEngine_Prefix.pch",
    srcs = glob([
        "third_party/MGTemplateEngine/ICUTemplateMatcher.m",
        "third_party/MGTemplateEngine/MGTemplateEngine.m",
        "third_party/MGTemplateEngine/MGTemplateStandardFilters.m",
        "third_party/MGTemplateEngine/MGTemplateStandardMarkers.m",
        "third_party/MGTemplateEngine/NSArray_DeepMutableCopy.m",
        "third_party/MGTemplateEngine/NSDictionary_DeepMutableCopy.m",
    ]),
    hdrs = glob([
        "third_party/MGTemplateEngine/DeepMutableCopy.h",
        "third_party/MGTemplateEngine/ICUTemplateMatcher.h",
        "third_party/MGTemplateEngine/MGTemplateEngine.h",
        "third_party/MGTemplateEngine/MGTemplateFilter.h",
        "third_party/MGTemplateEngine/MGTemplateMarker.h",
        "third_party/MGTemplateEngine/MGTemplateStandardFilters.h",
        "third_party/MGTemplateEngine/MGTemplateStandardMarkers.h",
        "third_party/MGTemplateEngine/NSArray_DeepMutableCopy.h",
        "third_party/MGTemplateEngine/NSDictionary_DeepMutableCopy.h",
    ]),
    copts = ["-I__BAZEL_XCODE_SDKROOT__/usr/include/libxml2"],
    sdk_dylibs = [
        "libxml2",
    ],
)

genrule(
    name = "resource_datatypes_xml",
    srcs = ["xsd2swift/resources/datatypes.xml"],
    outs = ["xsd2swift/resources/datatypes_xml.h"],
    cmd = "xxd -i $(location xsd2swift/resources/datatypes.xml) > $@",
)

genrule(
    name = "resource_name_changes_xml",
    srcs = ["xsd2swift/resources/name_changes.xml"],
    outs = ["xsd2swift/resources/name_changes_xml.h"],
    cmd = "xxd -i $(location xsd2swift/resources/name_changes.xml) > $@",
)

genrule(
    name = "resource_template_xsd",
    srcs = ["xsd2swift/resources/template.xsd"],
    outs = ["xsd2swift/resources/template_xsd.h"],
    cmd = "xxd -i $(location xsd2swift/resources/template.xsd) > $@",
)

genrule(
    name = "resource_template_swift_xml",
    srcs = ["xsd2swift/resources/template_swift.xml"],
    outs = ["xsd2swift/resources/template_swift_xml.h"],
    cmd = "xxd -i $(location xsd2swift/resources/template_swift.xml) > $@",
)

genrule(
    name = "resource_xml_schema_xsd",
    srcs = ["xsd2swift/resources/xml_schema.xsd"],
    outs = ["xsd2swift/resources/xml_schema_xsd.h"],
    cmd = "xxd -i $(location xsd2swift/resources/xml_schema.xsd) > $@",
)

objc_library(
    name = "xsd2swift_sources",
    hdrs = [
        ":resource_datatypes_xml",
        ":resource_name_changes_xml",
        ":resource_template_xsd",
        ":resource_template_swift_xml",
        ":resource_xml_schema_xsd",
        ] + glob(["xsd2swift/**/*.h"]),
    srcs = glob(["xsd2swift/**/*.m"]),
    copts = ["-I__BAZEL_XCODE_SDKROOT__/usr/include/libxml2"],
    sdk_dylibs = [
        "libxml2",
    ],
    deps = [
        ":MGTemplateEngine_sources",
    ],
)

objc_library(
    name = "xsd2swift_test_sources",
    hdrs = glob(["tests/**/*.h"]),
    srcs = glob(["tests/**/*.m"]),
    deps = [
        ":xsd2swift_sources",
    ],
)

# TODO: When mac_unit_test (?) becomes available.
#     ios_unit_test is not sufficient because NSXMLParser is not
#     available on iOS.
# mac_unit_test(
#     name = "xsd2swift_tests",
#     bundle_id = "com.stevenewright.xsd2swift_tests",
#     infoplists = ["tests/info_tests.plist"],
#     minimum_os_version = "10.12",
#     deps = [
#         ":xsd2swift_test_sources",
#     ],
# )

apple_bundle_version(
    name = "xsd2swift_version",
    build_version = "1.0",
)

macos_command_line_application(
    name = "xsd2swift",
    bundle_id = "com.stevenewright.xsd2swift",
    infoplists = ["xsd2swift/info.plist"],
    minimum_os_version = "10.12",
    version = ":xsd2swift_version",
    deps = [
        ":xsd2swift_sources",
    ],
    linkopts = ["-framework", "AppKit"],
)
