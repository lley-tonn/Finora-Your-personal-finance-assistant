# .gitignore Notes for Finora Project

## What is Excluded

### User-Specific Files (Never Commit)
- ✅ `xcuserdata/` - User-specific Xcode settings
- ✅ `*.xcuserstate` - User interface state
- ✅ `*.xcuserdatad/` - User data directories
- ✅ `*.xcodeproj/project.xcworkspace/xcuserdata/` - Workspace user data

### Build Artifacts
- ✅ `build/` - Build output directory
- ✅ `DerivedData/` - Xcode derived data
- ✅ `*.ipa` - App archives
- ✅ `*.dSYM` - Debug symbols

### System Files
- ✅ `.DS_Store` - macOS Finder metadata
- ✅ `._*` - macOS resource forks
- ✅ `.fseventsd/` - File system events

### IDE Files
- ✅ `.vscode/` - VS Code settings
- ✅ `.idea/` - AppCode/IntelliJ settings

### Temporary Files
- ✅ `*.tmp`, `*.temp`, `*.swp` - Temporary files
- ✅ `*.log` - Log files
- ✅ `*.backup`, `*.bak` - Backup files

### Dependencies (if added later)
- ✅ `Pods/` - CocoaPods (if used)
- ✅ `Carthage/Build/` - Carthage build artifacts
- ✅ `.build/` - Swift Package Manager build

## What Should Be Committed

### Project Files
- ✅ `Finora.xcodeproj/project.pbxproj` - Project file
- ✅ `Finora.xcodeproj/xcshareddata/` - Shared schemes and settings
- ✅ `Finora.xcodeproj/project.xcworkspace/contents.xcworkspacedata` - Workspace data

### Source Code
- ✅ All `.swift` files
- ✅ `Info.plist` files
- ✅ `project.yml` (XcodeGen config)

### Documentation
- ✅ `README.md`
- ✅ `PROJECT_STRUCTURE.md`
- ✅ `*.md` documentation files

### Scripts
- ✅ `setup_xcode_project.sh`
- ✅ `generate_xcode_project.py`

### Resources
- ✅ Assets, colors, strings
- ✅ Preview helpers
- ✅ Mock data

## Verification

To verify what will be committed:
```bash
git status
```

To check if a specific file is ignored:
```bash
git check-ignore -v path/to/file
```

To see all ignored files:
```bash
git status --ignored
```

## Important Notes

1. **Never commit user-specific Xcode files** - These contain personal settings and can cause merge conflicts
2. **Commit project structure** - The `.xcodeproj` directory structure should be committed (except user data)
3. **Shared schemes** - Keep `xcshareddata/` committed so team members share build schemes
4. **XcodeGen** - If using XcodeGen, you can choose to commit the generated project or regenerate from `project.yml`

## Common Issues

### Issue: Project file shows as untracked
**Solution**: This is normal. Git tracks the directory and its non-ignored contents.

### Issue: User data accidentally committed
**Solution**: Remove from git history:
```bash
git rm -r --cached **/xcuserdata/
git commit -m "Remove user-specific files"
```

### Issue: Build artifacts in repository
**Solution**: Add to `.gitignore` and remove:
```bash
git rm -r --cached build/ DerivedData/
git commit -m "Remove build artifacts"
```

