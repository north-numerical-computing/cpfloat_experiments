% SPDX-FileCopyrightText: 2020 Massimiliano Fasi and Mantas Mikaitis
% SPDX-License-Identifier: LGPL-2.1-or-later

%% Initialization
storageformats = {'single', 'double'};

%% Speedup cpfloat/chop (subnormals and binary32)
storageformat = 'single';
for generatesubnormals = [true,false]
  exp_comp_chop
end
storageformat = 'double';
generatesubnormals = true;
exp_comp_chop

%% Speedup of cpfloat/intlab (Figure 3)
exp_comp_intlab

%% Speedup cpfloat/chop, LU decomposition.
exp_lu

%% Speedup normal/subnormal in cpfloat.
for iter = 1:2
  storageformat = storageformats{iter};
  exp_normal_subnormal
end

%% Speedup cpfloat/floatp
for generatesubnormals = [true,false]
  exp_comp_floatp
end

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
