using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemyDeath : MonoBehaviour
{
    public int enemyHealth = 20;
    public bool enemyDeath = false;

    void DamageEnemy(int damageAmount){
        enemyHealth -= damageAmount;
    }

    // Update is called once per frame
    void Update()
    {
        if(enemyHealth <= 0 && !enemyDeath){
            enemyDeath = true;
            this.GetComponent<Animator>().Play("death");
            this.GetComponent<ZombieAI>().enabled = false;
            this.GetComponent<BoxCollider>().enabled = false;
        }
    }
}
