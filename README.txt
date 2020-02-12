bazel build //example --verbose_failures --crosstool_top=@androidndk//:default_crosstool --host_crosstool_top=@bazel_tools//tools/cpp:toolchain --cpu=x86 --platforms=@io_bazel_rules_go//go/toolchain:android_386_cgo

This yields the following (Go?) linker error:

internal/cpu.processOptions: relocation target __x86.get_pc_thunk.dx not defined
internal/cpu.processOptions: relocation target __x86.get_pc_thunk.ax not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.ax not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.si not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.cx not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.bx not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.bp not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.dx not defined
internal/cpu.doinit: relocation target __x86.get_pc_thunk.di not defined
cmpbody: relocation target __x86.get_pc_thunk.cx not defined
memeqbody: relocation target __x86.get_pc_thunk.cx not defined
runtime.f32hash: relocation target __x86.get_pc_thunk.ax not defined
runtime.f64hash: relocation target __x86.get_pc_thunk.ax not defined
runtime.interhash: relocation target __x86.get_pc_thunk.dx not defined
runtime.interhash: relocation target __x86.get_pc_thunk.ax not defined
runtime.nilinterhash: relocation target __x86.get_pc_thunk.dx not defined
runtime.nilinterhash: relocation target __x86.get_pc_thunk.ax not defined
runtime.efaceeq: relocation target __x86.get_pc_thunk.dx not defined
runtime.efaceeq: relocation target __x86.get_pc_thunk.ax not defined
runtime.ifaceeq: relocation target __x86.get_pc_thunk.dx not defined
runtime.ifaceeq: relocation target __x86.get_pc_thunk.ax not defined
external/go_sdk/pkg/tool/linux_amd64/link: too many errors

------------

bazel build //example --verbose_failures --crosstool_top=@androidndk//:default_crosstool --host_crosstool_top=@bazel_tools//tools/cpp:toolchain --cpu=x86_64 --platforms=@io_bazel_rules_go//go/toolchain:android_amd64_cgo

This compiles, but at runtime (started with adb shell) throws
"/system/bin/sh: ./example: No such file or directory" although the file is definitely available and executable (possibly because the linker cannot be found).
The "file" tool reports: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), dynamically linked, interpreter /system/, not stripped

------------

bazel build //example --verbose_failures --crosstool_top=@androidndk//:default_crosstool --host_crosstool_top=@bazel_tools//tools/cpp:toolchain --cpu="armeabi-v7a" --platforms=@io_bazel_rules_go//go/toolchain:android_arm_cgo

This compiles, but at runtime (started with adb shell) throws
"error: only position independent executables (PIE) are supported."
The "file" tool reports: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /system/, not stripped

------------

bazel build //example --verbose_failures --crosstool_top=@androidndk//:default_crosstool --host_crosstool_top=@bazel_tools//tools/cpp:toolchain --cpu="arm64-v8a" --platforms=@io_bazel_rules_go//go/toolchain:android_arm64_cgo

This compiles, but at runtime (started with adb shell) throws
"CANNOT LINK EXECUTABLE "./example": text relocations (DT_TEXTREL) found in 64-bit ELF file "/data/local/tmp/example"
The "file" tool reports: ELF 64-bit LSB shared object, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /system/, not stripped