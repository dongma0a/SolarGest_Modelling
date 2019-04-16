# SolarGest_Modelling

This project consists of MATLAB codes that implement a solar cell based gesture recognition model using geometric analysis, where the results come from a [paper](https://arxiv.org/abs/1812.01766) to appear at Mobicom 2019. If you have any issues please check the [FAQ](https://github.com/dongma0a/SolarGest_Modelling/wiki) or [contact us](https://madongxx.wixsite.com/dongma).  

If you use the code, please cite our paper. \
@article{ma2018solargest,\
  title={SolarGest: Ubiquitous and Battery-free Gesture Recognition using Solar Cells},\
  author={Ma, Dong and Lan, Guohao and Hassan, Mahbub and Upama, Mushfika B and Uddin, Ashraf and Youssef, Moustafa},\
  journal={arXiv preprint arXiv:1812.01766},\
  year={2018}\
}

# Software Requirements
MATLAB 2016b or later.

# Files
There for four files that create gesture time series and current (solar cell output) time series for horizontal and vertical movements, respectively. To better understand the code, readers may need to refer to our paper. Also, we provide two examples which demonstrate the utility of the proposed model. *example_parameter_impact_investigation.m* allows reader to investigate the impact of different parameters on the simulated gesture signals, while *example_recognition_accuracy_estimation.m* is able to generate a set of gestures and estimate the gesture recognition accuracy after signal processing and classification. 

## example_parameter_impact_investigation.m 
Example of using the proposed model to investigate the impact of different parameters

### steps:
1. define and set parameters (detailed illustration of parameters please refer to Figure 2(b) in the paper).
2. discretize a gesture and generate times series of hand positions. Consider horizontal and vertical gestures individually.
3. calculate the solar cell output current when hand is at a certain position, and then form the gesture pattern. Consider horizontal    and vertical gestures individually.
4. vary the parameters and investigate their impacts.

## 2. example_recognition_accuracy_estimation.m 
Our model is able to simulate gestures under various conditions, this file gives an example of using the model to estimate gesture recognition performance without performing field experiments.

### steps:
1. simulate a set of gestures under various conditions.
2. perform signal processing, such as interpolation and zscore transformation.
3. perform feature extraction if nessesary, e.g., statistical feature and DWT coefficient.
4. perform calssification using KNN or other machine learning based classifers.


