function [T] = CreateTransform_f(Translation,Rotation)
%TRANSFORM_F Summary of this function goes here
%   Detailed explanation goes here
T = [Rotation Translation';0 0 0 1];
end

