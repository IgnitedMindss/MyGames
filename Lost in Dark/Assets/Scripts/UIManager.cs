using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class UIManager : MonoBehaviour
{
    private static UIManager _instance;
    public Image[] healthHearts;
    public Text _coinsCount;
    public GameObject _map, _vic_over_obj;
    public Text _gameover_victory, _retry_playagain;

    public static UIManager Instance
    {
        get
        {
            if(_instance == null){
                Debug.Log("UIManager is Null");
            }
            return _instance;
        }
    }
    
    public void UpdateLives(int liveRemaining){
        for(int i=0; i<=liveRemaining; i++){
            if(i == liveRemaining){
                healthHearts[i].enabled = false;
            }
        }
    }

    public void UpdateCoinCount(int count){
        _coinsCount.text = "" + count;
    }

    public void ToggleMap(){
        _map.SetActive(!_map.activeSelf);
    }

    public void VictoryUI(){
        _gameover_victory.text = "Victory";
        _gameover_victory.color = Color.blue;
        _retry_playagain.text = "PlayAgain?";
        _vic_over_obj.SetActive(true);
    }

    public void GameOverUI(){
        _gameover_victory.text = "GameOver";
        _gameover_victory.color = Color.red;
        _retry_playagain.text = "Retry?";
        _vic_over_obj.SetActive(true);
    }

    public void LoadScene(){
        SceneManager.LoadScene(0);
    }

    private void Awake()
    {
        _instance = this;        
    }
}
