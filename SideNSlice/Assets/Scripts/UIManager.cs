using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    private static UIManager _instance;
    public Image[] healthBars;
    public Image[] gems;

    [SerializeField]
    private Text gameOverText, buttonText;

    [SerializeField]
    private Image button;

    public Sprite[] myButtons;

    [SerializeField]
    private GameObject gameOverScreen;

    public static UIManager Instance{
        get{
            if(_instance == null) Debug.Log("UIManager is null");
            return _instance;
        }
    }

    private void Awake()
    {
        _instance = this;
    }

    public void UpdateLives(int livesRemaining){
        if(livesRemaining < 1) gameOverScreen.SetActive(true);

        for(int i = 0; i <= livesRemaining; i++){
            if(i == livesRemaining) healthBars[i].enabled = false;
        }
    }

    public void ButtonPressed(){
        GameManager.Instance.ReloadGame();
    }

    public void Victory(){
        button.sprite = myButtons[1];
        gameOverText.text = "You Won! ;)";
        buttonText.text = "Again?\n";
        buttonText.color = Color.black;
        gameOverScreen.SetActive(true);
    }

    public void GemCollected(int idx){
        gems[idx].color = new Color(1f,1f,1f,1f);
    }
}
