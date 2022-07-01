using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    private int gems = 0;
    private static GameManager _instance;
    public static GameManager Instance
    {
        get{
            if(_instance == null){
                Debug.LogError("GameManager is Null");
            }

            return _instance;
        }
    }

    private void Awake(){
        _instance = this;
    }

    public void ReloadGame(){
        SceneManager.LoadScene(0);
    }

    public void GemCollected(){
        gems++;
        if(gems > 3) UIManager.Instance.Victory();
    }

}
