using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ZombieAI : MonoBehaviour
{
    public float xPos;
    public float zPos;
    public GameObject theDest;
    public GameObject thePlayer;
    public int posNum = 1;
    public float moveSpeed = 0.02f;
    private bool isWait = false;

    public bool allowWalk;
    public bool hasSpotted;
    public bool readyToAttack;
    public bool hasReachedPlayer;
    public bool canRun;
    public bool canAttack;

    // Player hurt
    public int hurtType;
    public AudioSource[] Hurt;
    public AudioSource Scream;
    public GameObject hurtScreen;

    // Zombie Sounds
    public int growlType;
    public AudioSource[] Growl;
    public bool isGrowling;
    public bool canScream;
    public bool canScream2;
    void Start()
    {
        canScream = false;
        canScream2 = false;
        isGrowling = false;
        canAttack = false;
        canRun = true;
        hasReachedPlayer = false;
        hasSpotted = false;
        allowWalk = true;
        readyToAttack = false;
        xPos = theDest.transform.position.x;
        zPos = theDest.transform.position.z;
        theDest.transform.position = new Vector3(xPos, theDest.transform.position.y, zPos);
        posNum += 1;

    }

    // Update is called once per frame
    void Update()
    {

        if(hasSpotted){
            moveSpeed = 0.09f;
            if(readyToAttack){
                if(hasReachedPlayer){
                    canRun = false;
                    this.GetComponent<Animator>().Play("attack"); 
                        if(!canAttack){
                            StartCoroutine(AttackAnimFinished());
                        }   
                }else{
                    if(!canRun){
                        StartCoroutine(AllowRunning());
                    }
                    if(canRun){
                        this.GetComponent<Animator>().Play("run");
                        transform.position = Vector3.MoveTowards(transform.position, thePlayer.transform.position, moveSpeed);
                    }
                }
            }else{
                this.GetComponent<Animator>().Play("scream");
                StartCoroutine(ReadyForAttack());
            }

            if(canScream && !canScream2){
                StartCoroutine(ZombieGrowlManager());
             }

            if(!(thePlayer.transform.position.y > 1.5)){
                transform.LookAt(thePlayer.transform);
            }
        }else{
            if(!isGrowling){
                StartCoroutine(ZombieGrowlManager());
            }

            if(allowWalk){
                this.GetComponent<Animator>().Play("walk");
                transform.LookAt(theDest.transform);
                transform.position = Vector3.MoveTowards(transform.position, theDest.transform.position, moveSpeed);
                if(isWait){
                    StartCoroutine(Wait());
                }else{
                    StartCoroutine(Move());
                }
            }else{
                this.GetComponent<Animator>().Play("idle");
                StartCoroutine(allowWalking());
            }
        }
    }

    IEnumerator Move(){
        moveSpeed = 0.01f;
        yield return new WaitForSeconds(1);
        isWait = true;
    }
    IEnumerator Wait(){
        moveSpeed = 0;
        yield return new WaitForSeconds(1);
        isWait = false;
    }

    IEnumerator allowWalking(){
        yield return new WaitForSeconds(5);
        allowWalk = true;
    }

    IEnumerator ReadyForAttack(){
        canScream = true;
        yield return new WaitForSeconds(3);
        canScream = false;
        canScream2 = false;
        readyToAttack = true;
    }

    IEnumerator AllowRunning(){
        yield return new WaitForSeconds(1.5f);
        canRun = true;
    }

    IEnumerator AttackAnimFinished(){
        canAttack = true;
        yield return new WaitForSeconds(0.8833f);
        if(gameObject.GetComponentInChildren<EnemyCasting>().closeToPlayer){  
            GlobalPlayerHealth.playerHealth -= 5;  
            hurtType = Random.Range(0,4);
            Hurt[hurtType].Play();
            hurtScreen.GetComponent<Animator>().Play("hurtScreenAnim");
        }
        yield return new WaitForSeconds(2.5f);
        canAttack = false;
    }

    IEnumerator ZombieGrowlManager(){
        if(canScream){
            canScream2 = true;
            Scream.Play();
        }
        else{
            isGrowling = true;
            growlType = Random.Range(0,4);
            Growl[growlType].Play();
            yield return new WaitForSeconds(4);
            isGrowling = false;
        }
    }
}
