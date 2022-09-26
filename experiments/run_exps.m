% SPDX-FileCopyrightText: 2020 Massimiliano Fasi and Mantas Mikaitis
% SPDX-License-Identifier: LGPL-2.1-or-later

%% Compile cpfloat
% The following three lines are reported here just for reference, the mex
% interface can be compiled with 'make mexmat' or 'make mexoct'.
% compile_cpfloat();
% autotune_cpfloat(Inf);
% compile_cpfloat();

%% Initialization
storageformats = {'single', 'double'};

%% Speedup cpfloat/chop (Figure 2)
storageformat = 'double';
generatesubnormals = false;
exp_comp_chop

%% Speedup of cpfloat/intlab (Figure 3)
exp_comp_intlab

%% Overhead of MATLAB interface (Figure 4, second and third columns)
exp_overhead

% CPFloat - Custom Precision Floating-point numbers.
%
% Copyright 2020 Massimiliano Fasi and Mantas Mikaitis
%
% This library is free software; you can redistribute it and/or modify it under
% the terms of the GNU Lesser General Public License as published by the Free
% Software Foundation; either version 2.1 of the License, or (at your option)
% any later version.
%
% This library is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
% details.
%
% You should have received a copy of the GNU Lesser General Public License along
% with this library; if not, write to the Free Software Foundation, Inc., 51
% Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
