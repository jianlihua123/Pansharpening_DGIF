function findalph = AIHS(M,P)
[m,n,d] = size(M);

findalph = ones(d,1);

for i = 1:d
   for j = 1:d
      a(i,j) = sum(sum(M(:,:,i).*M(:,:,j)));
   end
   b(i,1) = sum(sum(P.*M(:,:,i)));
end

tau = 5;
iter = 150000;
gamma1 = 1/200000;
gamma2 = 1;

inv = (eye(d) + 2*tau*gamma1*a)^(-1);

for i = 1:iter
   findalph = inv * (findalph + 2*tau*max(-findalph,0) + 2*tau*gamma1*b);
end
