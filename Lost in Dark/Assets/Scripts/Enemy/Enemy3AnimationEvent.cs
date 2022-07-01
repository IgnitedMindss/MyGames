using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy3AnimationEvent : MonoBehaviour
{
    private Enemy3 spider;

    private void Start(){
        spider = transform.parent.GetComponent<Enemy3>();
    }

    public void Fire(){
        Debug.Log("Enemy3 has fired");
        spider.Attack();
    }
}
