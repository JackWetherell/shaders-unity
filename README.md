# Learn Shaders

A personal study project for understanding computer graphics from first principles: from how microprocessors encode numbers in silicon, all the way up to writing real shaders that run on GPU hardware.

The goal is not just to *use* shaders, but to understand *why* they work: what is actually happening at the hardware level when a pixel is shaded on screen.

---

## Pedagogical Goals

### 1. Understand the fundamentals

Before writing a single line of shader code, the aim is to understand what the hardware is actually doing:

- How binary numbers are stored in memory and what a `float` really is at the bit level
- How 3D geometry (vertices, triangles, meshes) is laid out in memory as plain arrays of numbers
- How matrix transformations move geometry through coordinate spaces (local → world → camera → clip → screen)
- How the rasterizer converts triangles into fragments, and how barycentric coordinates drive interpolation
- How lighting models (Lambertian diffuse, ambient) are derived from physical principles
- How the GPU executes thousands of shader invocations in parallel via SIMD
- How uv coordinates encode data and how it relates to textures.

This theory is documented in [`notes/notes.tex`](notes/notes.tex) (compiled to [`notes/notes.pdf`](notes/notes.pdf)), a reference titled *"From Bits to Pixels: The Mathematical and Physical Foundations of elementary 3D Graphics"*.

### 2. Apply that understanding in real shader code

Theory is tested against working GPU code. Each concept from the notes has a concrete counterpart in a real shader:

| Theory | In practice |
|---|---|
| IEEE 754 floats | `float`, `float4` types in HLSL |
| Matrix-vector multiply | `UnityObjectToClipPos()` in the vertex shader |
| Barycentric interpolation | varyings automatically interpolated by the rasterizer |
| Lambertian diffuse | `max(0, dot(N, L))` in the fragment shader |
| Coordinate spaces | `_WorldSpaceLightPos0`, world-space normals |

The Unity project lives in [`Unity/`](Unity/), using **Unity 2022.3 LTS** with **ShaderLab / HLSL** (`CGPROGRAM` blocks).

### 3. Progress to more expressive environments

Once the fundamentals are solid in Unity, the plan is to apply the same understanding in:

- **[Shadertoy](https://www.shadertoy.com/)**: pure fragment shader programming with no scene graph; forces a deeper understanding of ray marching, SDFs, and procedural geometry
- **Unreal Engine Material Graph**: node-based shader authoring; understanding the underlying math makes the graph readable rather than magical

---

## Inspiration & Resources

This project follows along with and is inspired by the excellent tutorial series:

**[Shaders For Game Devs](https://www.youtube.com/playlist?list=PLImQaTpSAdsCnJon-Eir92SZMl7tPBS4Z)** by [Freya Holmér](https://www.youtube.com/@acegikmo)

Freya's series is one of the clearest introductions to shader programming available as it builds intuition from the ground up and connects visual output directly to the underlying mathematics.

---

## The Notes Document

*"From Bits to Pixels"* covers:

1. **Foundations**: binary, bytes, IEEE 754 floating point, memory layout
2. **Geometry**: vertices, triangles, indexed meshes, scene graphs
3. **Basis Vectors**: coordinate systems, matrix representations, basis transitions
4. **Coordinate Spaces**: local, world, camera, clip, NDC, screen space
5. **Rasterization**: triangle setup, barycentric coordinates, depth testing
6. **Lighting**: surface normals, Lambertian diffuse, ambient, shadow mapping
7. **Memory Layout**: vertex buffers, index buffers, transformation storage
8. **GPU Hardware**: fixed-function units, RT cores, tensor cores
9. **Shaders in Practice**: ShaderLab structure, Properties, vertex & fragment shaders in HLSL, swizzling, data flow

The document is written alongside the shader experiments so that every equation has a corresponding line of real GPU code.
