#!/usr/bin/env python3
"""
Script to generate Xcode project file for Finora
"""

import os
import uuid
import json
from pathlib import Path

def generate_uuid():
    """Generate a 24-character hex string for Xcode project UUIDs"""
    return uuid.uuid4().hex[:24].upper()

def get_all_swift_files(root_dir):
    """Get all Swift files in the project"""
    swift_files = []
    for root, dirs, files in os.walk(root_dir):
        # Skip hidden directories and build directories
        dirs[:] = [d for d in dirs if not d.startswith('.') and d != 'build']
        
        for file in files:
            if file.endswith('.swift'):
                full_path = os.path.join(root, file)
                rel_path = os.path.relpath(full_path, root_dir)
                swift_files.append(rel_path)
    return sorted(swift_files)

def create_xcode_project(project_dir):
    """Create Xcode project structure"""
    project_name = "Finora"
    project_path = os.path.join(project_dir, f"{project_name}.xcodeproj")
    
    # Create project directory
    os.makedirs(project_path, exist_ok=True)
    
    # Get all Swift files
    swift_files = get_all_swift_files(project_dir)
    
    # Generate UUIDs
    project_uuid = generate_uuid()
    main_group_uuid = generate_uuid()
    products_group_uuid = generate_uuid()
    frameworks_group_uuid = generate_uuid()
    
    # Create main target UUIDs
    app_target_uuid = generate_uuid()
    test_target_uuid = generate_uuid()
    
    # Create build configuration UUIDs
    debug_config_uuid = generate_uuid()
    release_config_uuid = generate_uuid()
    test_debug_config_uuid = generate_uuid()
    test_release_config_uuid = generate_uuid()
    
    # Create file references
    file_refs = {}
    file_refs["FinoraApp.swift"] = generate_uuid()
    
    # Group structure
    groups = {
        "Core": generate_uuid(),
        "Core/Network": generate_uuid(),
        "Core/Services": generate_uuid(),
        "Core/Managers": generate_uuid(),
        "Core/Utilities": generate_uuid(),
        "Core/Utilities/Extensions": generate_uuid(),
        "Core/Utilities/Constants": generate_uuid(),
        "Models": generate_uuid(),
        "ViewModels": generate_uuid(),
        "Views": generate_uuid(),
        "Views/Auth": generate_uuid(),
        "Views/Transactions": generate_uuid(),
        "Components": generate_uuid(),
        "Components/Buttons": generate_uuid(),
        "Components/TextFields": generate_uuid(),
        "Components/Cards": generate_uuid(),
        "Resources": generate_uuid(),
        "Resources/Colors": generate_uuid(),
        "Resources/Localizable": generate_uuid(),
        "Routing": generate_uuid(),
        "Preview": generate_uuid(),
        "Tests": generate_uuid(),
        "Tests/ViewModels": generate_uuid(),
        "Tests/Services": generate_uuid(),
        "Tests/Utilities": generate_uuid(),
    }
    
    # Generate file references for all Swift files
    for swift_file in swift_files:
        file_refs[swift_file] = generate_uuid()
    
    # Create project.pbxproj content
    pbxproj_content = f'''// !$*UTF8*$!
{{
	archiveVersion = 1;
	classes = {{
	}};
	objectVersion = 56;
	objects = {{

/* Begin PBXBuildFile section */
		{file_refs.get("FinoraApp.swift", generate_uuid())} /* FinoraApp.swift in Sources */ = {{isa = PBXBuildFile; fileRef = {file_refs.get("FinoraApp.swift", generate_uuid())} /* FinoraApp.swift */; }};
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		{app_target_uuid} /* Finora.app */ = {{isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = Finora.app; sourceTree = BUILT_PRODUCTS_DIR; }};
		{test_target_uuid} /* FinoraTests.xctest */ = {{isa = PBXFileReference; explicitFileType = wrapper.cfbundle; includeInIndex = 0; path = FinoraTests.xctest; sourceTree = BUILT_PRODUCTS_DIR; }};
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		{generate_uuid()} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
		{generate_uuid()} /* Frameworks */ = {{
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		}};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		{main_group_uuid} = {{
			isa = PBXGroup;
			children = (
				{groups.get("Core", generate_uuid())} /* Core */,
				{groups.get("Models", generate_uuid())} /* Models */,
				{groups.get("ViewModels", generate_uuid())} /* ViewModels */,
				{groups.get("Views", generate_uuid())} /* Views */,
				{groups.get("Components", generate_uuid())} /* Components */,
				{groups.get("Resources", generate_uuid())} /* Resources */,
				{groups.get("Routing", generate_uuid())} /* Routing */,
				{groups.get("Preview", generate_uuid())} /* Preview */,
				{groups.get("Tests", generate_uuid())} /* Tests */,
				{products_group_uuid} /* Products */,
				{frameworks_group_uuid} /* Frameworks */,
			);
			sourceTree = "<group>";
		}};
		{products_group_uuid} /* Products */ = {{
			isa = PBXGroup;
			children = (
				{app_target_uuid} /* Finora.app */,
				{test_target_uuid} /* FinoraTests.xctest */,
			);
			name = Products;
			sourceTree = "<group>";
		}};
		{frameworks_group_uuid} /* Frameworks */ = {{
			isa = PBXGroup;
			children = (
			);
			name = Frameworks;
			sourceTree = "<group>";
		}};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		{app_target_uuid} /* Finora */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {generate_uuid()} /* Build configuration list for PBXNativeTarget "Finora" */;
			buildPhases = (
				{generate_uuid()} /* Sources */,
				{generate_uuid()} /* Frameworks */,
				{generate_uuid()} /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = Finora;
			productName = Finora;
			productReference = {app_target_uuid} /* Finora.app */;
			productType = "com.apple.product-type.application";
		}};
		{test_target_uuid} /* FinoraTests */ = {{
			isa = PBXNativeTarget;
			buildConfigurationList = {generate_uuid()} /* Build configuration list for PBXNativeTarget "FinoraTests" */;
			buildPhases = (
				{generate_uuid()} /* Sources */,
				{generate_uuid()} /* Frameworks */,
				{generate_uuid()} /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
				{generate_uuid()} /* PBXTargetDependency */,
			);
			name = FinoraTests;
			productName = FinoraTests;
			productReference = {test_target_uuid} /* FinoraTests.xctest */;
			productType = "com.apple.product-type.bundle.unit-test";
		}};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		{project_uuid} /* Project object */ = {{
			isa = PBXProject;
			attributes = {{
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
			}};
			buildConfigurationList = {generate_uuid()} /* Build configuration list for PBXProject "{project_name}" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = {main_group_uuid};
			productRefGroup = {products_group_uuid} /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				{app_target_uuid} /* Finora */,
				{test_target_uuid} /* FinoraTests */,
			);
		}};
/* End PBXProject section */

/* Begin XCBuildConfiguration section */
		{debug_config_uuid} /* Debug */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 16.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = iphoneos;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = "DEBUG $(inherited)";
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			}};
			name = Debug;
		}};
		{release_config_uuid} /* Release */ = {{
			isa = XCBuildConfiguration;
			buildSettings = {{
				ALWAYS_SEARCH_USER_PATHS = NO;
				ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS = YES;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_USER_SCRIPT_SANDBOXING = YES;
				GCC_C_LANGUAGE_STANDARD = gnu17;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				IPHONEOS_DEPLOYMENT_TARGET = 16.0;
				LOCALIZATION_PREFERS_STRING_CATALOGS = YES;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = iphoneos;
				SWIFT_COMPILATION_MODE = wholemodule;
				VALIDATE_PRODUCT = YES;
			}};
			name = Release;
		}};
/* End XCBuildConfiguration section */

	}};
	rootObject = {project_uuid} /* Project object */;
}}
'''
    
    # Write project.pbxproj
    pbxproj_path = os.path.join(project_path, "project.pbxproj")
    with open(pbxproj_path, 'w') as f:
        f.write(pbxproj_content)
    
    print(f"✅ Created {project_path}")
    print(f"⚠️  Note: This is a basic project structure.")
    print(f"   You should open it in Xcode and add all Swift files manually,")
    print(f"   or install XcodeGen and run: xcodegen generate")
    return project_path

if __name__ == "__main__":
    project_dir = os.path.dirname(os.path.abspath(__file__))
    create_xcode_project(project_dir)

