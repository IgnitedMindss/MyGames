using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Acid : MonoBehaviour, IDamagable
{

    private Player player;
    private Vector3 direction;
    private Animator anim;

    public int Health{get; set;}
    // Start is called before the first frame update
    void Start()
    {
        Health = 1;
        anim = GetComponent<Animator>();
        player = GameObject.FindGameObjectWithTag("Player").GetComponent<Player>();
        if(player != null){
            direction = player.transform.localPosition - transform.localPosition;
        }
        Invoke("Explode", 3);
    }

    // Update is called once per frame
    void Update()
    {
        if(direction != null){
            if(direction.x > 0){
                transform.Translate(Vector3.right * 3 * Time.deltaTime);
            }else if(direction.x < 0){
                transform.Translate(Vector3.left * 3 * Time.deltaTime);
            }
        }
    }

    void Explode(){
        anim.SetTrigger("Explode");
    }

    void DestroyAcid(){
        Destroy(this.gameObject);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.tag == "Player"){
            IDamagable hit = other.GetComponent<IDamagable>();
            if(hit != null){
                hit.Damage();
                Explode();
            }
        }
    }

    public void Damage(){
        Debug.Log("Damage() to Acid");
        Health--;

        if(Health < 1){
            Destroy(this.gameObject);
        }
    }
}
