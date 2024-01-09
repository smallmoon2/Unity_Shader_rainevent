using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class player : MonoBehaviour
{
    public GameObject Bullet;
    public Transform FirePos;
    public float speed = 5f;
    private float h = 0.0f;
    private float v = 0.0f;
    // Start is called before the first frame update
    void Start()
    {
        print("gd");

    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            print("gd");

            GameObject obj = Instantiate(Bullet, FirePos.transform.position, Quaternion.identity);
            obj.GetComponent<Rigidbody>().AddForce(FirePos.transform.forward * 300f);


        }
        h += speed * Input.GetAxis("Mouse X");
        v -= speed * Input.GetAxis("Mouse Y");
        transform.eulerAngles = new Vector3(v, h, 0.0f);

        if (Input.GetKey(KeyCode.LeftArrow))
        {
            transform.Translate(-speed * Time.deltaTime, 0, 0);
        }
        else if (Input.GetKey(KeyCode.RightArrow))
        {
            transform.Translate(speed * Time.deltaTime, 0, 0);
        }
        else if (Input.GetKey(KeyCode.UpArrow))
        {
            transform.Translate(0, 0, speed * Time.deltaTime);
        }
        else if (Input.GetKey(KeyCode.DownArrow))
        {
            transform.Translate(0, 0, -speed * Time.deltaTime);
        }
    }

}
