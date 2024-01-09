using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class camera : MonoBehaviour
{
    public Material mat;

    public float val = 0f;
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {

        //GetComponent<Renderer>().material.SetFloat("_screenmove", 0);
        Graphics.Blit(src, dest, mat);


    }
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            print(transform.eulerAngles.x);
            //GetComponent<Renderer>().material.SetFloat("_screenmove", 0);
        }

        if(transform.eulerAngles.x < 330 & transform.eulerAngles.x > 250)
        {
            if (val < 250)
            {
                print(val);
                print(val / 10000);
                mat.SetFloat("_screenmove", val / 10000);
                val += 1;
            }

        }
        else
        {
            print("작아짐");
            print(val / 10000);
            print(val);
            mat.SetFloat("_screenmove", val / 10000);
            if (val > 0.3f)
            {
                val -= 0.2f;
            }
        }


    }
}
