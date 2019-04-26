# SolarGest_Modelling: simulation of solar cell photocurrent signals under different hand gestures   
We have developed MATLAB code to simulate output photocurrent signal from a solar cell under different hand gestures performed near it. For a given hand gesture, the simulator generates time series of photocurrent values as a function of solar cell form factor and efficiency, hand size, proximity between solar cell and hand, speed and direction of the hand gesture, intensity of the background light source, and many other parameters that affect solar photocurrent. The simulated photocurrent time series acts as the response of the solar cell to a given gesture and hence can be used to study and design algorithms for detecting gestures from solar cell photocurrent without any access to real solar cells. Our Mobicom 2019 paper, SolarGest: Ubiquitous and Battery-free Gesture Recognition using Solar Cells, studied such algorithms using this simulator and validated the simulator with different types of actual solar cells, including the emerging transparent solar cells. You are therefore requested to cite the [paper](https://arxiv.org/abs/1812.01766) if any of the material is used in your research.
```
@inproceedings{ma2019solargest,
  title={SolarGest: Ubiquitous and Battery-free Gesture Recognition using Solar Cells},
  author={Ma, Dong and Lan, Guohao and Hassan, Mahbub and Upama, Mushfika B and Uddin, Ashraf and Youssef, Moustafa},
  booktitle={Proceedings of the 25th Annual International Conference on Mobile Computing and Networking},
  year={2019 (to appear)},
  organization={ACM }
}

```


# Software Requirements
MATLAB 2016b or later.

# Files
The files are briefly described as follows and it is recommended that readers should refer to Figure 2 in the [paper](https://arxiv.org/abs/1812.01766) to gain a better understanding of the geometric analysis.

**gest_creation_hori.m** and **gest_creation_vert.m**: given geometric and gesture parameters, the two files create time series hand positions for horizontal and vertical gestures, respectively. It supports four horizontal gestures (Left, Right, LeftRight, RightLeft) and four vertical gestures (Down, Up, DownUp, UpDown).

**current_calculation_hori.m** and **current_calculation_vert.m**: given time series hand positions and environmental parameters, the two files generate photocurrent signals for horizontal and vertical gestures, respectively.

**simulator.m**: this file goes through the procedures of setting parameters, creating gestures, as well as generating the final photocurrent signals. In addition, it provides some examples to investigate the impact of different parameters on the photocurrent signal.

**utility_recognition_accuracy_estimation.m**: this file demonstrates the utility of the simulator in terms of gesture recognition accuracy estimation. It first generates a set of photocurrent signals for five different gestures under various parameter settings, and applies a signal processing pipeline on the signals, and then employs KNN for gesture classification. Readers may develop their own applications or methodology for gesture recognition.




