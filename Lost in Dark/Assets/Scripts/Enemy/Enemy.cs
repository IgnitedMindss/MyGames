using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class Enemy : MonoBehaviour
{
    [SerializeField]
    protected int health;
    [SerializeField]
    protected int speed;
    [SerializeField]
    protected int coins;
    [SerializeField]
    protected Transform pointA, pointB;

    protected Player player;
    protected Animator anim;
    protected SpriteRenderer sprite;

    private Vector3 _currentTarget;

    public GameObject coinsPrefab;

    public virtual void Init(){
        anim = GetComponentInChildren<Animator>();
        sprite = GetComponentInChildren<SpriteRenderer>();
        player = GameObject.FindGameObjectWithTag("Player").GetComponent<Player>();
    }

    void Start(){
        Init();
    }

    public abstract void Update();

    public void Hurt(){
        StartCoroutine(HurtRoutine());
    }

    protected void Movement(){
        if(transform.position == pointA.position){
            _currentTarget = pointB.position;
            transform.localScale = new Vector3(1f, 1f, 1f);
        }else if(transform.position == pointB.position){
            _currentTarget = pointA.position;
            transform.localScale = new Vector3(-1f, 1f, 1f);
        }

        transform.position = Vector3.MoveTowards(transform.position, _currentTarget, speed * Time.deltaTime);
    }

    IEnumerator HurtRoutine(){
        sprite.color = Color.red;
        yield return new WaitForSeconds(0.35f);
        sprite.color = Color.white;
    }
}
