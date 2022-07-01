using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ColorEnemy : Enemy, IDamagable
{
    // Start is called before the first frame update

    // Update is called once per frame
    private bool canFire = true;
    public int Health {get; set;}
    private int maxHealth;

    public override void Start(){
        base.Start();
        Health = base.health;
        maxHealth = base.health;
    }

    public override void Update()
    {
        base.Update();

        if(turnRight)
            rigid.velocity = new Vector2(speed, rigid.velocity.y);
        else
            rigid.velocity = new Vector2(-speed, rigid.velocity.y);
        if(enemyDetectPlayer){
            if(enemyColor == "yellow" && canFire){
                canFire = false;
                StartCoroutine(yellowFire());
                GameObject obj1 = Instantiate(enemyFirePrefab, transform.position + new Vector3(1f, 0f, 0f), Quaternion.identity) as GameObject;
                obj1.GetComponent<Fire>().speed = 5;
                obj1.GetComponent<Fire>().SetDirection("right");
                obj1.GetComponent<Fire>().ChangeSprite(0);

                GameObject obj2 = Instantiate(enemyFirePrefab, transform.position + new Vector3(-1f, 0f, 0f), Quaternion.identity) as GameObject;
                obj2.GetComponent<Fire>().speed = 5;
                obj2.GetComponent<Fire>().SetDirection("left");
                obj2.GetComponent<Fire>().ChangeSprite(0);
            }else if(enemyColor == "blue" && canFire){
                canFire = false;
                Vector3 v3 = (turnRight == true)?new Vector3(0.5f, 0f, 0f):new Vector3(-0.5f, 0f, 0f);
                string direc = (turnRight == true)?"right":"left";
                StartCoroutine(yellowFire());
                GameObject obj1 = Instantiate(enemyFirePrefab, transform.position + v3, Quaternion.identity) as GameObject;
                obj1.GetComponent<Fire>().speed = 5;
                obj1.GetComponent<Fire>().SetDirection(direc);
                obj1.GetComponent<Fire>().ChangeSprite(2);
            }else if(enemyColor == "red" && canFire){
                canFire = false;
                StartCoroutine(yellowFire());
                GameObject obj1 = Instantiate(enemyFirePrefab, transform.position + new Vector3(1f, 0f, 0f), Quaternion.identity) as GameObject;
                obj1.GetComponent<Fire>().speed = 5;
                obj1.GetComponent<Fire>().SetDirection("right");
                obj1.GetComponent<Fire>().ChangeSprite(3);

                GameObject obj2 = Instantiate(enemyFirePrefab, transform.position + new Vector3(-1f, 0f, 0f), Quaternion.identity) as GameObject;
                obj2.GetComponent<Fire>().speed = 5;
                obj2.GetComponent<Fire>().SetDirection("left");
                obj2.GetComponent<Fire>().ChangeSprite(3);

                GameObject obj3 = Instantiate(enemyFirePrefab, transform.position + new Vector3(0f, 1f, 0f), Quaternion.identity) as GameObject;
                obj3.GetComponent<Fire>().speed = 5;
                obj3.GetComponent<Fire>().SetDirection("left");
                obj3.GetComponent<Fire>().RotateFire();
                obj3.GetComponent<Fire>().ChangeSprite(3);
            }else if(enemyColor == "green" && canFire){
                canFire = false;
                Vector3 v3 = (turnRight == true)?new Vector3(0.5f, 0f, 0f):new Vector3(-0.5f, 0f, 0f);
                string direc = (turnRight == true)?"right":"left";
                StartCoroutine(yellowFire());
                GameObject obj1 = Instantiate(enemyFirePrefab, transform.position + v3, Quaternion.identity) as GameObject;
                obj1.GetComponent<Fire>().speed = 5;
                obj1.GetComponent<Fire>().SetDirection(direc);
                obj1.GetComponent<Fire>().ChangeSprite(1);
            }
        }
    }

    public void Damage(int colorNum){
        if(Colors[colorNum] != enemyColor) return;
        Health--;

        healthBar.transform.localScale = new Vector3(GetHealthPercent(), 1f, 1f);

        if(Health < 1) Destroy(this.gameObject);

    }

    private float GetHealthPercent(){
        return ((float)Health/maxHealth) * 15f;
    }

    IEnumerator yellowFire(){
        float timer = 1f;
        if(enemyColor == "yellow")
            timer = 1f;
        else if(enemyColor == "blue")
            timer = 1.5f;
        else if(enemyColor == "red")
            timer = 1.8f;
        else if(enemyColor == "green")
            timer = 0.9f;

        yield return new WaitForSeconds(timer);
        canFire = true;
    }
}
