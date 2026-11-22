# semismooth-newton-piecewise-linear

MATLAB code for the numerical experiments of

> J. G. Barrios, J. Y. Bello Cruz, O. P. Ferreira, S. Z. Németh. *A semi-smooth Newton method for a special piecewise linear system with application to positively constrained convex quadratic programming*. Journal of Computational and Applied Mathematics, 301, 91–100, 2016. [doi:10.1016/j.cam.2016.01.040](https://doi.org/10.1016/j.cam.2016.01.040)

## Contents

| File | Description |
|---|---|
| `MainProgram.m` | Main function. `MainProgram(dim, Lob, Upb)` produces Tables 1, 2 and 3 of the paper. |
| `ssNewtonQ.m` | Semi-smooth Newton method (22) of the paper. |
| `getProbQ.m` | Reads a stored test problem. |
| `setProbQ.m` | Writes a test problem. |
| `test.m` | Examples of calls used for the tables (commented). |

## How to run

In the MATLAB Command Window, run for example
```matlab
MainProgram(2000, 0, 0.5)
```

## Notes

- This is the code distributed with the paper, previously available on the author's web page.
- Some files use the Latin-1 (ISO-8859-1) encoding for accented letters in comments.

## Citation

If you use this code, please cite the paper above. The file `CITATION.cff` gives the citation data.

## License

MIT License, see `LICENSE`.

More code and papers: [Orizon P. Ferreira](https://orizonpereiraferreira.github.io).
