// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

/*
    Package.swift

    Copyright (c) 2018 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

import PackageDescription

#if os(Linux)
let package = Package(
    name: "NCursesw",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "NCursesw",
            type: .static,
            targets: ["NCursesw"]),
        .library(
            name: "NCursesw",
            type: .dynamic,
            targets: ["NCursesw"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/itssofluffy/CNCursesw.git", from: "0.0.1"),
        .package(url: "https://github.com/itssofluffy/ISFLibrary.git", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "CNCurseswExtensions",
            dependencies: []),
        .target(
            name: "NCursesw",
            dependencies: ["CNCurseswExtensions", "ISFLibrary"]),
        .testTarget(
            name: "NCurseswTests",
            dependencies: ["NCursesw"]),
    ]
)
#else
fatalError("Unsupported OS")
#endif
