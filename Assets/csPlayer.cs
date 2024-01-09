using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.UI;

public class csPlayer : MonoBehaviour
{
    public Text NickName;
    public GameObject Bullet;
    public Transform FirePos;

    void Start()
    {        
        //NickName.text = photonView.IsMine ? PhotonNetwork.NickName : photonView.Owner.NickName;
        //GetComponent<Renderer>().material.color = photonView.IsMine ? Color.green : Color.red;

        if (false)
        {
            transform.GetChild(2).gameObject.SetActive(true);            
        } else
        {
            GetComponent<Rigidbody>().detectCollisions = false;
        }
    }

    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Instantiate(Bullet, FirePos.transform.position, FirePos.transform.rotation);
        }
        float x = Input.GetAxis("Horizontal") * Time.deltaTime * 150f;
        float z = Input.GetAxis("Vertical") * Time.deltaTime * 3.0f;
        transform.Rotate(0, x, 0);
        transform.Translate(0, 0, z);

    }
}
