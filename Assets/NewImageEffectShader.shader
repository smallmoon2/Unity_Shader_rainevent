Shader "Hidden/NewImageEffectShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_OtherTex("_OtherTex", 2D) = "white" {}
		_screenmove("_screenmove", float) = 0
	}
		SubShader
		{
			// No culling or depth
			Cull Off ZWrite Off ZTest Always

			Pass
			{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				float _screenmove;
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
			sampler2D _OtherTex;

            fixed4 frag (v2f i) : SV_Target
            {
				float2 ot = tex2D(_OtherTex, i.uv).xy;
				ot = ot * _screenmove;
                fixed4 col = tex2D(_MainTex, i.uv+ot);
                // just invert the colors
                col.rgb = col.rgb;
                return col;
            }
            ENDCG
        }
    }
}
