function out = pchipmod(x,y,xx)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if length(x)==1
    out=ones(size(xx,1),size(xx,2))*y(1);
else
    out=pchip(x,y,xx);
end

end
