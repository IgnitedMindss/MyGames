using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    // Start is called before the first frame update
    public Transform[] _ledgePlatformPos;
    public string[] _ledgeDirections;
    public int[] _totalmovUnits;
    public GameObject _platformPrefab;

    void Start()
    {
        Screen.orientation = ScreenOrientation.LandscapeLeft;

        for(int i=0; i<_ledgePlatformPos.Length; i++){
            GameObject platform = Instantiate(_platformPrefab, _ledgePlatformPos[i].position, Quaternion.identity) as GameObject;
            platform.GetComponent<DynamicTile>()._direction = _ledgeDirections[i];
            platform.GetComponent<DynamicTile>()._totalMovementUnits = _totalmovUnits[i];
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
