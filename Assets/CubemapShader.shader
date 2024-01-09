Shader "Custom/CubemapShader"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_NoiseTex ("Noise", 2D) = "white" {}
		_Cut ("Alpha Cut", Range(0,1)) = 1
		[HDR]_OutColor ("OutColor", Color) = (1,1,1,1)
		_OutThickness ("OutThickness", Range(1,1.5)) = 1.15
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		CGPROGRAM
		#pragma surface surf Lambert alpha:fade
		sampler2D _MainTex;
		sampler2D _NoiseTex;
		float _Cut;
		float4 _OutColor;
		float _OutThickness;
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_NoiseTex;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 noise = tex2D (_NoiseTex, IN.uv_NoiseTex);
			o.Albedo = c.rgb;
			float alpha;
			if (noise.r >= _Cut - (_Time.y * 0.1 ))
				alpha = 1;
			else
				alpha = 0;
			o.Alpha = 1 * alpha;

			// Outline
			//float outline = noise.r >= cut*_OutThickness ? 0.0 : 1.0;
			//o.Emission = outline * _OutColor.rgb;
		}
		ENDCG
    }
    FallBack "Diffuse"
}
