﻿Shader "Custom/NewSurfaceShader 2"
{
    Properties
	{

		_Bumpmap ("NormalMap" , 2D) = "bump" {}
		_Cube ("cube", Cube) = " "{}

		_Cut("Alpha Cut", Range(0,1)) = 1
		_NoiseTex("Noise", 2D) = "white" {}

		_Scale("Scale" , float) = 1
		_Speed("Speed" , float) = 1
		_waterFre("_waterFre" , float) = 1
		_Frequency("_Frequency" , float) = 1

		[HideInInspector]_WaveAmplitude1("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude2("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude3("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude4("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude5("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude6("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude7("WaveAmplitude1", float) = 0
	  [HideInInspector]_WaveAmplitude8("WaveAmplitude1", float) = 0
	  [HideInInspector]_xImpact1("x Impact 1", float) = 0
	  [HideInInspector]_zImpact1("z Impact 1", float) = 0
	  [HideInInspector]_xImpact2("x Impact 2", float) = 0
	  [HideInInspector]_zImpact2("z Impact 2", float) = 0
	  [HideInInspector]_xImpact3("x Impact 3", float) = 0
	  [HideInInspector]_zImpact3("z Impact 3", float) = 0
	  [HideInInspector]_xImpact4("x Impact 4", float) = 0
	  [HideInInspector]_zImpact4("z Impact 4", float) = 0
	  [HideInInspector]_xImpact5("x Impact 5", float) = 0
	  [HideInInspector]_zImpact5("z Impact 5", float) = 0
	  [HideInInspector]_xImpact6("x Impact 6", float) = 0
	  [HideInInspector]_zImpact6("z Impact 6", float) = 0
	  [HideInInspector]_xImpact7("x Impact 7", float) = 0
	  [HideInInspector]_zImpact7("z Impact 7", float) = 0
	  [HideInInspector]_xImpact8("x Impact 8", float) = 0
	  [HideInInspector]_zImpact8("z Impact 8", float) = 0

	  [HideInInspector]_Distance1("Distance1", float) = 0
	  [HideInInspector]_Distance2("Distance2", float) = 0
	  [HideInInspector]_Distance3("Distance3", float) = 0
	  [HideInInspector]_Distance4("Distance4", float) = 0
	  [HideInInspector]_Distance5("Distance5", float) = 0
	  [HideInInspector]_Distance6("Distance6", float) = 0
	  [HideInInspector]_Distance7("Distance7", float) = 0
	  [HideInInspector]_Distance8("Distance8", float) = 0

    }
    SubShader
    {
        Tags { "RenderType"= "Transparent" "Queue" = "Transparent" }


        LOD 200

		GrabPass{}

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert alpha:fade vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _Bumpmap;
		samplerCUBE _Cube;
		sampler2D _NoiseTex;
		float _Cut;
		float _Scale, _Speed, _Frequency, _waterFre;
		float _WaveAmplitude1, _WaveAmplitude2, _WaveAmplitude3, _WaveAmplitude4, _WaveAmplitude5, _WaveAmplitude6, _WaveAmplitude7, _WaveAmplitude8;
		float _OffsetX1, _OffsetZ1, _OffsetX2, _OffsetZ2, _OffsetX3, _OffsetZ3, _OffsetX4, _OffsetZ4, _OffsetX5, _OffsetZ5, _OffsetX6, _OffsetZ6, _OffsetX7, _OffsetZ7, _OffsetX8, _OffsetZ8;
		float _Distance1, _Distance2, _Distance3, _Distance4, _Distance5, _Distance6, _Distance7, _Distance8;
		float _xImpact1, _zImpact1, _xImpact2, _zImpact2, _xImpact3, _zImpact3, _xImpact4, _zImpact4, _xImpact5, _zImpact5, _xImpact6, _zImpact6,
			_xImpact7, _zImpact7, _xImpact8, _zImpact8;

        struct Input
        {
            float2 uv_Bumpmap;
			float3 worldRefl;
			float3 viewDir;
			float3 customValue;


			float2 uv_NoiseTex;

			INTERNAL_DATA
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

			void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);

			

			half offsetvert = ((v.vertex.x * v.vertex.x) + (v.vertex.z * v.vertex.z));
			half offsetvert2 = v.vertex.x + v.vertex.z;

			//half value1 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX1) + (v.vertex.z * _OffsetZ1));

			half value1 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX1) + (v.vertex.z * _OffsetZ1));
			half value2 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX2) + (v.vertex.z * _OffsetZ2));
			half value3 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX3) + (v.vertex.z * _OffsetZ3));
			half value4 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX4) + (v.vertex.z * _OffsetZ4));
			half value5 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX5) + (v.vertex.z * _OffsetZ5));
			half value6 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX6) + (v.vertex.z * _OffsetZ6));
			half value7 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX7) + (v.vertex.z * _OffsetZ7));
			half value8 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX8) + (v.vertex.z * _OffsetZ8));

			half value10 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * 300.0) + (v.vertex.z * -300.0));
			half value = _Scale/2 * sin(_Time.w * _Speed + offsetvert2 * _waterFre);




			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

			v.vertex.y += value;

			o.customValue += value;

			if (sqrt(pow(worldPos.x - _xImpact1, 2) + pow(worldPos.z - _zImpact1, 2)) < _Distance1)
			{
				v.vertex.y += value1 * (_WaveAmplitude1);
				v.normal.y += value1 * (_WaveAmplitude1);
				o.customValue += value1 * (_WaveAmplitude1);

			}
			if (sqrt(pow(worldPos.x - _xImpact2, 2) + pow(worldPos.z - _zImpact2, 2)) < _Distance2)
			{
				v.vertex.y += value2 * _WaveAmplitude2;
				v.normal.y += value2 * _WaveAmplitude2;
				o.customValue += value2 * _WaveAmplitude2;
			}
			if (sqrt(pow(worldPos.x - _xImpact3, 2) + pow(worldPos.z - _zImpact3, 2)) < _Distance3)
			{
				v.vertex.y += value3 * _WaveAmplitude3;
				v.normal.y += value3 * _WaveAmplitude3;
				o.customValue += value3 * _WaveAmplitude3;
			}
			if (sqrt(pow(worldPos.x - _xImpact4, 2) + pow(worldPos.z - _zImpact4, 2)) < _Distance4)
			{
				v.vertex.y += value4 * _WaveAmplitude4;
				v.normal.y += value4 * _WaveAmplitude4;
				o.customValue += value4 * _WaveAmplitude4;
			}
			if (sqrt(pow(worldPos.x - _xImpact5, 2) + pow(worldPos.z - _zImpact5, 2)) < _Distance5)
			{
				v.vertex.y += value5 * _WaveAmplitude5;
				v.normal.y += value5 * _WaveAmplitude5;
				o.customValue += value5 * _WaveAmplitude5;
			}
			if (sqrt(pow(worldPos.x - _xImpact6, 2) + pow(worldPos.z - _zImpact6, 2)) < _Distance6)
			{
				v.vertex.y += value6 * _WaveAmplitude6;
				v.normal.y += value6 * _WaveAmplitude6;
				o.customValue += value6 * _WaveAmplitude6;
			}
			if (sqrt(pow(worldPos.x - _xImpact7, 2) + pow(worldPos.z - _zImpact7, 2)) < _Distance7)
			{
				v.vertex.y += value7 * _WaveAmplitude7;
				v.normal.y += value7 * _WaveAmplitude7;
				o.customValue += value7 * _WaveAmplitude7;
			}
			if (sqrt(pow(worldPos.x - _xImpact8, 2) + pow(worldPos.z - _zImpact8, 2)) < _Distance8)
			{
				v.vertex.y += value8 * _WaveAmplitude8;
				v.normal.y += value8 * _WaveAmplitude8;
				o.customValue += value8 * _WaveAmplitude8;
			}

		}

        void surf (Input IN, inout SurfaceOutput o)
        {
			float3 nor1 = UnpackNormal(tex2D(_Bumpmap, IN.uv_Bumpmap + _Time.x * 0.3));
			float3 nor2 = UnpackNormal(tex2D(_Bumpmap, IN.uv_Bumpmap - _Time.x * 0.3));

			o.Normal = nor1 + nor2;

			fixed4 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);

			float alpha;
			if (noise.r >= _Cut - (_Time.y * 0.1))
				alpha = 1;
			else
				alpha = 0;
			o.Alpha = 0.2 * alpha;

            // Albedo comes from a texture tinted by color
            o.Normal = nor1 + nor2;


			float3 refcolor = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal));
			
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1 - rim, 1.5);

			o.Normal.y += IN.customValue;

			o.Emission = refcolor * rim * 2;
			o.Alpha = saturate(rim + 0.5) * alpha ;


        }
        ENDCG
    }
    FallBack "Legacy shaders/Transparent/Vertexlit"
}
