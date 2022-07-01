using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SnowMonitor : MonoBehaviour {
    public static int OnSnow;
    public int InternalSnow;
    
    void Update(){
        InternalSnow = OnSnow;
    }
}
