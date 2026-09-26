# Generalized Representation-based Classification by Lp-norm for Face Recognition

MATLAB experiment scripts for generalized representation-based classification on four face datasets.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-D4AF37?style=flat-square)](LICENSE)

Copyright (C) 2023 Jing Wang

The GRC optimization problem
$$\mathop{\min}_{\alpha}||y-X\alpha||_s^s+\lambda||\alpha||_p^p.$$

Four experiments were conducted to compare GRC with LRC, CRC, and SRC on four benchmark face databases including the AR, FEI, FERET, and UMIST face databases.   
**Experiment 1:** Tune the parameters $s$ and $p$ for GRC when principal components that explain 98% of total variance are extracted.  
**Experiment 2:** Compare GRC with LRC, CRC, and SRC when principal components with different percentages (90%, 95%, 98%) of explained variance are extracted.   
**Experiment 3:** Tune the parameters $s$ and $p$ for GRC when different numbers of principal components (54, 120, 200, 300) are extracted.  
**Experiment 4:** Compare GRC with LRC, CRC, and SRC when different numbers of principal components (10:10:300) are extracted.  

## Prerequisites and Execution

The tracked [faces/](faces/) directory contains AR, FEI, FERET, and UMIST matrices, and [load_data.m](load_data.m) reads inputs from that directory.

This checkout has no `main.m`; use the documented script order. [exp_1_classify.m](exp_1_classify.m) uses `parfor` and [para_workers.m](para_workers.m), so configure Parallel Computing Toolbox and suitable worker counts.

## Quick Start
1. Run **load_data.m** to split the face databases into training and testing sets.
2. Run the following scripts sequentially:
   1) **exp_1_classify.m**
   2) **exp_1_analysis.m**
   3) **exp_2_classify.m**
   4) **exp_2_analysis.m**
   5) **exp_3_classify.m**
   6) **exp_3_analysis.m**
   7) **exp_4_classify.m**
   8) **exp_4_analysis.m**
3. More benchmark face databases are refered to: https://github.com/yuzhounh/Face-databases.

## Repository Structure

- [load_data.m](load_data.m): split preparation.
- `exp_1_*` through `exp_4_*`: ordered experiment/analysis pairs.
- `classifier_1.m` through `classifier_3.m`: experiment classifier helpers.
- [faces/](faces/): bundled inputs.

## License

See the existing [GPL-3.0 license](LICENSE).

## Contact
Jing Wang  
yuzhounh@163.com   
2023-11-23 10:19:28
