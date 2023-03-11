import Sh
import Disk

public struct Project {
    public init() {}
    
    public func generate() throws {
        let resourcePath = "./Swish/Sources/ProjectLib/Resources"
        let filename: String
        let header: String
        
        if "BASE".lowercased() == "base"  {
            filename = "OpenBytesHeader.txt"
        } else {
            filename = "StandardHeader.txt"
        }
        
        header = String(
            data: try Disk.data(
                path: resourcePath,
                filename: filename
            ),
            encoding: .utf8
        ) ?? ""
        
        try sh(.terminal, "xcodegen")
        try shq(.terminal, "echo '\(header)' > base.xcodeproj/xcshareddata/IDETemplateMacros.plist")
    }
}
