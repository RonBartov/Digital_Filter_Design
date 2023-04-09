# Digital Filter Design
## Project's Goal
The objective of this project is to provide an overview of the fundamentals of designing digital filters. In this document, I have included a comprehensive example of designing an IIR digital filter using a specific mapping method. This method has been selected from a range of two mapping techniques that will be explained throughout this document. In the MATLAB code, I implemented both methods.

## Filter in Signal Processing
In signal processing, a filter is a device or process that removes some unwanted components or features from a signal. Most often, this means removing some frequencies or frequency bands.

### Classifying Filters
There are many different ways of classifying filters. Filters may be: <br>
${\bullet}$ Non-linear or linear <br>
${\bullet}$ Time-variant or time-invariant <br>
${\bullet}$ Causal or non-causal: A filter is non-causal if its present output depends on future input. <br>
${\bullet}$ Analog or digital <br>
${\bullet}$ Discrete-time (sampled) or continuous-time <br>
${\bullet}$ Passive or active <br>
${\bullet}$ Infinite impulse response (IIR) or finite impulse response (FIR) 

### Linear Continuous-Time Filters
Linear continuous-time circuit is perhaps the most common meaning for filter in the signal processing world. Circuits that perform this function are generally linear in their response, or at least approximately so. Any nonlinearity would potentially result in the output signal containing frequency components not present in the input signal.

The modern design methodology for linear continuous-time filters is called **network synthesis**. Some important filter families designed in this way are Chebyshev filter, **Butterworth filter** (which has a maximally flat frequency response) and Bessel filter. <br>
The difference between these filter families is that they all use a different polynomial function to approximate to the ideal filter response. This results in each having a different transfer function.

## The Impulse Response
In signal processing and control theory, the impulse response function (IRF) ${h(t)}$ of a dynamic system is its output when presented with a brief input signal, called an impulse ${\delta(t)}$

## Infinite Impulse Response (IIR) Filters
It is a **recursive** filter in that the output from the filter is computed by using the current and previous inputs and previous outputs. In other words, its impulse response never go down to zero

### Mathemetical Representation and Transfer Function
<img src="https://user-images.githubusercontent.com/89732669/230771816-48a0ed95-5a5d-4bd3-92d6-e308c3adcbfe.png" width="400"> 

<img src="https://user-images.githubusercontent.com/89732669/230771920-841d127c-d1cf-4979-a2f6-4d6df84028a6.png" width="190">

## Finite Impulse Response (FIR) Filters
It is a filter whose impulse response is of finite duration, because it settles to zero in finite time

### Mathemetical Representation and Transfer Function
<img src="https://user-images.githubusercontent.com/89732669/230773104-937c5c6c-3d9d-42fe-bf10-c3ce818acae5.png" width="400"> 

<img src="https://user-images.githubusercontent.com/89732669/230773242-85ca1b31-6e7e-4956-b611-2bf627ee7ce7.png" width="140"> 


## Implementing IIR Digital Filter
### The Approach 
Using a mapping from an analog filter ${H_a(s)}$ to a digital filter ${H(z)}$ under the following restrictions: <br>
1) The behaviour of ${H(z)}$ on the unit circle will be similar to the behaviour of ${H_a(s)}$ on the imaginary axis <br>
2) To preserve causality and stability

### The Methods
**Impulse Invariance (I.I)** <br>
Can be described by this block diagram <br>
<img src="https://user-images.githubusercontent.com/89732669/230778451-884c2ebe-26c7-4ae6-a346-4258652a1b6c.png" width="350"> 

Uses the **poles** mapping <br>
<img src="https://user-images.githubusercontent.com/89732669/230778098-90240eeb-5486-4b1c-8c82-5d18edb91d1b.png" width="350"> 

This method is sensitive to aliasing! 

**Bilinear Transformation (B.T)** <br>
Uses the **planes** mapping <br>
<img src="https://user-images.githubusercontent.com/89732669/230779623-e3e67793-6d27-4374-b8d4-318a3613c0b4.png" width="350">

## Example on Butterworth Analog Filter
### Butterworth Analog Filter
**Transfer Function** <br>
<img src="https://user-images.githubusercontent.com/89732669/230782481-59fda943-c6a9-451c-a5ae-664d7db28262.png" width="150">

**Absolute Value** <br>
<img src="https://user-images.githubusercontent.com/89732669/230781580-af467713-1924-4a2a-8c50-be7220f2ffc3.png" width="150">

**S Plane Expression** <br>
<img src="https://user-images.githubusercontent.com/89732669/230781764-5b20d4c4-06ef-4f38-b77b-31c374c0c53d.png" width="150">

<img src="https://user-images.githubusercontent.com/89732669/230783428-39627cf1-44ac-4c91-a443-28e004d915e1.png" width="350">

### The Desired Digital Filter Specifications 
Defined by the set ${\omega_p , \omega_s , \delta_p , \delta_s}$ where ${\delta_p = 2\delta_1}$

<img src="https://user-images.githubusercontent.com/89732669/230780364-82c01370-e0df-43c0-90f9-b3c9cdb76758.png" width="350">

Let's chose the specs to be the following: <br> 
${\omega_p=0.25\pi , \omega_s=0.35\pi , \delta_p=0.1 , \delta_s=0.175}$ 

Because the filter is monotonic, satisfied condition will be: <br>
1) ${H(\omega_p)=\delta_p=0.9}$ <br>
2) ${H(\omega_s)=\delta_s=0.175}$

### Mapping to Analog Specifications
In the Impulse Invariance method we are sampling the analog impulse response, thus we can use the following relation: <br>
<img src="https://user-images.githubusercontent.com/89732669/230782885-1f7878ed-beb9-44a9-b576-098348a8cfb2.png" width="400">

Assuming ${T_s=1}$ we will get the equivalent relation in the analog domain: <br>
1) Analog specification: ${\Omega_p=0.25\pi , \Omega_s=0.35\pi , \delta_p=0.1 , \delta_s=0.175}$  <br>
2) Passband equation: ${H(\Omega_p)=\delta_p=0.9}$ <br>
3) Stopband equation: ${H(\Omega_s)=\delta_s=0.175}$

By solving the equations: <br>
1) Analog filter order ${N=8}$
2) Because the I.I method is sensitive to aliasing, we will find the analog cutoff frequency by substituting N into the passband equation. <br>
The analog cutoff frequency: ${\Omega_c=0.859}$ 

Then, we can find the S plane expression and finally map the analog filter to a digital filter by the Impulse Invariance mapping. <br>
**See the implementation in MATLAB code**
