# MSSR


<a href="https://zenodo.org/badge/latestdoi/410122347"><img src="https://zenodo.org/badge/410122347.svg" alt="DOI"></a>
<!---
A detailled description of the method can be found in : 
Esley Torres García , Raúl Cámara , Alejandro Linares et al. Nanoscopic resolution within a single imaging frame.

If this software has been usefull to your research, please consider citing
<img src="https://doi.org/10.1101/2021.10.17.464398" width="800">
-------------------
--->

<!---
This README.txt file should be accompanied by

* The plugin MSSR_2.0.0.jar in ijplugin folder

* A demonstration dataset
*test_image.tif*
This data set consists in a experimental laser lithography of doughnut-shaped structures combined in a single stack

* A copy of the licence
LICENSE.txt

* An R script: MSSR_2.0.0.R

* A Python script: MSSR_2.0.0.R

* A Matlab script in MSSR_2.0.0_matlab.rar

-------------------
--->

# System requirements

MSSR_2.0.0.jar will require a running installation of ImageJ.

Full instruction for the installation of ImageJ can be found at:
https://imagej.nih.gov/ij/download.html

Tested on windows 10x86, linux Ubuntu 20.04.4 LTS
The plugin requires ImageJ 1.48 or higher (tested for 1.48 to 1.53)
ImageJ version number can be found under: Help -> About ImageJ...

R functions were developped using R 4.1.1
Python functions were developped using python 3.10.4
Matlab functions were developped using 64bits Matlab R2021b

-------------------
# Minimum characteristics and estimated execution time

+ CPU: Intel(R) Core i5 Third generation

+ RAM: 4GB

+ Integrated graphics: Intel(R) HD Graphics 2500



With a data set of 32x32 and 100 images, Amplification value as 5, FWHM as 3 and Order as 1.

| Iterpolation | Seconds |
| :---: | :---: |
| Bicubic | 32 |
| Fourier | 42 |

With a data set of 64x64 and 100 images, Amplification value as 5, FWHM as 3 and Order as 1.

| Iterpolation | Seconds |
| :---: | :---: |
| Bicubic | 114 |
| Fourier | 165 |

-------------------
# Installation guide

Prior to MSSR installation, the latest version of FIJI must be running on your computer (https://fiji.sc/). Additionally, the CLIJ, CLIJ2 and CLIJx packages (https://clij.github.io/clij2-docs/installationInFiji) must be installed (Figure panel c).
Plugin installation of MSSR can occur in two alternative ways:
1. Through the installation option in FIJI (Plugins -> Install -> MSSR_X.X.X.jar) (Figure panel c).
2. By directly placing the MSSR_X.X.X.jar file in the specific FIJI plugins folder in your system (Figure panel b).


<img src="readme_resources/Installation.png" width="600">
* Estimated installation time 2 ~ 5mn (not including download time).

-------------------
# MSSR Plugin

Two options are available within the MSSR plugin (Figure panel a):

* MSSR Analysis - Encompasses the major processing steps for either 𝑠𝑓−𝑀𝑆𝑆𝑅𝑛or 𝑡−𝑀𝑆𝑆𝑅𝑛.

* Temporal Analysis - Allows the user to perform an additional temporal analysis by selecting a desired PTF for 𝑡−𝑀𝑆𝑆𝑅𝑛 processing.

In what follows the main parameters available for MSSR analysis computation will be explained, hence, description will be centered on the use of the MSSR Analysis tab of the MSSR plugin.

Three parameters are needed for MSSR analysis (Figure panel b.1):

* AMP – An upscaling factor for the resulting MSSR image size.

* FWHM – The number of pixels that cover the Full Width at Half Maximum of the Point Spread Function (PSF) of the imaging lens.

* Order – The number of MSSR iterations for the image resolution enhancement.

The plugin offers the option of computing 𝑠𝑓−𝑀𝑆𝑆𝑅𝑛, or both 𝑠𝑓−𝑀𝑆𝑆𝑅𝑛 and 𝑡−𝑀𝑆𝑆𝑅𝑛. The temporal analysis is enabled when selecting the option “MSSR Temporal analysis” (Figure panel b.3) where the user can choose one of five available PTFs: Mean, Variance (Var), Temporal Product Mean (TPM), Coefficient Variation, Auto-cumulant Function of order 2-4 (SOFI 2-4).

Additional features:

* Computation of FWHM – provides an estimation of the imaging system’s Rayleigh criterion based on known optical parameters (Figure panel c).

* Interpolation type – allows you to select between two types of interpolation to magnify the image. The default option for this parameter is ‘Bicubic’.

* Minimize Meshing – Enable the mesh minimization algorithm which minimizes a ‘mesh’ pattern that commonly appears during the analysis as result of using a bicubic interpolation algorithm for digital upscaling (Figure panel b.2). The default option for this parameter is active.

* GPU Computing – Enables GPU usage for computing for MSSR processing (Figure panel b.2).

* Intensity Normalization – Allow a pixel-wise multiplication with the MSSR image (scaled from 0 to 1 in pixel values) with the magnified original image (Figure panel b.2).

* Selecting Image– Select a desired image or image stack for MSSR processing from the images which are already loaded in FIJI/ImageJ (Figure panel b.3).

* Batch Analysis – Allow to automatically analyze all the images within a selected folder in the user’s computer (Figure panel b.3).

<img src="readme_resources/MSSR_Plugin.png" width="600">

-------------------
# Instructions for use

1. Open ImageJ

2. Open the dataset *test_image.tif*.

3. Go to Plugins -> MSSR -> MSSR Analysis
A window will open.

4. Define the parameters, and additional features.

5. Click on "OK" button.

6. After a few seconds (depending on the specifications of your computer, the defined parameters and the data to be analyzed it might take longer), one or two images will appear (two if a temporal analysis is selected).

<img src="readme_resources/Usage.png" width="800">

-------------------
# Demo

Open the image of interest in ImageJ and make sure it is the active window.

The plugin supports multidimensional stacks of any bit depth (The resulting images will be 32-bit).

Define the three main parameters. Select additional features at your convenience.
Selection a temporal analysis will generate two images, one for the processed stack and other por the temporal stack projection.


