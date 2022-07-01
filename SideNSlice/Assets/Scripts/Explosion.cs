using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Explosion : MonoBehaviour
{
    // Start is called before the first frame update
    ParticleSystem.MainModule main;
    private string[] Colors = {"yellow", "green", "blue", "red"};
    private string currColor;
    void Start()
    {
        main = GetComponentInChildren<ParticleSystem>().main;
        Destroy(this.gameObject, 1f);
    }

    private void Update()
    {
        switch(currColor)
        {
            case "yellow":
                main.startColor = Color.yellow;
                break;

            case "green":
                main.startColor = Color.green;
                break;

            case "blue":
                main.startColor = Color.blue;
                break;

            case "red":
                main.startColor = Color.red;
                break;
        }
    }

    public void changeColor(int idx){
        currColor = Colors[idx];
    }
}
