using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Ammo_1911_pickup : MonoBehaviour
{
    // Start is called before the first frame update

    public GameObject fakeAmmoClip;
    public AudioSource ammoClipPickup;
    public GameObject pickUpDisplay;
    private void OnTriggerEnter(Collider other) {
        fakeAmmoClip.SetActive(false);
        ammoClipPickup.Play();
        GlobalAmmo.handGunAmmo += 10;
        pickUpDisplay.SetActive(false);
        pickUpDisplay.GetComponent<Text>().text = "colt 1911 ammo +10";
        pickUpDisplay.SetActive(true);
    }
}
