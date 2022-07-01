using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy2AnimationEvent : Enemy
{
    // Start is called before the first frame update
    void BombExplode(){
        GameObject coin = Instantiate(coinsPrefab, transform.position, Quaternion.identity) as GameObject;
        coin.GetComponent<Coin>().coins = 1;
        Destroy(this.gameObject);
    }

    public override void Update(){

    }
}
