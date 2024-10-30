# MSSR Plugin Documentation

<a href="https://zenodo.org/badge/latestdoi/410122347"><img src="https://zenodo.org/badge/410122347.svg" alt="DOI"></a>

# Detailed Method Description: 

For an in-depth explanation of the MSSR method, refer to the article:

Torres-García, E., Pinto-Cámara, R., Linares, A. et al. Extending resolution within a single imaging frame. Nat Commun 13, 7452 (2022).
https://doi.org/10.1038/s41467-022-34693-9

If this software has been useful in your research, please consider citing the above publication.


# Accompanying Files

This README.txt file is provided alongside the following resources:

	•	MSSR_2.0.0.jar plugin in the ijplugin folder.
	•	A demonstration dataset: test_image.tif (a laser lithography dataset containing doughnut-shaped structures combined in a single stack).
	•	A copy of the license: LICENSE.txt.
	•	An R script: MSSR_2.0.0.R.
	•	A Python script: MSSR_2.0.0.py.
	•	A Matlab script package: MSSR_2.0.0_matlab.rar.


# System requirements

Plugin Requirements:
The MSSR_2.0.0.jar plugin requires an installation of ImageJ.
Full instruction for the installation of ImageJ can be found at:
https://imagej.nih.gov/ij/download.html

	•	Tested on: Windows 10x86, Linux Ubuntu 20.04.4 LTS.
	•	Compatible with ImageJ versions 1.48 or higher.

Script Requirements:

	•	R script compatibility: R 4.1.1.
	•	Python script compatibility: Python 3.10.4.
	•	Matlab script compatibility: Matlab R2021b (64-bit).


-------------------
# Minimum Hardware Specifications and Estimated Execution Time

Minimum Requirements:

	•	CPU: Intel(R) Core i5 (3rd generation)
	•	RAM: 4GB
	•	Graphics: Integrated Intel(R) HD Graphics 2500

Example Execution Times

For a dataset of 32x32 with 100 images (Amplification: 5, FWHM: 3, Order: 1):

| Iterpolation | Seconds |
| :---: | :---: |
| Bicubic | 32 |
| Fourier | 42 |

For a dataset of 64x64 with 100 images (Amplification: 5, FWHM: 3, Order: 1):

| Iterpolation | Seconds |
| :---: | :---: |
| Bicubic | 114 |
| Fourier | 165 |

-------------------
# Installation guide

To install the MSSR plugin, first ensure you have the latest version of FIJI installed (https://fiji.sc/). Additionally, the CLIJ, CLIJ2, and CLIJx packages must be installed, as explained in the CLIJ2 documentation (https://clij.github.io/clij2-docs/installationInFiji) (Figure panel c).


Plugin Installation Options:

1.	Through FIJI: Select Plugins -> Install -> MSSR_2.0.0.jar.
2.	Manual Installation: Place the MSSR_2.0.0.jar file in the FIJI plugins folder.

Estimated installation time is approximately 2-5 minutes, excluding download times.

<img src="readme_resources/Installation.png" width="600">

Figure 1. Installing MSSR plugin on FIJI/ImageJ.

-------------------
# MSSR Plugin Overview

The MSSR plugin provides two main analysis options:

* MSSR Analysis: Performs the primary processing for either sf-MSSRn or t-MSSRn.
* Temporal Analysis: Conducts temporal analysis for a selected Point Temporal Function (PTF) for t-MSSRn processing.

In what follows the main parameters available for MSSR analysis computation will be explained, hence, description will be centered on the use of the MSSR Analysis tab of the MSSR plugin.


MSSR Analysis Parameters (Figure panel b.1):

The following parameters must be defined for the analysis:

* AMP: Defines the upscaling factor for image size.
* FWHM: Sets the number of pixels covering the Full Width at Half Maximum (FWHM) of the imaging lens’s Point Spread Function (PSF).
* Order: Determines the number of MSSR iterations to enhance image resolution.

The plugin offers the option of computing 𝑠𝑓−𝑀𝑆𝑆𝑅𝑛, or both 𝑠𝑓−𝑀𝑆𝑆𝑅𝑛 and 𝑡−𝑀𝑆𝑆𝑅𝑛. The temporal analysis is enabled when selecting the option “MSSR Temporal analysis” (Figure panel b.3) where the user can choose one of five available PTFs: Mean, Variance (Var), Temporal Product Mean (TPM), Coefficient Variation, Auto-cumulant Function of order 2-4 (SOFI 2-4).

Additional Features:


* FWHM Computation: Provides an estimation of the Rayleigh criterion based on optical parameters (Figure panel c).
* Interpolation Type: Offers ‘Bicubic’ as the default option for image magnification.
* Mesh Minimization: Reduces mesh artifacts from bicubic interpolation (Figure panel b.2.
* GPU Computing: Enables GPU processing for enhanced performance (Figure panel b.2).
* Intensity Normalization: Allows pixel-wise scaling of MSSR images with the magnified original image (Figure panel b.2).
* Image Selection: Allows choosing an image or stack for analysis (Figure panel b.3).
* Batch Analysis: Enables automatic processing of all images in a selected folder (Figure panel b.3).


<img src="readme_resources/MSSR_Plugin.png" width="600">

Figure 2. MSSR usage and parameters

-------------------
# Usage instructions

1.	Open ImageJ.
2.	Load the dataset test_image.tif.
3.	Go to Plugins -> MSSR -> MSSR Analysis to open the analysis window.
4.	Define the desired parameters and enable any additional features.
5.	Click “OK” to start the analysis.

After processing, the output images will display in the interface. Temporal analysis will produce an additional image of the temporal stack projection if selected.

-------------------
# Demo

To demonstrate the plugin:

1.	Open the image of interest in ImageJ, ensuring it is the active window.
2.	Specify the analysis parameters as needed.
3.	If temporal analysis is selected, two images will be generated: the processed stack and the temporal stack projection.

The plugin supports multidimensional stacks of any bit depth, with output images saved in 32-bit format.

<img src="readme_resources/Usage.png" width="800">

Figure 3. A demo of MSSR processing.
