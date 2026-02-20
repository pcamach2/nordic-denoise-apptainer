# nordic-denoise-apptainer
Apptainer recipe and wrapper for running automated NORDIC denoising.

For license compliance, the code for performing NORDIC denoising should be downloaded from the official NORDIC repository (https://github.com/SteenMoeller/NORDIC_Raw/tree/main)

## Build

```sh
apptainer build matlab-nordic.sif matlab-nordic.def
```

## Usage

```sh
apptainer run -B /path/to/your/data:/data matlab-nordic.sif /data/your_mag.nii.gz /data/your_phase.nii.gz
```
