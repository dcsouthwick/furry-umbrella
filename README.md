# furry-umbrella
## 1 Dockerfile, 1 Image.

Universal Base images for extending HPC heterogeneous workloads

This repo contains dockerfile defs for GPU-agnostic docker images. 
> Avoid the "Matrix from Hell" when deploying accelerator-enabled software

## How to use this?
If your code is compile-at-runtime (JIT in java-world), simply use this image in your `FROM` line.

Some popular languages include:
* Python
* OpenCL
* Java-derived family
* CLR & Mono
* Objective-C
* V8/Node.js
* C family (requires libraries)

**BUT WAIT! What if my language requires compiling?**

You can either:
* Compile libraries for ROCm and CUDA in a multistage dockerfile, and include some switching logic
* Use single-source tools (such as [ROCm HIP](https://github.com/ROCm-Developer-Tools/HIP))
