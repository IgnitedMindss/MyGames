using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CheckPath : MonoBehaviour
{
    // Start is called before the first frame update
    private void OnTriggerExit2D(Collider2D other)
    {
        if(other.tag == "Ground"){
            GetComponentInParent<ColorEnemy>().changeTurn();
        }
    }
}
