using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundCollisionCheck : MonoBehaviour
{
    private Player player; 

    void Start(){
        player = gameObject.GetComponentInParent<Player>();
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.tag == "Ground" || other.tag == "Enemy")
            player.GroundTouch(true);
    }

    private void OnTriggerExit2D(Collider2D other)
    {
        if(other.tag == "Ground" || other.tag == "Enemy")
            player.GroundTouch(false);
    }
}
