using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZombieTrack : MonoBehaviour
{
    public float xPos;
    public float zPos;

    void Start(){
        xPos = transform.position.x;
        zPos = transform.position.z;
    }
     void Update() {
        //transform.position = new Vector3(xPos, transform.position.y, zPos);
    }
    private void OnTriggerEnter(Collider other) {
        if(other.gameObject.tag == "Zombie"){
            other.GetComponent<ZombieAI>().allowWalk = false;
            this.GetComponent<BoxCollider>().enabled = false;
            
                if(Random.Range(1,3) == 1){
                    xPos = Random.Range(transform.position.x + 5, transform.position.x + 10);
                }else{
                    xPos = Random.Range(transform.position.x - 5, transform.position.x - 10);
                }

                if(Random.Range(1,3) == 1){
                    zPos = Random.Range(transform.position.z + 5, transform.position.z + 10);
                }else{
                    zPos = Random.Range(transform.position.z - 5, transform.position.z - 10);
                };
            transform.position = new Vector3(xPos, transform.position.y, zPos);
            this.GetComponent<BoxCollider>().enabled = true;
        }
    }
    
}
