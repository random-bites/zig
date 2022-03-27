export fn entry() void {
    const U = union { A: u32, B: u64 };
    var u = U{ .A = 42 };
    var ok = u == .A;
    _ = ok;
}

// comparison of non-tagged union and enum literal
//
// tmp.zig:4:16: error: comparison of union and enum literal is only valid for tagged union types
// tmp.zig:2:15: note: type U is not a tagged union