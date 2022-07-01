using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pistol1911Fire : MonoBehaviour
{
    public GameObject theGun;
    public GameObject muzzleFlash;
    public AudioSource gunFire;
    public AudioSource emptyClip;
    private bool isFiring = false;

    //Enemy will deal damage
    public float targetDistance;
    private int damageAmount = 5;

    // Update is called once per frame
    void Update()
    {
        if(Input.GetButtonDown("Fire1")){
            if(GlobalAmmo.handGunAmmo > 0){
                if(isFiring == false){
                    StartCoroutine(HandGunFire());
                }
            }else{
                if(isFiring == false){
                    StartCoroutine(HandgunEmpty());
                }
            }
        }
    }

    IEnumerator HandGunFire(){
        isFiring = true;
        theGun.GetComponent<Animator>().Play("pistol_1911_shoot");
        muzzleFlash.SetActive(true);
        GlobalAmmo.handGunAmmo -= 1;

        RaycastHit Shot;
        if(Physics.Raycast(transform.position, transform.TransformDirection(Vector3.forward), out Shot)){
            targetDistance = Shot.distance;
            Shot.transform.SendMessage("DamageEnemy", damageAmount, SendMessageOptions.DontRequireReceiver);
        }

        gunFire.Play();
        yield return new WaitForSeconds(0.05f);
        muzzleFlash.SetActive(false);
        yield return new WaitForSeconds(0.2f);
        theGun.GetComponent<Animator>().Play("pistol_1911_idle");
        isFiring = false;
    }

    IEnumerator HandgunEmpty(){
        isFiring = true;
        emptyClip.Play();
        yield return new WaitForSeconds(0.2f);
        isFiring = false;
    }
}
