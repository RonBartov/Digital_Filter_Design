# Digital Filter Design
## Project's Goal
The objective of this project is to provide an overview of the fundamentals of designing digital filters. Using MATLAB, I have included a comprehensive example of designing an IIR digital filter using a specific mapping method. This method has been selected from a range of mapping techniques that will be explained in detail throughout this document.

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
It is a **recursive** filter in that the output from the filter is computed by using the current and previous inputs and previous outputs

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
**Impulse Invariance** <br>
The full block diagram <br>
<img src="https://user-images.githubusercontent.com/89732669/230778451-884c2ebe-26c7-4ae6-a346-4258652a1b6c.png" width="350"> 

The **poles** mapping <br>
<img src="https://user-images.githubusercontent.com/89732669/230778098-90240eeb-5486-4b1c-8c82-5d18edb91d1b.png" width="350"> 

**Impulse Invariance** <br>
The **planes** mapping <br>
<img src="https://user-images.githubusercontent.com/89732669/230779623-e3e67793-6d27-4374-b8d4-318a3613c0b4.png" width="350">

## Example on Butterworth Analog Filter

