Shader "Custom/NewSurfaceShader 1"
{
    Properties
    {
		_Color("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Scale("Scale" ,Range(0,5)) = 0.0
		_Speed("Speed" , Range(-5,5)) = 0.0
		_Frequency("_Frequency" , Range(0,10)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM

        #pragma surface surf Lambert vertex:vert


        sampler2D _MainTex;
		float _Scale, _Speed, _Frequency;

		struct Input {
			float2 uv_MainTex;
			float3 customValue;
		};


		half4 _Color;


		void vert(inout appdata_full v, out Input o) {
			UNITY_INITIALIZE_OUTPUT(Input, o);

			half offsetvert = ((v.vertex.x * v.vertex.x) + (v.vertex.z * v.vertex.z));
			//half offsetvert = (v.vertex.x + v.vertex.x);
			half value = _Scale * sin(_Time.w * _Speed + offsetvert * _Frequency);

			//half value = _Scale * sin(_Time.w * _Speed * offsetvert + _Frequency);

			v.vertex.y += value;
			o.customValue = value;
		}

		void surf(Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = _Color.rgb;
			o.Normal.y += IN.customValue;
		}
        ENDCG
    }
    FallBack "Diffuse"
}
