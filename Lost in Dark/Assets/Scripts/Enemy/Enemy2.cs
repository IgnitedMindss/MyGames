using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy2 : Enemy, IDamagable
{
    
    public int Health {get; set;}

    public override void Init(){
        base.Init();
        Health = base.health;
    }

    public void Damage(){
        Debug.Log("Damage() to Enemy");
        Health--;

        Hurt();

        if(Health < 1){
            GameObject coin = Instantiate(coinsPrefab, transform.position, Quaternion.identity) as GameObject;
            coin.GetComponent<Coin>().coins = 1;
            Destroy(this.gameObject);
        }
    }

    public override void Update()
    {
        float distance;
        if(player != null)
            distance = Vector3.Distance(transform.position, player.transform.position);
        else
            distance = 10;

        if(distance < 1.5){
            if(anim == null)
                return;

            anim.SetBool("InCombat", true);

            // When in Attack or PreAttack state, enemy cannot flip
            if(anim.GetCurrentAnimatorStateInfo(0).IsName("Explosion")){
                return;
            }

            Vector3 direction = player.transform.localPosition - transform.localPosition;
            if(direction.x > 0 && anim.GetBool("InCombat") == true){
                transform.localScale = new Vector3(-1f, 1f, 1f);
            }else if(direction.x < 0 && anim.GetBool("InCombat") == true){
                transform.localScale = new Vector3(1f, 1f, 1f);
            }
        }else{
            if(anim == null)
                return;
                
            anim.SetBool("InCombat", false);
            // When in Attack or PreAttack state, enemy cannot move (Enemy cannot move while attacking)
            if(anim.GetCurrentAnimatorStateInfo(0).IsName("Explosion")){
                return;
            }
            Movement();
        }
    }
}
