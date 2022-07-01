using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAnim : MonoBehaviour
{
    private Animator _anim;

    void Start(){
        _anim = GetComponentInChildren<Animator>();
    }

    public void Move(float move){
        _anim.SetFloat("Move", Mathf.Abs(move));
    }

    public void Jump(bool jumping){
        _anim.SetBool("Jump", jumping);
    }

    public void Attack(){
        _anim.SetTrigger("Attack");
    }

    public void Attack2(){
        _anim.SetTrigger("Attack2");
    }
}
