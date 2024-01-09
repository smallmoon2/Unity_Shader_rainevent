﻿Shader "Custom/NewSurfaceShader 3"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0
		_BumpMap("Normal map", 2D) = "bump" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		_Specular("Specular", 2D) = "white" {}

		_Cut("Alpha Cut", Range(0,1)) = 0
		_NoiseTex("Noise", 2D) = "white" {}

	}
		SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }

		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:fade
		
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _Occlusion;
		sampler2D _Specular;
		sampler2D _NoiseTex;
		float _Cut;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float2 uv_NoiseTex;
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

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed3 n = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Occlusion = tex2D(_Occlusion, IN.uv_MainTex);
			fixed4 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);

			o.Normal = n;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;




		}
		ENDCG
	}
		FallBack "Diffuse"
}
