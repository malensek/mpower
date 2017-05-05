Power Monitoring with the mPower Smart Plug
============

1.) Plug in the mPower Mini
2.) Connect to the plug over WiFi
3.) Generally the next step is to set up the device to associate with a particular network. However, this step isn't necessary for our purposes and data can be collected directly from the device without setting it up.
4.) ssh to the plug at 192.168.2.20 with username and password 'ubnt':
  ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 ubnt@192.168.2.20
5.) Test to determine whether the outlet is switched on:
  cat /proc/power/relay1
  (returns 1 if on, 0 if off)
6.) If not, turn on the relay:
  echo 1 > /proc/power/relay1
