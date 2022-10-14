# SPDX-FileCopyrightText: 2020 Massimiliano Fasi and Mantas Mikaitis
# SPDX-License-Identifier: LGPL-2.1-or-later

ROOTDIR=$(shell pwd)
DEPSDIR=$(ROOTDIR)/deps/
CPFDIR=$(DEPSDIR)/cpfloat/
CPFDEPSDIR=$(CPFDIR)/deps/
CPFSRCDIR=$(CPFDIR)/src/
CPFBINDIR=$(CPFDIR)/bin/
BINDIR=$(ROOTDIR)/bin/
EXPDIR=$(ROOTDIR)/experiments/
DATDIR=$(ROOTDIR)/datfiles/

PCG_HEADER=$(CPFDEPSDIR)/pcg-c/include/pcg_variants.h

SHELL:=/bin/sh
CP:=cp
CURL:=curl
MKDIR:=mkdir
MV:=mv
PATCH:=patch
RM:=rm -f
UNZIP:=unzip

CC:=gcc
CXX:=g++

GIT:=git
MATLAB:=matlab -nodesktop -nosplash

WFLAGS=-Wall -Wextra -pedantic
ARCHFLAGS=-march=native
CFLAGS=$(WFLAGS) $(ARCHFLAGS) -std=gnu99 -I $(CPFSRCDIR) \
	-I /usr/local/include -L /usr/local/lib
CXXFLAGS=$(WFLAGS) $(ARCHFLAGS) -std=c++11
COPTIM=-O3
CLIBS=-lm -fopenmp
PCG_INCLUDE=-include $(PCG_HEADER)
PCG_LIB=-L $(CPFDEPSDIR)pcg-c/src -lpcg_random
PCG_FLAGS=$(PCG_INCLUDE) $(PCG_LIB)

.PRECIOUS: %.o





.PHONY: all
all: experiments





FLOATP_URL:=https://gerard-meurant.pagesperso-orange.fr/floatp.zip
$(DEPSDIR)floatp.zip:
	$(CURL) -o $(DEPSDIR)floatp.zip -O $(FLOATP_URL)

$(DEPSDIR)floatp: $(DEPSDIR)floatp.zip
	$(UNZIP) $(DEPSDIR)floatp.zip -d $(DEPSDIR)floatp
	$(PATCH) -p0 < $(DEPSDIR)floatp.patch;

init(%):
	$(GIT) submodule update --init deps/$%

.PHONY: libpcg
libpcg: init(cpfloat)
	cd $(CPFDIR); make libpcg

$(ROOTDIR)%:
	$(MKDIR) -p $@

.PHONY: autotune
autotune: init(cpfloat)
	cd $(CPFDIR); make autotune





.PHONY: experiments
experiments: run_exp_ccomp run_exp_overhead run_exp_matlab



# C experiments
$(BINDIR)exp_comp_cpfloat: $(EXPDIR)exp_comp_cpfloat.c libpcg $(BINDIR)
	$(CC) $(CFLAGS) $(COPTIM) -o $@ $< $(CLIBS) $(PCG_FLAGS) -I $(CPFSRCDIR)

$(BINDIR)exp_comp_mpfr: $(EXPDIR)exp_comp_mpfr.c $(BINDIR)
	$(CC) $(CFLAGS) $(COPTIM) -o $@ $< $(CLIBS) -lmpfr -I $(CPFSRCDIR)

$(BINDIR)exp_comp_floatx: $(EXPDIR)exp_comp_floatx.cpp init(FloatX) $(BINDIR)
	$(CXX) $(CXXFLAGS) $(COPTIM) -I $(DEPSDIR)/FloatX/src -o $@ $<

.PHONY: run_exp_ccomp
run_exp_ccomp: $(DATDIR) \
	$(BINDIR)exp_comp_cpfloat \
	$(BINDIR)exp_comp_mpfr \
	$(BINDIR)exp_comp_floatx
	$(BINDIR)exp_comp_cpfloat
	$(BINDIR)exp_comp_mpfr
	$(BINDIR)exp_comp_floatx
	$(MV) *.dat $(DATDIR)

$(BINDIR)exp_overhead: $(EXPDIR)exp_overhead.c libpcg $(BINDIR)
	$(CC) $(CFLAGS) $(COPTIM) -o $@ $< $(CLIBS) $(PCG_FLAGS)

run_exp_overhead: $(BINDIR)exp_overhead $(DATDIR)
	$<
	$(MV) *.dat $(DATDIR)



# MATLAB experiments
.PHONY: mexmat
mexmat: $(BINDIR)
	cd $(CPFDIR); make mexmat
	$(CP) $(CPFBINDIR)cpfloat.m $(CPFBINDIR)cpfloat.mex* $(BINDIR)

.PHONY: run_exp_matlab
run_exp_matlab: EXPSTRING="addpath('$(BINDIR)'); \
		addpath('$(DEPSDIR)chop'); \
		addpath(genpath('$(DEPSDIR)floatp/')); \
		cd $(EXPDIR); \
		datdir = '$(DATDIR)'; \
		run_exps; \
		exit;"

run_exp_matlab: mexmat $(DEPSDIR)floatp init(chop) $(DATDIR)
	$(MATLAB) -r $(EXPSTRING)


.PHONY: experiments_extra
experiments_extra: run_exp_openmp run_exp_matlab_extra

$(BINDIR)exp_openmp: $(EXPDIR)exp_openmp.c libpcg $(BINDIR)
	$(CC) $(CFLAGS) $(COPTIM) -o $@ $< $(CLIBS) $(PCG_FLAGS)

.PHONY: run_exp_openmpn
run_exp_openmp: $(DATDIR) $(BINDIR)exp_openmp
	$<
	$(MV) *.dat $(DATDIR)

.PHONY: run_exp_matlab_extra
run_exp_matlab_extra: EXPSTRING="addpath('$(BINDIR)'); \
		addpath('$(DEPSDIR)chop'); \
		addpath(genpath('$(DEPSDIR)floatp/')); \
		cd $(EXPDIR); \
		datdir = '$(DATDIR)'; \
		run_exps_extra; \
		exit;"

run_exp_matlab_extra: mexmat init(chop) $(DATDIR)
	$(MATLAB) -r $(EXPSTRING)





.PHONY: cleanall
cleanall: clean cleancpfloat cleanexp cleandat

.PHONY: clean
clean:
	$(RM) -f $(BINDIR)cpfloat*

.PHONY: cleancpfloat
cleancpfloat:
	cd $(CPFDIR); make cleanall


.PHONY: cleanexp
cleanexp:
	$(RM) -f $(BINDIR)exp_*

.PHONY: cleandat
cleandat:
	$(RM) $(DATDIR)*


# CPFloat - Custom Precision Floating-point numbers.
#
# Copyright 2020 Massimiliano Fasi and Mantas Mikaitis
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License along
# with this library; if not, write to the Free Software Foundation, Inc., 51
# Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
