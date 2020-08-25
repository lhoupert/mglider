function []=write_topo_cf(ncfile,z,lon,lat);
% WRITE_TOPO: Writes 2D topo/bathy data to CF compliant NetCDF file
% so we can visualized in tools like IDV
%u  Usage: write_topo_cf(ncfile,z,lon,lat);
%        ncfile = name of netcdf file for output
%         lon = longitude (west negative)
%         lat = latitude (north positive)
%         z = z dependent variable (topo grid, bathy grid)
% if pcolor(z,x,y) looks good (not flipped or rotated), then use this routine
% to write out the data to netCDF
%
nc=netcdf(ncfile,'clobber');

[ny,nx]=size(z);
% define dimensions
nc('x')=nx;
nc('y')=ny;

% define variables
nc{'z'}=ncfloat('y','x');
[m,n]=size(lon);

if(min(m,n)==1),
% lon,lat are 1D
  nc{'lon'}=ncdouble('x');
  nc{'lat'}=ncdouble('y');
else
% lon,lat are 2D
  nc{'lon'}=ncdouble('y','x');
  nc{'lat'}=ncdouble('y','x');
end
nc{'z'}.coordinates='lon lat';
nc{'lon'}.units='degree_east';
nc{'lat'}.units='degree_north';
nc{'z'}.units='meter';
nc.Conventions='CF-1.0';

% fill variables with data
nc{'lon'}(:)=lon;
nc{'lat'}(:)=lat;
nc{'z'}(:)=z;

close(nc);