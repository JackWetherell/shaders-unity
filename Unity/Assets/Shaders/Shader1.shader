Shader "Unlit/Shader1"
{
    Properties
    {
        _ColorA ("ColorA", Color) = (0, 0, 0, 0)
        _ColorB ("ColorB", Color) = (1, 1, 1, 1)
        _Scale("UV Scale", float) = 1
        _Offset("UV Offset", float) = 0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float4 _ColorA;
            float4 _ColorB;
            float _Scale;
            float _Offset;

            struct MeshData
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators
            {
                float4 vertex : SV_POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
                
            };

            Interpolators vert(MeshData v)
            {
                Interpolators o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = (v.uv + _Offset) * _Scale;
                return o;
            }

            float4 frag(Interpolators i) : SV_Target
            {
                float4 outColor = lerp(_ColorA, _ColorB, i.uv.x);
                return outColor;
            }
            ENDCG
        }
    }
}
