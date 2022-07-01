using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyCasting : MonoBehaviour
{
    // If not close to player, player will not deal any damage
    public bool closeToPlayer = false;
    public float distance;
    void Update()
    {
        RaycastHit Hit;
        if(Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out Hit)){
            distance = Hit.distance;
            if(Hit.transform.tag == "Player" && Hit.distance < 0.6f){
                closeToPlayer = true;
            }else{
                closeToPlayer = false;
            }
        }
    }
}
