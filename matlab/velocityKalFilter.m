function [ out] = velocityKalFilter( velocity,time,R,Q )
A=[1];
Xk=velocity(1);
Pk=[0];
H=[1];
Q=[Qval];
R=[Rval];
out=zeros(size(points,1),1);
for i=1:size(points,1)
    Pkm=Pk;
    Xkm=Xk;
    Xkhat=A*Xkm;
    Pk=A*Pkm*A'+Q;
    Kk=Pk*H'*inv(H*Pk*H'+R);
    Xk=Xkhat+Kk*(points(i,:)'-H*Xkhat);
    Pk=(eye(3)-Kk*H)*Pk;
    out(i,:)=Xk;
end



end

