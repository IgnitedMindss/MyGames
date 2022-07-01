using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class GlobalPlayerHealth : MonoBehaviour
{
    public static int playerHealth = 100;
    public GameObject healthDisplay;

    // Update is called once per frame
    void Update()
    {
        if(playerHealth <= 0){
            SceneManager.LoadScene(1);
        }
        healthDisplay.GetComponent<Text>().text = "" + playerHealth;
    }
}
