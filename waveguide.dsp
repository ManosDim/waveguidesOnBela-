import("stdfaust.lib");


period=ma.SR/(freq*2):si.smoo;
p0=period*p;
p1=period*(1-p);

interpDelay(maxDel,interp,del,t)=_<: de.fdelay4(maxDel,del0)*xfade,de.fdelay4(maxDel,del1)*(1-xfade):>_
with{
    switch=t:ba.impulsify:+~%(2);
    del0=del:ba.sAndH(1-switch);
    del1=del:ba.sAndH(switch);
    xfade=en.asr(interp,1,interp,switch);
}

;   //state machine

A= interpDelay(1024,0.01,p0,gate),interpDelay(1024,0.01,p0,gate),_;
//INSIDE= de.fdelay4(1024,p1),de.fdelay4(1024,p1),_;
B=interpDelay(1024,0.01,p1,gate),interpDelay(1024,0.01,p1,gate),_;
 
 
 model(x)=pm.endChain(
     pm.chain(
         pm.lTermination(*(-0.99):fi.lowpass(4,3050),pm.basicBlock): 
         A:pm.in(x):pm.out:B :
         pm.rTermination(pm.basicBlock,*(-0.99):fi.lowpass(4,1500))
         )
         )
        ;  //-0.99 sine inversion



gain1= pressure*5;
freq=hslider("[1]Frequency[BELA:ANALOG_0]", 440 ,60, 1500, 0.1);
p=hslider("[3]Position[BELA:ANALOG_2]",0.3,0,1,0.01);
pressure =hslider("[0]ON/OFF (Plucking)[BELA:ANALOG_1]",0,0,1,0.01);
gate = pressure > 0.01;
gain=hslider("[1]gain[BELA:ANALOG_3]",20,0, 20, 0.1);

process=gate:gain1*ba.impulsify:model*gain;
//for polyphony the trick is to have a linear interpolator p in the 1st delay line and a p-1 in the 2st delay line