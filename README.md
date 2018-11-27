# Hot-cold plate Subduction transition marked by the rise of alkali magmatism ~2.1 billion years ago
MATLAB codes and dataset

# Overview
This repository contains several datasets and MATLAB codes used for the study on the transition from hot to cold subduction. 
Statistical analysis was applied to a large geochemical dataset of mafic rocks spanning the last 3.5 Ga. From this investigation a rapidly increasing magnitude of alkali basalt magmatism was revealed during the 2.1-1.8 Ga interval. We thus conclude that the modern-style cold subduction commenced at ~2.1 Ga.
We compiled 3 codes to generate the diagrams in Fig. 1-Fig. 4. Here is the list of code files.

Mean_AA_vs_BB.m - Calculating the mean and standard errors of elements with SiO2 from 45 to 52 wt% through Bootstrap resampling method. The interval is set at 1 wt%. This program is designated for the Nb-SiO2, TiO2-SiO2 and P2O5-SiO2 differentiation trend in Fig 1 and Fig 2. 

Mean_AA_vs_SiO2.m – Calculating the mean and standard errors of elements with SiO2 from 45 to 52 wt% through Bootstrap resampling method. The interval is set at 1 wt%. This program can generate the differentiation trends of elements vs SiO2 for the Phanerozoic, Proterozoic and Archean igneous rocks simultaneously. 

Diff_error.m – Calculating the Diff (Nb), Diff (Ti) and Diff (P) through time for Fig. 4A in the paper. 

# System Requirements
The codes used in this paper were compiled on the MATLAB (version R2014a). The operating system is Windows 7. The Mac system on an Apple computer with the MATLAB installed appropriately may also work. To run the program, the codes should be opened by the MATLAB (R2014a or higher version) and run by pressing the F5 on the keyboard. The datasets (in the form of Microsoft Excel spreadsheet) should be stored in the same directory as the codes. 
The codes were designated for this study and do not have a version number. 
There is no non-standard hardware required. We recommend a computer with the following specs:

RAM: 8+ GB  
CPU: 4+ cores, 1.8+ GHz/core

# Installation Guide
This paper only involves several MATLAB codes rather than a software. The codes require the MATLAB platform (R2014a or higher version) installed on the PC or Mac computer. 
The install time of a MATLAB (R2014a) platform is commonly estimated as 30-45 minutes depending on the configurations of the computer. 

# Demo
We present 3 codes for the diagrams in Fig. 3, Fig. 4A and Fig. 4B in the paper, respectively. Here are the instructions to run the codes on data. We provide the real dataset for demo. Before implement the following demo, please open the code file using a MATLAB platform. 

Mean_AA_vs_BB.m
In this case, we take the example of the Nb-SiO2 differentiation trends of all the mafic rocks with 0-5 Ma ages from the East Asia. 
1. Choose the dataset “E_Asia.xlsx” by removing the “%” at the beginning of Line 5. In this spreadsheet, data from the column I to X will be read by the program. Nb is in the column X (column 16). 
2. Change the column number in Line 13 into Element=T(:,16) to choose Nb as the element to be calculated.
3. Choose a proper output csv file name in Line 84 for the result. 
4. Press the F5 on the keyboard to run the program. An error bar plot will be displayed for user’s reference. The run time will be less than 1 minute.

Mean_AA_vs_SiO2.m
In this case, we take the example of generating the Nb-SiO2 differentiation trends of mafic rocks for the Phanerozoic, Proterozoic and Archean.
1. Change the column number in Line 9 into Element=T(:,16) to choose Nb as the element to be calculated.
2. Choose a proper output csv file name in Line 188 for the result. 
3. Press the F5 on the keyboard to run the program. Three error bar plots of Nb vs SiO2 for the Phanerozoic, Proterozoic and Archean mafic rocks, respectively, will be displayed. The run time will be less than 2 minutes.

Diff.m
In this case, we calculate the Diff (Nb) through time as an example. 
1. Change the column number in Line 9 into Element=T(:,16) to choose Nb as the element to be calculated.
2. Choose a proper output csv file name in Line 146 for the result. 
3. Press the F5 on the keyboard to run the program. The error bar plot Diff (Nb) through time will be display. The csv file will include the mean and standard errors of Nb in low-silica and high-silica mafic rocks, respectively, as well as the Diff (Nb) and standard deviation from 3.0 to 0 Ga. The run time will be less than 2 minutes. 
 
# Instructions for use
## Steps to run the codes
A MATLAB code can be run by the following steps. Please also refer to the demo for examples.
1. Open the code files (*.m) using a MATLAB (R2014a or higher version) platform; 
2. Choose the filename of the dataset;
3. Change the column number to select the element to be calculated;
4. Change the output csv filename;
5. Press the F5 on the keyboard and the figures will be displayed. 

## Reproduction instructions
All the results for creating Fig. 1-Fig. 4 in this paper can be reproduced by run the corresponding MATLAB codes following the above steps. Further embellishment on those figures can be operated in other applications, e.g. Adobe Illustrator, CorelDRAW, etc. 
 
