# SolarGest_Modelling
In this project, we developed a simulator, which is able to simulate the output photocurrent from a solar cell under different hand gestures, using geometric analysis in MATLAB. The simulator mainly consists of three parts: (1) parameter settings: geometric parameters (e.g., size of solar cell/hand, proximity between solar cell and hand, etc.), environmental parameters (e.g., light intensity), and gesture parameters (e.g., speed, direction); (2) gesture creation: a time series of hand positions are simulated to form a gesture; (3) photocurrent generation: a time series of photocurrent values are generated where each value corresponds to a single hand position. This photocurrent then acts as the response of the solar cell to a given gesture. 

In addition, we provide an example of the utility of the simulator, i.e., estimating gesture recognition accuracy without field experiments, of which the effectiveness had been demonstrated in our [paper](https://arxiv.org/abs/1812.01766) to appear at Mobicom 2019. So, please consider citing the paper when any of the material is used in your research. 
```
@article{ma2018solargest,
  title={SolarGest: Ubiquitous and Battery-free Gesture Recognition using Solar Cells},
  author={Ma, Dong and Lan, Guohao and Hassan, Mahbub and Upama, Mushfika B and Uddin, Ashraf and Youssef, Moustafa},
  journal={arXiv preprint arXiv:1812.01766},
  year={2018}
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




