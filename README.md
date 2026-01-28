# nordic-denoise-apptainer
Apptainer recipe and wrapper for running NORDIC denoising


## Build

```sh
apptainer build matlab-nordic.sif matlab-nordic.def
```

## Usage

```sh
apptainer run -B /path/to/your/data:/data matlab-nordic.sif /data/your_mag.nii.gz /data/your_phase.nii.gz
```