using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Player : MonoBehaviour, IDamagable
{

    public PlayerComponents playerComponents;

    [SerializeField]
    private Sprite[] playerSprites;

    [SerializeField]
    private int currSpriteIdx = 0;

    private Quaternion fromAngle, toAngle; 
    [SerializeField]
    private bool IsGroundCollision = false;

    private string playerDirection;

    public int Health {get; set;}

    void Start()
    {
        playerDirection = "right";
        playerComponents.rigid = GetComponent<Rigidbody2D>();
        playerComponents.speed = 6;
        playerComponents.jumpVelocity = 8;
        playerComponents.spriteRenderer = GetComponent<SpriteRenderer>();
        Health = 5;
    }

    // Update is called once per frame
    void Update()
    {
        Movement();

        if(IsGroundCollision) Jump();

        if(Input.GetKeyDown(KeyCode.R)) 
            Rotation();

        if(Input.GetKeyDown(KeyCode.F))
            Fire();
    }

    private void Jump(){
        if(Input.GetButtonDown("Jump")){
            playerComponents.rigid.velocity = Vector2.up * playerComponents.jumpVelocity;
        }

        if(playerComponents.rigid.velocity.y < 0){
            playerComponents.rigid.velocity += Vector2.up * Physics2D.gravity.y * (2.5f - 1) * Time.deltaTime;
        }else if(playerComponents.rigid.velocity.y > 0 && !Input.GetButton("Jump")){
            playerComponents.rigid.velocity += Vector2.up * Physics2D.gravity.y * (2f - 1) * Time.deltaTime;
        }
    }


    private void Rotation(){
        fromAngle = transform.rotation;
        toAngle = Quaternion.Euler( transform.eulerAngles + new Vector3(0, 0, -90f));

        transform.rotation = Quaternion.Lerp(fromAngle, toAngle, 1f);
        currSpriteIdx = (currSpriteIdx + 1 < 4)?currSpriteIdx + 1:0;

        playerComponents.spriteRenderer.sprite = playerSprites[currSpriteIdx];
    }

    private void Movement(){
        float horizontalInput = Input.GetAxisRaw("Horizontal");
        playerComponents.rigid.velocity = new Vector2(horizontalInput * playerComponents.speed, playerComponents.rigid.velocity.y);

        if(currSpriteIdx == 0 || currSpriteIdx == 2){
            if(horizontalInput > 0)
                {transform.localScale = new Vector3(0.4f, 0.4f, 0.4f);
                    playerDirection = "right";
                }

            if(horizontalInput < 0)
                {transform.localScale = new Vector3(-0.4f, 0.4f, 0.4f); playerDirection = "left";}
        }else{
            if(horizontalInput > 0)
                {transform.localScale = new Vector3(0.4f, 0.4f, 0.4f); playerDirection = "right";}

            if(horizontalInput < 0)
                {transform.localScale = new Vector3(0.4f, -0.4f, 0.4f); playerDirection = "left";}
        }
    }

    private void Fire(){
        Vector3 direc = (playerDirection == "right")?new Vector3(0.5f, 0f, 0f):new Vector3(-0.5f, 0f, 0f);
        GameObject obj = Instantiate(playerComponents.firePrefab, transform.position + direc, Quaternion.identity) as GameObject;
        obj.GetComponent<Fire>().SetDirection(playerDirection);
        obj.GetComponent<Fire>().ChangeSprite(currSpriteIdx);
        
    }

    public void GroundTouch(bool val){
        IsGroundCollision = val;
    }

    public void Damage(int colorNum){
        Health--;

        UIManager.Instance.UpdateLives(Health);

        if(Health < 1) Destroy(this.gameObject);
    }

    [System.Serializable]
    public struct PlayerComponents{
        public Rigidbody2D rigid;
        public int speed;
        [Range(1,10)]
        public float jumpVelocity;
        public SpriteRenderer spriteRenderer;
        public GameObject firePrefab;
    }
}

