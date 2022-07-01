using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gem : MonoBehaviour
{
    [SerializeField]
    private int gemNum;

    private void OnTriggerEnter2D(Collider2D other)
    {
        if(other.tag == "Player"){
            UIManager.Instance.GemCollected(gemNum);
            GameManager.Instance.GemCollected();
            Destroy(this.gameObject);
        }
    }
}
