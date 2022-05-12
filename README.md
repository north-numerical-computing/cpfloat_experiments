# CPFloat: performance study and comparisons

This repository collects the C, C++, and MATLAB codes and scripts to reproduce the experiments in [[1]](#ref1). The whole suite can be run with
```console
make experiments
```
provided that all the relevant [Dependencies](#dependencies) mentioned below are available. Experiments that were present in previous drafts of the manuscript but are not included in the latest version can be run with the command
```console
make experiments_extra
```

# Dependencies

All experiments require that CPFloat be available. The [GitHub repository](https://github.com/north-numerical-computing/cpfloat) is cloned automatically, and the relevant portions of CPFloat are compiled when needed.

The C experiments require the [GNU MPFR library](https://www.mpfr.org) [[3]](#ref3) and the [FloatX library](https://github.com/oprecomp/FloatX) [[2]](#ref2).

The MATLAB experiments depend on the [chop function](https://github.com/higham/chop) [[4]](#ref4), on the [FLOATP_Toolbox](https://gerard-meurant.pagesperso-orange.fr/floatp.zip), and on the [Matlab/Octave toolbox for Reliable Computing (INTLAB)](https://www.tuhh.de/ti3/rump/intlab/) [[5]](#ref5).

# References

<a name="ref1">[1]</a> Massimiliano Fasi and Mantas Mikaitis. [CPFloat: A C library for emulating low-precision arithmetic](http://eprints.maths.manchester.ac.uk/2850). MIMS EPrint 2020.22, Manchester Institute for Mathematical Sciences, The University of Manchester, UK, October 2020. Revised April 2022.

<a name="ref2">[2]</a> Goran Flegar, Florian Scheidegger, Vedran Novaković, Giovani Mariani, Andrés E. Tomás, A. Cristiano I. Malossi, and
Enrique S. Quintana-Ortí. [FloatX: A C++ library for customized floating-point arithmetic](https://doi.org/10.1145/3368086), ACM Trans. Math. Software, 45(4), 1-23, 2019.

<a name="ref3">[3]</a>  Laurent Fousse, Guillaume Hanrot, Vincent Lefèvre, Patrick Pélissier, and Paul Zimmermann. 2007. [MPFR: A multiple-precision binary floating-point library with correct rounding](https://doi.org/10.1145/1236463.1236468), ACM Trans. Math. Software, 33(2), 13:1–13:15, 2007.

<a name="ref4">[4]</a> Nicholas J. Higham and Srikara Pranesh, [Simulating low precision floating-point arithmetic](https://doi.org/10.1137/19M1251308), SIAM J. Sci. Comput., 41, C585-C602, 2019.

<a name="ref5">[5]</a> Siegfried M. Rump. [INTLAB — INTerval LABoratory](https://doi.org/10.1007/978-94-017-1247-7_7). In *Developments in Reliable Computing*, Tibor Csendes editor, Springer-Verlag, Dordrecht, Netherlands, 77–104, 1999.


# Licensing information

The GNU MPFR Library is distributed under the terms of the [GNU Lesser General Public License (GNU Lesser GPL), Version 3](https://www.gnu.org/licenses/lgpl-3.0.html) or later ([Version 2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html) or later for MPFR versions until 2.4.x).

The FloatX Library is distributed under the terms of the [Apache License, Version 2.0](https://raw.githubusercontent.com/oprecomp/FloatX/master/LICENSE).

The MATLAB function `chop` is distributed under the terms of the [BSD 2-Clause "Simplified" License](https://raw.githubusercontent.com/higham/chop/master/license.txt).

The FLOATP Toolbox is distributed under an informal license and without any warranty.

The Matlab/Octave toolbox for Reliable Computing (INTLAB) is [proprietary software](https://www.tuhh.de/ti3/rump/intlab/).
