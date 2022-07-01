using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DynamicTile : MonoBehaviour
{

    private Vector3 _currDestination;
    private bool _hasReached = false;
    public string _direction = "up";
    public int _totalMovementUnits = 10;

    // Start is called before the first frame update
    void Start()
    {
        _currDestination = transform.position;

        if(_direction == "up")
            _currDestination.y += _totalMovementUnits;
        else if(_direction == "down")
            _currDestination.y -= _totalMovementUnits;
        else if(_direction == "right")
            _currDestination.x += _totalMovementUnits;
        else if(_direction == "left")
            _currDestination.x -= _totalMovementUnits;
    }

    // Update is called once per frame
    void Update()
    {
        if(_direction == "up"){
            if(transform.position == _currDestination && !_hasReached){
                _currDestination.y -= _totalMovementUnits;
                _hasReached = true;
            }else if(transform.position == _currDestination && _hasReached){
                _currDestination.y += _totalMovementUnits;
                _hasReached = false;
            }
        }else if(_direction == "down"){
            if(transform.position == _currDestination && !_hasReached){
                _currDestination.y += _totalMovementUnits;
                _hasReached = true;
            }else if(transform.position == _currDestination && _hasReached){
                _currDestination.y -= _totalMovementUnits;
                _hasReached = false;
            }
        }else if(_direction == "right"){
            if(transform.position == _currDestination && !_hasReached){
                _currDestination.x -= _totalMovementUnits;
                _hasReached = true;
            }else if(transform.position == _currDestination && _hasReached){
                _currDestination.x += _totalMovementUnits;
                _hasReached = false;
            }
        }else if(_direction == "left"){
            if(transform.position == _currDestination && !_hasReached){
                _currDestination.x += _totalMovementUnits;
                _hasReached = true;
            }else if(transform.position == _currDestination && _hasReached){
                _currDestination.x -= _totalMovementUnits;
                _hasReached = false;
            }
        }
        

        transform.position = Vector3.MoveTowards(transform.position, _currDestination, 3 * Time.deltaTime);
    }
}
