function [detail] = getdetail( I,Pan )
r = 2;
e = 0.1^2;
Pan1 = guidedfilter(I, Pan, r, e);
Pan2 = guidedfilter(I, Pan1, r, e);

Detail1 = Pan-Pan1;
Detail2 = Pan1-Pan2;

detail = Detail1+Detail2;
end

