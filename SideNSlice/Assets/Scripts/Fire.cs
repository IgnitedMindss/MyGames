using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Fire : MonoBehaviour
{
    public enum Direction{right,down,left,up};
    private Direction direction;

    [SerializeField]
    private Sprite[] fireSprites;

    [SerializeField]
    private GameObject explosionPrefab;

    [SerializeField]
    private SpriteRenderer spriteRenderer;

    private int currSpriteIdx = 0;

    public int speed = 10;

    private Quaternion fromAngle, toAngle;
    // Start is called before the first frame update

    void Start()
    {
        Destroy(this.gameObject, 5.0f);
    }

    // Update is called once per frame
    void Update()
    {
        switch(direction)
        {
            case Direction.left:
                transform.Translate(Vector3.left * speed * Time.deltaTime);
                break;

            case Direction.right:
                transform.Translate(Vector3.right * speed * Time.deltaTime);
                break;

            case Direction.up:
                transform.Translate(Vector3.up * speed * Time.deltaTime);
                break;

            case Direction.down:
                transform.Translate(Vector3.down * speed * Time.deltaTime);
                break;

        }
    }

    public void SetDirection(string dir){
        switch(dir)
        {
            case "left":
                direction = Direction.left;
                break;
            case "right":
                direction = Direction.right;
                break;
            case "up":
                direction = Direction.up;
                Debug.Log(direction);
                break;
            case "down":
                direction = Direction.down;
                break;
        }
    }

    public void ChangeSprite(int spriteIdx){
        currSpriteIdx = spriteIdx;
        spriteRenderer.sprite = fireSprites[currSpriteIdx];
    }

    public void RotateFire(){
        fromAngle = transform.rotation;
        toAngle = Quaternion.Euler( transform.eulerAngles + new Vector3(0, 0, -90f));
        transform.rotation = Quaternion.Lerp(fromAngle, toAngle, 1f);
    }

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.tag == "Ground"){
            GameObject obj = Instantiate(explosionPrefab, transform.position, Quaternion.identity);
            obj.GetComponent<Explosion>().changeColor(currSpriteIdx);
            Destroy(this.gameObject);
        }else if(other.tag == "Enemy" || (other.tag == "Player" && gameObject.tag == "EnemyFire")){
            GameObject obj = Instantiate(explosionPrefab, transform.position, Quaternion.identity);
            obj.GetComponent<Explosion>().changeColor(currSpriteIdx);
            Destroy(this.gameObject);
        }

        IDamagable hit = other.GetComponent<IDamagable>();
        if(hit != null) hit.Damage(currSpriteIdx);
    }
}
