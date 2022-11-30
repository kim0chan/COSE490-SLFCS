%
% Skeleton code for COSE490 Fall 2022 Assignment 4
%
% Won-Ki Jeong (wkjeong@korea.ac.kr)
%

clear all;
close all;

%
% Loading input image
%
I=imread('building-600by600.tif');
%Img=imread('checkerboard-noisy2.tif');
Img=double(I(:,:,1));

%
% ToDo: Compute R
%
R = ...


%
% Example of collecting points and plot them
%
% (10,1), (15,2), (20,3)
%
location = [10 15 20; 1 2 3]'
points = cornerPoints(location)
plot(points)


%
% ToDo: Visualize R values using jet colormap
%

...




%
% ToDo: Threshold R & Collect Local Maximum Points
%

...


%
% Visualize corner points over the input image
%

imshow(I)

hold on

plot(points)

hold off

