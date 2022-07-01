using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LedgePlatformTrigger : MonoBehaviour
{

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.tag == "Player")
            other.transform.parent = this.transform.parent;
    }

    private void OnTriggerExit2D(Collider2D other)
    {
        if(other.tag == "Player")
            other.transform.parent = null;
    }
}
