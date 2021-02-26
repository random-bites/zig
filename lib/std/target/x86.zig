// SPDX-License-Identifier: MIT
// Copyright (c) 2015-2021 Zig Contributors
// This file is part of [zig](https://ziglang.org/), which is MIT licensed.
// The MIT license requires this copyright notice to be included in all copies
// and substantial portions of the software.
const std = @import("../std.zig");
const CpuFeature = std.Target.Cpu.Feature;
const CpuModel = std.Target.Cpu.Model;

pub const Feature = enum {
    @"3dnow",
    @"3dnowa",
    @"64bit",
    adx,
    aes,
    amx_bf16,
    amx_int8,
    amx_tile,
    avx,
    avx2,
    avx512bf16,
    avx512bitalg,
    avx512bw,
    avx512cd,
    avx512dq,
    avx512er,
    avx512f,
    avx512ifma,
    avx512pf,
    avx512vbmi,
    avx512vbmi2,
    avx512vl,
    avx512vnni,
    avx512vp2intersect,
    avx512vpopcntdq,
    avxvnni,
    bmi,
    bmi2,
    branchfusion,
    cldemote,
    clflushopt,
    clwb,
    clzero,
    cmov,
    cx16,
    cx8,
    enqcmd,
    ermsb,
    f16c,
    false_deps_lzcnt_tzcnt,
    false_deps_popcnt,
    fast_11bytenop,
    fast_15bytenop,
    fast_7bytenop,
    fast_bextr,
    fast_gather,
    fast_hops,
    fast_lzcnt,
    fast_scalar_fsqrt,
    fast_scalar_shift_masks,
    fast_shld_rotate,
    fast_variable_shuffle,
    fast_vector_fsqrt,
    fast_vector_shift_masks,
    fma,
    fma4,
    fsgsbase,
    fsrm,
    fxsr,
    gfni,
    hreset,
    idivl_to_divb,
    idivq_to_divl,
    invpcid,
    kl,
    lea_sp,
    lea_uses_ag,
    lvi_cfi,
    lvi_load_hardening,
    lwp,
    lzcnt,
    macrofusion,
    mmx,
    movbe,
    movdir64b,
    movdiri,
    mwaitx,
    nopl,
    pad_short_functions,
    pclmul,
    pconfig,
    pku,
    popcnt,
    prefer_128_bit,
    prefer_256_bit,
    prefer_mask_registers,
    prefetchwt1,
    prfchw,
    ptwrite,
    rdpid,
    rdrnd,
    rdseed,
    retpoline,
    retpoline_external_thunk,
    retpoline_indirect_branches,
    retpoline_indirect_calls,
    rtm,
    sahf,
    serialize,
    seses,
    sgx,
    sha,
    shstk,
    slow_3ops_lea,
    slow_incdec,
    slow_lea,
    slow_pmaddwd,
    slow_pmulld,
    slow_shld,
    slow_two_mem_ops,
    slow_unaligned_mem_16,
    slow_unaligned_mem_32,
    soft_float,
    sse,
    sse_unaligned_mem,
    sse2,
    sse3,
    sse4_1,
    sse4_2,
    sse4a,
    ssse3,
    tbm,
    tsxldtrk,
    uintr,
    use_aa,
    use_glm_div_sqrt_costs,
    vaes,
    vpclmulqdq,
    vzeroupper,
    waitpkg,
    wbnoinvd,
    widekl,
    x87,
    xop,
    xsave,
    xsavec,
    xsaveopt,
    xsaves,
};

pub usingnamespace CpuFeature.feature_set_fns(Feature);

pub const all_features = blk: {
    const len = @typeInfo(Feature).Enum.fields.len;
    std.debug.assert(len <= CpuFeature.Set.needed_bit_count);
    var result: [len]CpuFeature = undefined;
    result[@enumToInt(Feature.@"3dnow")] = .{
        .llvm_name = "3dnow",
        .description = "Enable 3DNow! instructions",
        .dependencies = featureSet(&[_]Feature{
            .mmx,
        }),
    };
    result[@enumToInt(Feature.@"3dnowa")] = .{
        .llvm_name = "3dnowa",
        .description = "Enable 3DNow! Athlon instructions",
        .dependencies = featureSet(&[_]Feature{
            .@"3dnow",
        }),
    };
    result[@enumToInt(Feature.@"64bit")] = .{
        .llvm_name = "64bit",
        .description = "Support 64-bit instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.adx)] = .{
        .llvm_name = "adx",
        .description = "Support ADX instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.aes)] = .{
        .llvm_name = "aes",
        .description = "Enable AES instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.amx_bf16)] = .{
        .llvm_name = "amx-bf16",
        .description = "Support AMX-BF16 instructions",
        .dependencies = featureSet(&[_]Feature{
            .amx_tile,
        }),
    };
    result[@enumToInt(Feature.amx_int8)] = .{
        .llvm_name = "amx-int8",
        .description = "Support AMX-INT8 instructions",
        .dependencies = featureSet(&[_]Feature{
            .amx_tile,
        }),
    };
    result[@enumToInt(Feature.amx_tile)] = .{
        .llvm_name = "amx-tile",
        .description = "Support AMX-TILE instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.avx)] = .{
        .llvm_name = "avx",
        .description = "Enable AVX instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse4_2,
        }),
    };
    result[@enumToInt(Feature.avx2)] = .{
        .llvm_name = "avx2",
        .description = "Enable AVX2 instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx,
        }),
    };
    result[@enumToInt(Feature.avx512bf16)] = .{
        .llvm_name = "avx512bf16",
        .description = "Support bfloat16 floating point",
        .dependencies = featureSet(&[_]Feature{
            .avx512bw,
        }),
    };
    result[@enumToInt(Feature.avx512bitalg)] = .{
        .llvm_name = "avx512bitalg",
        .description = "Enable AVX-512 Bit Algorithms",
        .dependencies = featureSet(&[_]Feature{
            .avx512bw,
        }),
    };
    result[@enumToInt(Feature.avx512bw)] = .{
        .llvm_name = "avx512bw",
        .description = "Enable AVX-512 Byte and Word Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512cd)] = .{
        .llvm_name = "avx512cd",
        .description = "Enable AVX-512 Conflict Detection Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512dq)] = .{
        .llvm_name = "avx512dq",
        .description = "Enable AVX-512 Doubleword and Quadword Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512er)] = .{
        .llvm_name = "avx512er",
        .description = "Enable AVX-512 Exponential and Reciprocal Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512f)] = .{
        .llvm_name = "avx512f",
        .description = "Enable AVX-512 instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx2,
            .f16c,
            .fma,
        }),
    };
    result[@enumToInt(Feature.avx512ifma)] = .{
        .llvm_name = "avx512ifma",
        .description = "Enable AVX-512 Integer Fused Multiple-Add",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512pf)] = .{
        .llvm_name = "avx512pf",
        .description = "Enable AVX-512 PreFetch Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512vbmi)] = .{
        .llvm_name = "avx512vbmi",
        .description = "Enable AVX-512 Vector Byte Manipulation Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512bw,
        }),
    };
    result[@enumToInt(Feature.avx512vbmi2)] = .{
        .llvm_name = "avx512vbmi2",
        .description = "Enable AVX-512 further Vector Byte Manipulation Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512bw,
        }),
    };
    result[@enumToInt(Feature.avx512vl)] = .{
        .llvm_name = "avx512vl",
        .description = "Enable AVX-512 Vector Length eXtensions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512vnni)] = .{
        .llvm_name = "avx512vnni",
        .description = "Enable AVX-512 Vector Neural Network Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512vp2intersect)] = .{
        .llvm_name = "avx512vp2intersect",
        .description = "Enable AVX-512 vp2intersect",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avx512vpopcntdq)] = .{
        .llvm_name = "avx512vpopcntdq",
        .description = "Enable AVX-512 Population Count Instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx512f,
        }),
    };
    result[@enumToInt(Feature.avxvnni)] = .{
        .llvm_name = "avxvnni",
        .description = "Support AVX_VNNI encoding",
        .dependencies = featureSet(&[_]Feature{
            .avx2,
        }),
    };
    result[@enumToInt(Feature.bmi)] = .{
        .llvm_name = "bmi",
        .description = "Support BMI instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.bmi2)] = .{
        .llvm_name = "bmi2",
        .description = "Support BMI2 instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.branchfusion)] = .{
        .llvm_name = "branchfusion",
        .description = "CMP/TEST can be fused with conditional branches",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.cldemote)] = .{
        .llvm_name = "cldemote",
        .description = "Enable Cache Demote",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.clflushopt)] = .{
        .llvm_name = "clflushopt",
        .description = "Flush A Cache Line Optimized",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.clwb)] = .{
        .llvm_name = "clwb",
        .description = "Cache Line Write Back",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.clzero)] = .{
        .llvm_name = "clzero",
        .description = "Enable Cache Line Zero",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.cmov)] = .{
        .llvm_name = "cmov",
        .description = "Enable conditional move instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.cx16)] = .{
        .llvm_name = "cx16",
        .description = "64-bit with cmpxchg16b",
        .dependencies = featureSet(&[_]Feature{
            .cx8,
        }),
    };
    result[@enumToInt(Feature.cx8)] = .{
        .llvm_name = "cx8",
        .description = "Support CMPXCHG8B instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.enqcmd)] = .{
        .llvm_name = "enqcmd",
        .description = "Has ENQCMD instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ermsb)] = .{
        .llvm_name = "ermsb",
        .description = "REP MOVS/STOS are fast",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.f16c)] = .{
        .llvm_name = "f16c",
        .description = "Support 16-bit floating point conversion instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx,
        }),
    };
    result[@enumToInt(Feature.false_deps_lzcnt_tzcnt)] = .{
        .llvm_name = "false-deps-lzcnt-tzcnt",
        .description = "LZCNT/TZCNT have a false dependency on dest register",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.false_deps_popcnt)] = .{
        .llvm_name = "false-deps-popcnt",
        .description = "POPCNT has a false dependency on dest register",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_11bytenop)] = .{
        .llvm_name = "fast-11bytenop",
        .description = "Target can quickly decode up to 11 byte NOPs",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_15bytenop)] = .{
        .llvm_name = "fast-15bytenop",
        .description = "Target can quickly decode up to 15 byte NOPs",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_7bytenop)] = .{
        .llvm_name = "fast-7bytenop",
        .description = "Target can quickly decode up to 7 byte NOPs",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_bextr)] = .{
        .llvm_name = "fast-bextr",
        .description = "Indicates that the BEXTR instruction is implemented as a single uop with good throughput",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_gather)] = .{
        .llvm_name = "fast-gather",
        .description = "Indicates if gather is reasonably fast",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_hops)] = .{
        .llvm_name = "fast-hops",
        .description = "Prefer horizontal vector math instructions (haddp, phsub, etc.) over normal vector instructions with shuffles",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_lzcnt)] = .{
        .llvm_name = "fast-lzcnt",
        .description = "LZCNT instructions are as fast as most simple integer ops",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_scalar_fsqrt)] = .{
        .llvm_name = "fast-scalar-fsqrt",
        .description = "Scalar SQRT is fast (disable Newton-Raphson)",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_scalar_shift_masks)] = .{
        .llvm_name = "fast-scalar-shift-masks",
        .description = "Prefer a left/right scalar logical shift pair over a shift+and pair",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_shld_rotate)] = .{
        .llvm_name = "fast-shld-rotate",
        .description = "SHLD can be used as a faster rotate",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_variable_shuffle)] = .{
        .llvm_name = "fast-variable-shuffle",
        .description = "Shuffles with variable masks are fast",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_vector_fsqrt)] = .{
        .llvm_name = "fast-vector-fsqrt",
        .description = "Vector SQRT is fast (disable Newton-Raphson)",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fast_vector_shift_masks)] = .{
        .llvm_name = "fast-vector-shift-masks",
        .description = "Prefer a left/right vector logical shift pair over a shift+and pair",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fma)] = .{
        .llvm_name = "fma",
        .description = "Enable three-operand fused multiple-add",
        .dependencies = featureSet(&[_]Feature{
            .avx,
        }),
    };
    result[@enumToInt(Feature.fma4)] = .{
        .llvm_name = "fma4",
        .description = "Enable four-operand fused multiple-add",
        .dependencies = featureSet(&[_]Feature{
            .avx,
            .sse4a,
        }),
    };
    result[@enumToInt(Feature.fsgsbase)] = .{
        .llvm_name = "fsgsbase",
        .description = "Support FS/GS Base instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fsrm)] = .{
        .llvm_name = "fsrm",
        .description = "REP MOVSB of short lengths is faster",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.fxsr)] = .{
        .llvm_name = "fxsr",
        .description = "Support fxsave/fxrestore instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.gfni)] = .{
        .llvm_name = "gfni",
        .description = "Enable Galois Field Arithmetic Instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.hreset)] = .{
        .llvm_name = "hreset",
        .description = "Has hreset instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.idivl_to_divb)] = .{
        .llvm_name = "idivl-to-divb",
        .description = "Use 8-bit divide for positive values less than 256",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.idivq_to_divl)] = .{
        .llvm_name = "idivq-to-divl",
        .description = "Use 32-bit divide for positive values less than 2^32",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.invpcid)] = .{
        .llvm_name = "invpcid",
        .description = "Invalidate Process-Context Identifier",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.kl)] = .{
        .llvm_name = "kl",
        .description = "Support Key Locker kl Instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.lea_sp)] = .{
        .llvm_name = "lea-sp",
        .description = "Use LEA for adjusting the stack pointer",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lea_uses_ag)] = .{
        .llvm_name = "lea-uses-ag",
        .description = "LEA instruction needs inputs at AG stage",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lvi_cfi)] = .{
        .llvm_name = "lvi-cfi",
        .description = "Prevent indirect calls/branches from using a memory operand, and precede all indirect calls/branches from a register with an LFENCE instruction to serialize control flow. Also decompose RET instructions into a POP+LFENCE+JMP sequence.",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lvi_load_hardening)] = .{
        .llvm_name = "lvi-load-hardening",
        .description = "Insert LFENCE instructions to prevent data speculatively injected into loads from being used maliciously.",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lwp)] = .{
        .llvm_name = "lwp",
        .description = "Enable LWP instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.lzcnt)] = .{
        .llvm_name = "lzcnt",
        .description = "Support LZCNT instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.macrofusion)] = .{
        .llvm_name = "macrofusion",
        .description = "Various instructions can be fused with conditional branches",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.mmx)] = .{
        .llvm_name = "mmx",
        .description = "Enable MMX instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.movbe)] = .{
        .llvm_name = "movbe",
        .description = "Support MOVBE instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.movdir64b)] = .{
        .llvm_name = "movdir64b",
        .description = "Support movdir64b instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.movdiri)] = .{
        .llvm_name = "movdiri",
        .description = "Support movdiri instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.mwaitx)] = .{
        .llvm_name = "mwaitx",
        .description = "Enable MONITORX/MWAITX timer functionality",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.nopl)] = .{
        .llvm_name = "nopl",
        .description = "Enable NOPL instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.pad_short_functions)] = .{
        .llvm_name = "pad-short-functions",
        .description = "Pad short functions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.pclmul)] = .{
        .llvm_name = "pclmul",
        .description = "Enable packed carry-less multiplication instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.pconfig)] = .{
        .llvm_name = "pconfig",
        .description = "platform configuration instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.pku)] = .{
        .llvm_name = "pku",
        .description = "Enable protection keys",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.popcnt)] = .{
        .llvm_name = "popcnt",
        .description = "Support POPCNT instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.prefer_128_bit)] = .{
        .llvm_name = "prefer-128-bit",
        .description = "Prefer 128-bit AVX instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.prefer_256_bit)] = .{
        .llvm_name = "prefer-256-bit",
        .description = "Prefer 256-bit AVX instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.prefer_mask_registers)] = .{
        .llvm_name = "prefer-mask-registers",
        .description = "Prefer AVX512 mask registers over PTEST/MOVMSK",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.prefetchwt1)] = .{
        .llvm_name = "prefetchwt1",
        .description = "Prefetch with Intent to Write and T1 Hint",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.prfchw)] = .{
        .llvm_name = "prfchw",
        .description = "Support PRFCHW instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.ptwrite)] = .{
        .llvm_name = "ptwrite",
        .description = "Support ptwrite instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.rdpid)] = .{
        .llvm_name = "rdpid",
        .description = "Support RDPID instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.rdrnd)] = .{
        .llvm_name = "rdrnd",
        .description = "Support RDRAND instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.rdseed)] = .{
        .llvm_name = "rdseed",
        .description = "Support RDSEED instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.retpoline)] = .{
        .llvm_name = "retpoline",
        .description = "Remove speculation of indirect branches from the generated code, either by avoiding them entirely or lowering them with a speculation blocking construct",
        .dependencies = featureSet(&[_]Feature{
            .retpoline_indirect_branches,
            .retpoline_indirect_calls,
        }),
    };
    result[@enumToInt(Feature.retpoline_external_thunk)] = .{
        .llvm_name = "retpoline-external-thunk",
        .description = "When lowering an indirect call or branch using a `retpoline`, rely on the specified user provided thunk rather than emitting one ourselves. Only has effect when combined with some other retpoline feature",
        .dependencies = featureSet(&[_]Feature{
            .retpoline_indirect_calls,
        }),
    };
    result[@enumToInt(Feature.retpoline_indirect_branches)] = .{
        .llvm_name = "retpoline-indirect-branches",
        .description = "Remove speculation of indirect branches from the generated code",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.retpoline_indirect_calls)] = .{
        .llvm_name = "retpoline-indirect-calls",
        .description = "Remove speculation of indirect calls from the generated code",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.rtm)] = .{
        .llvm_name = "rtm",
        .description = "Support RTM instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sahf)] = .{
        .llvm_name = "sahf",
        .description = "Support LAHF and SAHF instructions in 64-bit mode",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.serialize)] = .{
        .llvm_name = "serialize",
        .description = "Has serialize instruction",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.seses)] = .{
        .llvm_name = "seses",
        .description = "Prevent speculative execution side channel timing attacks by inserting a speculation barrier before memory reads, memory writes, and conditional branches. Implies LVI Control Flow integrity.",
        .dependencies = featureSet(&[_]Feature{
            .lvi_cfi,
        }),
    };
    result[@enumToInt(Feature.sgx)] = .{
        .llvm_name = "sgx",
        .description = "Enable Software Guard Extensions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sha)] = .{
        .llvm_name = "sha",
        .description = "Enable SHA instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.shstk)] = .{
        .llvm_name = "shstk",
        .description = "Support CET Shadow-Stack instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_3ops_lea)] = .{
        .llvm_name = "slow-3ops-lea",
        .description = "LEA instruction with 3 ops or certain registers is slow",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_incdec)] = .{
        .llvm_name = "slow-incdec",
        .description = "INC and DEC instructions are slower than ADD and SUB",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_lea)] = .{
        .llvm_name = "slow-lea",
        .description = "LEA instruction with certain arguments is slow",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_pmaddwd)] = .{
        .llvm_name = "slow-pmaddwd",
        .description = "PMADDWD is slower than PMULLD",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_pmulld)] = .{
        .llvm_name = "slow-pmulld",
        .description = "PMULLD instruction is slow",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_shld)] = .{
        .llvm_name = "slow-shld",
        .description = "SHLD instruction is slow",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_two_mem_ops)] = .{
        .llvm_name = "slow-two-mem-ops",
        .description = "Two memory operand instructions are slow",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_unaligned_mem_16)] = .{
        .llvm_name = "slow-unaligned-mem-16",
        .description = "Slow unaligned 16-byte memory access",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.slow_unaligned_mem_32)] = .{
        .llvm_name = "slow-unaligned-mem-32",
        .description = "Slow unaligned 32-byte memory access",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.soft_float)] = .{
        .llvm_name = "soft-float",
        .description = "Use software floating point features",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sse)] = .{
        .llvm_name = "sse",
        .description = "Enable SSE instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sse_unaligned_mem)] = .{
        .llvm_name = "sse-unaligned-mem",
        .description = "Allow unaligned memory operands with SSE instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.sse2)] = .{
        .llvm_name = "sse2",
        .description = "Enable SSE2 instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse,
        }),
    };
    result[@enumToInt(Feature.sse3)] = .{
        .llvm_name = "sse3",
        .description = "Enable SSE3 instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse2,
        }),
    };
    result[@enumToInt(Feature.sse4_1)] = .{
        .llvm_name = "sse4.1",
        .description = "Enable SSE 4.1 instructions",
        .dependencies = featureSet(&[_]Feature{
            .ssse3,
        }),
    };
    result[@enumToInt(Feature.sse4_2)] = .{
        .llvm_name = "sse4.2",
        .description = "Enable SSE 4.2 instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse4_1,
        }),
    };
    result[@enumToInt(Feature.sse4a)] = .{
        .llvm_name = "sse4a",
        .description = "Support SSE 4a instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse3,
        }),
    };
    result[@enumToInt(Feature.ssse3)] = .{
        .llvm_name = "ssse3",
        .description = "Enable SSSE3 instructions",
        .dependencies = featureSet(&[_]Feature{
            .sse3,
        }),
    };
    result[@enumToInt(Feature.tbm)] = .{
        .llvm_name = "tbm",
        .description = "Enable TBM instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.tsxldtrk)] = .{
        .llvm_name = "tsxldtrk",
        .description = "Support TSXLDTRK instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.uintr)] = .{
        .llvm_name = "uintr",
        .description = "Has UINTR Instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.use_aa)] = .{
        .llvm_name = "use-aa",
        .description = "Use alias analysis during codegen",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.use_glm_div_sqrt_costs)] = .{
        .llvm_name = "use-glm-div-sqrt-costs",
        .description = "Use Goldmont specific floating point div/sqrt costs",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.vaes)] = .{
        .llvm_name = "vaes",
        .description = "Promote selected AES instructions to AVX512/AVX registers",
        .dependencies = featureSet(&[_]Feature{
            .aes,
            .avx,
        }),
    };
    result[@enumToInt(Feature.vpclmulqdq)] = .{
        .llvm_name = "vpclmulqdq",
        .description = "Enable vpclmulqdq instructions",
        .dependencies = featureSet(&[_]Feature{
            .avx,
            .pclmul,
        }),
    };
    result[@enumToInt(Feature.vzeroupper)] = .{
        .llvm_name = "vzeroupper",
        .description = "Should insert vzeroupper instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.waitpkg)] = .{
        .llvm_name = "waitpkg",
        .description = "Wait and pause enhancements",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.wbnoinvd)] = .{
        .llvm_name = "wbnoinvd",
        .description = "Write Back No Invalidate",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.widekl)] = .{
        .llvm_name = "widekl",
        .description = "Support Key Locker wide Instructions",
        .dependencies = featureSet(&[_]Feature{
            .kl,
        }),
    };
    result[@enumToInt(Feature.x87)] = .{
        .llvm_name = "x87",
        .description = "Enable X87 float instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.xop)] = .{
        .llvm_name = "xop",
        .description = "Enable XOP instructions",
        .dependencies = featureSet(&[_]Feature{
            .fma4,
        }),
    };
    result[@enumToInt(Feature.xsave)] = .{
        .llvm_name = "xsave",
        .description = "Support xsave instructions",
        .dependencies = featureSet(&[_]Feature{}),
    };
    result[@enumToInt(Feature.xsavec)] = .{
        .llvm_name = "xsavec",
        .description = "Support xsavec instructions",
        .dependencies = featureSet(&[_]Feature{
            .xsave,
        }),
    };
    result[@enumToInt(Feature.xsaveopt)] = .{
        .llvm_name = "xsaveopt",
        .description = "Support xsaveopt instructions",
        .dependencies = featureSet(&[_]Feature{
            .xsave,
        }),
    };
    result[@enumToInt(Feature.xsaves)] = .{
        .llvm_name = "xsaves",
        .description = "Support xsaves instructions",
        .dependencies = featureSet(&[_]Feature{
            .xsave,
        }),
    };
    const ti = @typeInfo(Feature);
    for (result) |*elem, i| {
        elem.index = i;
        elem.name = ti.Enum.fields[i].name;
    }
    break :blk result;
};

pub const cpu = struct {
    pub const alderlake = CpuModel{
        .name = "alderlake",
        .llvm_name = "alderlake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avxvnni,
            .bmi,
            .bmi2,
            .cldemote,
            .clflushopt,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .hreset,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .ptwrite,
            .rdrnd,
            .rdseed,
            .sahf,
            .serialize,
            .sgx,
            .sse2,
            .sse4_2,
            .waitpkg,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const amdfam10 = CpuModel{
        .name = "amdfam10",
        .llvm_name = "amdfam10",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .lzcnt,
            .nopl,
            .popcnt,
            .prfchw,
            .sahf,
            .sse4a,
            .x87,
        }),
    };
    pub const athlon = CpuModel{
        .name = "athlon",
        .llvm_name = "athlon",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cmov,
            .cx8,
            .nopl,
            .x87,
        }),
    };
    pub const athlon_4 = CpuModel{
        .name = "athlon_4",
        .llvm_name = "athlon-4",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse,
            .x87,
        }),
    };
    pub const athlon_fx = CpuModel{
        .name = "athlon_fx",
        .llvm_name = "athlon-fx",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const athlon_mp = CpuModel{
        .name = "athlon_mp",
        .llvm_name = "athlon-mp",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse,
            .x87,
        }),
    };
    pub const athlon_tbird = CpuModel{
        .name = "athlon_tbird",
        .llvm_name = "athlon-tbird",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cmov,
            .cx8,
            .nopl,
            .x87,
        }),
    };
    pub const athlon_xp = CpuModel{
        .name = "athlon_xp",
        .llvm_name = "athlon-xp",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse,
            .x87,
        }),
    };
    pub const athlon64 = CpuModel{
        .name = "athlon64",
        .llvm_name = "athlon64",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const athlon64_sse3 = CpuModel{
        .name = "athlon64_sse3",
        .llvm_name = "athlon64-sse3",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const atom = CpuModel{
        .name = "atom",
        .llvm_name = "atom",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .sahf,
            .ssse3,
            .x87,
        }),
    };
    pub const barcelona = CpuModel{
        .name = "barcelona",
        .llvm_name = "barcelona",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .lzcnt,
            .nopl,
            .popcnt,
            .prfchw,
            .sahf,
            .sse4a,
            .x87,
        }),
    };
    pub const bdver1 = CpuModel{
        .name = "bdver1",
        .llvm_name = "bdver1",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .lwp,
            .lzcnt,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .sahf,
            .x87,
            .xop,
            .xsave,
        }),
    };
    pub const bdver2 = CpuModel{
        .name = "bdver2",
        .llvm_name = "bdver2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .bmi,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fast_bextr,
            .fma,
            .fxsr,
            .lwp,
            .lzcnt,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .sahf,
            .tbm,
            .x87,
            .xop,
            .xsave,
        }),
    };
    pub const bdver3 = CpuModel{
        .name = "bdver3",
        .llvm_name = "bdver3",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .bmi,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fast_bextr,
            .fma,
            .fsgsbase,
            .fxsr,
            .lwp,
            .lzcnt,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .sahf,
            .tbm,
            .x87,
            .xop,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const bdver4 = CpuModel{
        .name = "bdver4",
        .llvm_name = "bdver4",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .avx2,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fast_bextr,
            .fma,
            .fsgsbase,
            .fxsr,
            .lwp,
            .lzcnt,
            .mmx,
            .movbe,
            .mwaitx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .sahf,
            .tbm,
            .x87,
            .xop,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const bonnell = CpuModel{
        .name = "bonnell",
        .llvm_name = "bonnell",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .sahf,
            .ssse3,
            .x87,
        }),
    };
    pub const broadwell = CpuModel{
        .name = "broadwell",
        .llvm_name = "broadwell",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .avx,
            .avx2,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const btver1 = CpuModel{
        .name = "btver1",
        .llvm_name = "btver1",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .lzcnt,
            .mmx,
            .nopl,
            .popcnt,
            .prfchw,
            .sahf,
            .sse4a,
            .ssse3,
            .x87,
        }),
    };
    pub const btver2 = CpuModel{
        .name = "btver2",
        .llvm_name = "btver2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .avx,
            .bmi,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .sahf,
            .sse4a,
            .ssse3,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const c3 = CpuModel{
        .name = "c3",
        .llvm_name = "c3",
        .features = featureSet(&[_]Feature{
            .@"3dnow",
            .x87,
        }),
    };
    pub const c3_2 = CpuModel{
        .name = "c3_2",
        .llvm_name = "c3-2",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .sse,
            .x87,
        }),
    };
    pub const cannonlake = CpuModel{
        .name = "cannonlake",
        .llvm_name = "cannonlake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512ifma,
            .avx512vbmi,
            .avx512vl,
            .bmi,
            .bmi2,
            .clflushopt,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const cascadelake = CpuModel{
        .name = "cascadelake",
        .llvm_name = "cascadelake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512vl,
            .avx512vnni,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const cooperlake = CpuModel{
        .name = "cooperlake",
        .llvm_name = "cooperlake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bf16,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512vl,
            .avx512vnni,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const core_avx_i = CpuModel{
        .name = "core_avx_i",
        .llvm_name = "core-avx-i",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fsgsbase,
            .fxsr,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .rdrnd,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const core_avx2 = CpuModel{
        .name = "core_avx2",
        .llvm_name = "core-avx2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .avx2,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .rdrnd,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const core2 = CpuModel{
        .name = "core2",
        .llvm_name = "core2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sahf,
            .ssse3,
            .x87,
        }),
    };
    pub const corei7 = CpuModel{
        .name = "corei7",
        .llvm_name = "corei7",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
        }),
    };
    pub const corei7_avx = CpuModel{
        .name = "corei7_avx",
        .llvm_name = "corei7-avx",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const generic = CpuModel{
        .name = "generic",
        .llvm_name = "generic",
        .features = featureSet(&[_]Feature{
            .cx8,
            .x87,
        }),
    };
    pub const geode = CpuModel{
        .name = "geode",
        .llvm_name = "geode",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .cx8,
            .x87,
        }),
    };
    pub const goldmont = CpuModel{
        .name = "goldmont",
        .llvm_name = "goldmont",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .clflushopt,
            .cmov,
            .cx16,
            .cx8,
            .fsgsbase,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sha,
            .sse4_2,
            .ssse3,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const goldmont_plus = CpuModel{
        .name = "goldmont_plus",
        .llvm_name = "goldmont-plus",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .clflushopt,
            .cmov,
            .cx16,
            .cx8,
            .fsgsbase,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .ptwrite,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .sse4_2,
            .ssse3,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const haswell = CpuModel{
        .name = "haswell",
        .llvm_name = "haswell",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .avx2,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .rdrnd,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const _i386 = CpuModel{
        .name = "_i386",
        .llvm_name = "i386",
        .features = featureSet(&[_]Feature{
            .x87,
        }),
    };
    pub const _i486 = CpuModel{
        .name = "_i486",
        .llvm_name = "i486",
        .features = featureSet(&[_]Feature{
            .x87,
        }),
    };
    pub const _i586 = CpuModel{
        .name = "_i586",
        .llvm_name = "i586",
        .features = featureSet(&[_]Feature{
            .cx8,
            .x87,
        }),
    };
    pub const _i686 = CpuModel{
        .name = "_i686",
        .llvm_name = "i686",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .x87,
        }),
    };
    pub const icelake_client = CpuModel{
        .name = "icelake_client",
        .llvm_name = "icelake-client",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bitalg,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512ifma,
            .avx512vbmi,
            .avx512vbmi2,
            .avx512vl,
            .avx512vnni,
            .avx512vpopcntdq,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fsrm,
            .fxsr,
            .gfni,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .sse2,
            .sse4_2,
            .vaes,
            .vpclmulqdq,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const icelake_server = CpuModel{
        .name = "icelake_server",
        .llvm_name = "icelake-server",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bitalg,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512ifma,
            .avx512vbmi,
            .avx512vbmi2,
            .avx512vl,
            .avx512vnni,
            .avx512vpopcntdq,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fsrm,
            .fxsr,
            .gfni,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pconfig,
            .pku,
            .popcnt,
            .prfchw,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .sse2,
            .sse4_2,
            .vaes,
            .vpclmulqdq,
            .wbnoinvd,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const ivybridge = CpuModel{
        .name = "ivybridge",
        .llvm_name = "ivybridge",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fsgsbase,
            .fxsr,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .rdrnd,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const k6 = CpuModel{
        .name = "k6",
        .llvm_name = "k6",
        .features = featureSet(&[_]Feature{
            .cx8,
            .mmx,
            .x87,
        }),
    };
    pub const k6_2 = CpuModel{
        .name = "k6_2",
        .llvm_name = "k6-2",
        .features = featureSet(&[_]Feature{
            .@"3dnow",
            .cx8,
            .x87,
        }),
    };
    pub const k6_3 = CpuModel{
        .name = "k6_3",
        .llvm_name = "k6-3",
        .features = featureSet(&[_]Feature{
            .@"3dnow",
            .cx8,
            .x87,
        }),
    };
    pub const k8 = CpuModel{
        .name = "k8",
        .llvm_name = "k8",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const k8_sse3 = CpuModel{
        .name = "k8_sse3",
        .llvm_name = "k8-sse3",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const knl = CpuModel{
        .name = "knl",
        .llvm_name = "knl",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx512cd,
            .avx512er,
            .avx512f,
            .avx512pf,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prefetchwt1,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const knm = CpuModel{
        .name = "knm",
        .llvm_name = "knm",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx512cd,
            .avx512er,
            .avx512f,
            .avx512pf,
            .avx512vpopcntdq,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prefetchwt1,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const lakemont = CpuModel{
        .name = "lakemont",
        .llvm_name = "lakemont",
        .features = featureSet(&[_]Feature{
            .cx8,
        }),
    };
    pub const nehalem = CpuModel{
        .name = "nehalem",
        .llvm_name = "nehalem",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
        }),
    };
    pub const nocona = CpuModel{
        .name = "nocona",
        .llvm_name = "nocona",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const opteron = CpuModel{
        .name = "opteron",
        .llvm_name = "opteron",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx8,
            .fxsr,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const opteron_sse3 = CpuModel{
        .name = "opteron_sse3",
        .llvm_name = "opteron-sse3",
        .features = featureSet(&[_]Feature{
            .@"3dnowa",
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const penryn = CpuModel{
        .name = "penryn",
        .llvm_name = "penryn",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sahf,
            .sse4_1,
            .x87,
        }),
    };
    pub const pentium = CpuModel{
        .name = "pentium",
        .llvm_name = "pentium",
        .features = featureSet(&[_]Feature{
            .cx8,
            .x87,
        }),
    };
    pub const pentium_m = CpuModel{
        .name = "pentium_m",
        .llvm_name = "pentium-m",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const pentium_mmx = CpuModel{
        .name = "pentium_mmx",
        .llvm_name = "pentium-mmx",
        .features = featureSet(&[_]Feature{
            .cx8,
            .mmx,
            .x87,
        }),
    };
    pub const pentium2 = CpuModel{
        .name = "pentium2",
        .llvm_name = "pentium2",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .x87,
        }),
    };
    pub const pentium3 = CpuModel{
        .name = "pentium3",
        .llvm_name = "pentium3",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse,
            .x87,
        }),
    };
    pub const pentium3m = CpuModel{
        .name = "pentium3m",
        .llvm_name = "pentium3m",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse,
            .x87,
        }),
    };
    pub const pentium4 = CpuModel{
        .name = "pentium4",
        .llvm_name = "pentium4",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const pentium4m = CpuModel{
        .name = "pentium4m",
        .llvm_name = "pentium4m",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const pentiumpro = CpuModel{
        .name = "pentiumpro",
        .llvm_name = "pentiumpro",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .nopl,
            .x87,
        }),
    };
    pub const prescott = CpuModel{
        .name = "prescott",
        .llvm_name = "prescott",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const sandybridge = CpuModel{
        .name = "sandybridge",
        .llvm_name = "sandybridge",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx,
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsaveopt,
        }),
    };
    pub const sapphirerapids = CpuModel{
        .name = "sapphirerapids",
        .llvm_name = "sapphirerapids",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .amx_bf16,
            .amx_int8,
            .amx_tile,
            .avx,
            .avx2,
            .avx512bf16,
            .avx512bitalg,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512ifma,
            .avx512vbmi,
            .avx512vbmi2,
            .avx512vl,
            .avx512vnni,
            .avx512vp2intersect,
            .avx512vpopcntdq,
            .avxvnni,
            .bmi,
            .bmi2,
            .cldemote,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .enqcmd,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fsrm,
            .fxsr,
            .gfni,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .movdir64b,
            .movdiri,
            .nopl,
            .pclmul,
            .pconfig,
            .pku,
            .popcnt,
            .prfchw,
            .ptwrite,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .serialize,
            .sgx,
            .sha,
            .shstk,
            .sse2,
            .sse4_2,
            .tsxldtrk,
            .uintr,
            .vaes,
            .vpclmulqdq,
            .waitpkg,
            .wbnoinvd,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const silvermont = CpuModel{
        .name = "silvermont",
        .llvm_name = "silvermont",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .sahf,
            .sse4_2,
            .ssse3,
            .x87,
        }),
    };
    pub const skx = CpuModel{
        .name = "skx",
        .llvm_name = "skx",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512vl,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const skylake = CpuModel{
        .name = "skylake",
        .llvm_name = "skylake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .bmi,
            .bmi2,
            .clflushopt,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const skylake_avx512 = CpuModel{
        .name = "skylake_avx512",
        .llvm_name = "skylake-avx512",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512vl,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const slm = CpuModel{
        .name = "slm",
        .llvm_name = "slm",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .sahf,
            .sse4_2,
            .ssse3,
            .x87,
        }),
    };
    pub const tigerlake = CpuModel{
        .name = "tigerlake",
        .llvm_name = "tigerlake",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx,
            .avx2,
            .avx512bitalg,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512f,
            .avx512ifma,
            .avx512vbmi,
            .avx512vbmi2,
            .avx512vl,
            .avx512vnni,
            .avx512vp2intersect,
            .avx512vpopcntdq,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .ermsb,
            .f16c,
            .fma,
            .fsgsbase,
            .fsrm,
            .fxsr,
            .gfni,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .movdir64b,
            .movdiri,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .shstk,
            .sse2,
            .sse4_2,
            .vaes,
            .vpclmulqdq,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const tremont = CpuModel{
        .name = "tremont",
        .llvm_name = "tremont",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .aes,
            .clflushopt,
            .clwb,
            .cmov,
            .cx16,
            .cx8,
            .fsgsbase,
            .fxsr,
            .gfni,
            .mmx,
            .movbe,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .ptwrite,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sgx,
            .sha,
            .sse4_2,
            .ssse3,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const westmere = CpuModel{
        .name = "westmere",
        .llvm_name = "westmere",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .pclmul,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
        }),
    };
    pub const winchip_c6 = CpuModel{
        .name = "winchip_c6",
        .llvm_name = "winchip-c6",
        .features = featureSet(&[_]Feature{
            .mmx,
            .x87,
        }),
    };
    pub const winchip2 = CpuModel{
        .name = "winchip2",
        .llvm_name = "winchip2",
        .features = featureSet(&[_]Feature{
            .@"3dnow",
            .x87,
        }),
    };
    pub const x86_64 = CpuModel{
        .name = "x86_64",
        .llvm_name = "x86-64",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse2,
            .x87,
        }),
    };
    pub const x86_64_v2 = CpuModel{
        .name = "x86_64_v2",
        .llvm_name = "x86-64-v2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .cmov,
            .cx16,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
        }),
    };
    pub const x86_64_v3 = CpuModel{
        .name = "x86_64_v3",
        .llvm_name = "x86-64-v3",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx2,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fma,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
        }),
    };
    pub const x86_64_v4 = CpuModel{
        .name = "x86_64_v4",
        .llvm_name = "x86-64-v4",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .avx2,
            .avx512bw,
            .avx512cd,
            .avx512dq,
            .avx512vl,
            .bmi,
            .bmi2,
            .cmov,
            .cx16,
            .cx8,
            .f16c,
            .fma,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .nopl,
            .popcnt,
            .sahf,
            .sse2,
            .sse4_2,
            .x87,
            .xsave,
        }),
    };
    pub const yonah = CpuModel{
        .name = "yonah",
        .llvm_name = "yonah",
        .features = featureSet(&[_]Feature{
            .cmov,
            .cx8,
            .fxsr,
            .mmx,
            .nopl,
            .sse3,
            .x87,
        }),
    };
    pub const znver1 = CpuModel{
        .name = "znver1",
        .llvm_name = "znver1",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx2,
            .bmi,
            .bmi2,
            .clflushopt,
            .clzero,
            .cmov,
            .cx16,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .mwaitx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdrnd,
            .rdseed,
            .sahf,
            .sha,
            .sse4a,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const znver2 = CpuModel{
        .name = "znver2",
        .llvm_name = "znver2",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx2,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .clzero,
            .cmov,
            .cx16,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .lzcnt,
            .mmx,
            .movbe,
            .mwaitx,
            .nopl,
            .pclmul,
            .popcnt,
            .prfchw,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sha,
            .sse4a,
            .wbnoinvd,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
    pub const znver3 = CpuModel{
        .name = "znver3",
        .llvm_name = "znver3",
        .features = featureSet(&[_]Feature{
            .@"64bit",
            .adx,
            .aes,
            .avx2,
            .bmi,
            .bmi2,
            .clflushopt,
            .clwb,
            .clzero,
            .cmov,
            .cx16,
            .f16c,
            .fma,
            .fsgsbase,
            .fxsr,
            .invpcid,
            .lzcnt,
            .mmx,
            .movbe,
            .mwaitx,
            .nopl,
            .pclmul,
            .pku,
            .popcnt,
            .prfchw,
            .rdpid,
            .rdrnd,
            .rdseed,
            .sahf,
            .sha,
            .sse4a,
            .vaes,
            .vpclmulqdq,
            .wbnoinvd,
            .x87,
            .xsave,
            .xsavec,
            .xsaveopt,
            .xsaves,
        }),
    };
};
