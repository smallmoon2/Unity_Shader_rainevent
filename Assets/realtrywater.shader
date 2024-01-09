Shader "Custom/realtrywater"
{
	Properties{
		 _MainTex("Base (RGB)", 2D) = "white" {}
		 _BumpMap("Bumpmap", 2D) = "bump" {}
		 _Color("Color", Color) = (1,1,1,1)
		 _Glossiness("Smoothness", Range(0,1)) = 0.5
		 _Metallic("Metallic", Range(0,1)) = 0.0
		 _Scale("Scale", float) = 1
		 _Speed("Speed", float) = 1
		 _Frequency("Frequency", float) = 1
		 [HideInInspector]_WaveAmplitude1("WaveAmplitude1", float) = 0
   [HideInInspector]_xImpact1("x Impact 1", float) = 0
   [HideInInspector]_zImpact1("z Impact 1", float) = 0
   [HideInInspector]_Distance1("Distance1", float) = 0



	}
		SubShader{
			Tags { "RenderType" = "Opaque" "Queue" = "Geometry+1" "ForceNoShadowCasting" = "True" }
			LOD 200

			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows vertex:vert
			#pragma target 4.0

			sampler2D _MainTex;
			sampler2D _BumpMap;
			half _Glossiness;
			half _Metallic;
			float _Scale, _Speed, _Frequency;
			half4 _Color;
			float _WaveAmplitude1;
			float _OffsetX1, _OffsetZ1;
			float _Distance1;
			float _xImpact1, _zImpact1;

			struct Input {
				float2 uv_MainTex;
				 float2 uv_BumpMap;
				float3 customValue;
			};

			void vert(inout appdata_full v, out Input o)
			{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			half offsetvert = ((v.vertex.x * v.vertex.x) + (v.vertex.z * v.vertex.z));
			half offsetvert2 = v.vertex.x + v.vertex.z; //diagonal waves
			//half offsetvert2 = v.vertex.x; //horizontal waves

			half value0 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert2);
			half value1 = _Scale * sin(_Time.w * _Speed * _Frequency + offsetvert + (v.vertex.x * _OffsetX1) + (v.vertex.z * _OffsetZ1));

			float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;


			v.vertex.y += value0; //remove for no waves
			v.normal.y += value0; //remove for no waves
			o.customValue += value0;


			if (sqrt(pow(worldPos.x - _xImpact1, 2) + pow(worldPos.z - _zImpact1, 2)) < _Distance1)
			{
			v.vertex.y += value1 * _WaveAmplitude1;
			v.normal.y += value1 * _WaveAmplitude1;
			o.customValue += value1 * _WaveAmplitude1;

			}
			}

			void surf(Input IN, inout SurfaceOutputStandard o) {
				// Albedo comes from a texture tinted by color
				fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
				o.Albedo = c.rgb;
				// Metallic and smoothness come from slider variables
				o.Metallic = _Metallic;
				o.Smoothness = _Glossiness;
				o.Alpha = c.a;
				 o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap) * 0.2);
				 o.Normal.y += IN.customValue;
			}
			ENDCG
		 }
			 FallBack "Diffuse"
}
