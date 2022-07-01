using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyReachedMe : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other) {
        if(other.gameObject.tag == "Zombie"){
            other.GetComponent<ZombieAI>().hasReachedPlayer = true;
        }
    }

    private void OnTriggerExit(Collider other) {
        if(other.gameObject.tag == "Zombie"){
            other.GetComponent<ZombieAI>().hasReachedPlayer = false;
        }
    }
}
