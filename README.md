# nordic-denoise-apptainer
Apptainer recipe and wrapper for running automated NORDIC denoising.

For license compliance, the code for performing NORDIC denoising should be downloaded from the official NORDIC repository (https://github.com/SteenMoeller/NORDIC_Raw/tree/main)

## Build

```sh
apptainer build matlab-nordic.sif matlab-nordic.def
```

## Usage

Export your MATLAB license file number:
```sh
export MLM_LICENSE_FILE=<your license file number>
```

Run Apptainer image:
```sh
apptainer run -B /path/to/your/data:/data matlab-nordic.sif -m /data/your_mag.nii.gz -p /data/your_phase.nii.gz
```

Or run BASH wrapper script:
```sh
./nordic_denoise.sh -m <magnitude.nii> -p <phase.nii>
``` 
