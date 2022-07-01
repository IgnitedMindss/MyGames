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
    protected bool turnRight = true;

    [SerializeField]
    protected string enemyColor;

    protected string[] Colors = {"yellow", "green", "blue", "red"};

    [SerializeField]
    protected bool enemyDetectPlayer;

    [SerializeField]
    protected GameObject healthBar;

    protected Rigidbody2D rigid;
    protected Player player;
    [SerializeField]
    protected GameObject enemyFirePrefab;
    // Start is called before the first frame update
    public virtual void Start()
    {
        rigid = GetComponent<Rigidbody2D>();
        player = GameObject.FindGameObjectWithTag("Player").GetComponent<Player>();
        enemyDetectPlayer = false;
        speed = 1;
    }

    // Update is called once per frame
    public virtual void Update(){
        if(player == null) return;
        float distance = Vector3.Distance(player.transform.localPosition, transform.localPosition);

        if(distance < 8f){
            enemyDetectPlayer = true;
        }else if(distance > 5f){
            enemyDetectPlayer = false;
        }
    }

    public virtual void changeTurn(){
        turnRight = !turnRight;

        if(turnRight) {transform.localScale = new Vector3(0.4f, 0.4f, 0.4f);}
        else {transform.localScale = new Vector3(-0.4f, 0.4f, 0.4f);}
    }
}
