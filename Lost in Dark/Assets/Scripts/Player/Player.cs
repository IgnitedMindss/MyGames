using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityStandardAssets.CrossPlatformInput;

public class Player : MonoBehaviour, IDamagable
{

    private Rigidbody2D _rigid;
    [SerializeField]
    private float _jumpForce = 8.0f;
    [SerializeField]
    private float _raycastLen = 1.6f;
    [SerializeField]
    private float _speed = 8.0f;
    [SerializeField]
    private bool _resetJump = false;
    private PlayerAnim _anim;

    private SpriteRenderer _sprite;
    private SpriteRenderer _playerSymbol;

    public int Health{get; set;}

    private int coins;
    // Start is called before the first frame update
    void Start()
    {
        _playerSymbol = transform.GetChild(1).GetComponent<SpriteRenderer>();
        _rigid = GetComponent<Rigidbody2D>();
        _anim = GetComponent<PlayerAnim>();
        _sprite = GetComponentInChildren<SpriteRenderer>();
        Health = 10;
    }

    // Update is called once per frame
    void Update()
    {

        Movement();
        
        IsGrounded();

        if(CrossPlatformInputManager.GetButtonDown("Attack_Button") && IsGrounded() == true){
            if(Random.Range(0,2) == 0){
                _anim.Attack();
            }else{
                _anim.Attack2();
            }
        }

        if(CrossPlatformInputManager.GetButtonDown("Map_Button")){   //Input.GetKeyDown(KeyCode.M)
            _playerSymbol.enabled = true;
            UIManager.Instance.ToggleMap();
        }
    }

    void Movement(){
        // float move = CrossPlatformInputManager.VirtualAxisReference("Horizontal").GetValueRaw; //Input.GetAxisRaw("Horizontal");
        float move = 0;
        if(CrossPlatformInputManager.GetButton("Left_Button"))
            move = -1;
        else if(CrossPlatformInputManager.GetButton("Right_Button"))
            move = 1;

        if (move > 0){
            // _sprite.flipX = false;
            transform.localScale = new Vector3(1f, 1f, 1f);
        }else if(move < 0)
        {
            // _sprite.flipX = true;
            transform.localScale = new Vector3(-1f, 1f, 1f);
        }

        if (CrossPlatformInputManager.GetButtonDown("Jump_Button") && IsGrounded() == true){
            _rigid.velocity = new Vector2(_rigid.velocity.x, _jumpForce);
            StartCoroutine(ResetJumpRoutine());
            _anim.Jump(true);
        }

        // float rigVelocityY = _rigid.velocity.y;

        // if(IsGrounded() == false){
        //     rigVelocityY -= 0.3f;
        // }
        _rigid.velocity = new Vector2(move * _speed, _rigid.velocity.y);
        _anim.Move(move);
    }

    bool IsGrounded(){
        RaycastHit2D hitInfo = Physics2D.Raycast(transform.position, Vector2.down, _raycastLen, 1 << 8);
        Debug.DrawRay(transform.position, Vector2.down * _raycastLen, Color.blue);

        if(hitInfo.collider != null){
            if(_resetJump == false){
                _anim.Jump(false);  
                return true;
            }
        }
        return false;
    }

    public void Damage(){
        Debug.Log("Damage() to Player");
        Health--;

        Hurt();

        if(Health < 1){
            UIManager.Instance.GameOverUI();
            Destroy(this.gameObject);
        }

        UIManager.Instance.UpdateLives(Health);
    }

    public void Hurt(){
        StartCoroutine(HurtRoutine());
    }

    public void AddCoins(int amount){
        coins += amount;
        UIManager.Instance.UpdateCoinCount(coins);
    }


    IEnumerator ResetJumpRoutine(){
        _resetJump = true;
        yield return new WaitForSeconds(0.2f);
        _resetJump = false;
    }

    IEnumerator HurtRoutine(){
        _sprite.color = Color.red;
        yield return new WaitForSeconds(0.35f);
        _sprite.color = Color.white;
    }
}
